-- EaglelandFunctions
-- Author: Anagram
-- DateCreated: 4/9/2023 10:52:38 PM
--------------------------------------------------------------
TSL = {} 

--breaking away from Hungarian notation, you will NOT take me back!
GLOBAL_EAGLELAND_SUZERAINS = {}
GLOBAL_FREE_CITY_STATES = {}
GLOBAL_NATURAL_WONDERS = {}
GLOBAL_NATURAL_WONDER_OWNERS = {}
GLOBAL_NATURAL_WONDERS_FOUND = {}

--GLOBAL_EAGLELAND = GameInfo.Civilizations["CIVILIZATION_GRAM_EAGLELAND"]
function GetTableLength(t)
	--# seems to returns length - 1
	--AND 0 if empty so yeah that won't work
	local i = 0
	for _, _ in pairs(t) do
		i = i + 1
	end
	return i
end



function IsEagleland(id)
	return PlayerConfigurations[id] and PlayerConfigurations[id]:GetCivilizationTypeName() == "CIVILIZATION_GRAM_EAGLELAND"
end



function UpdateSuzerainStatus()
	for _, i in pairs(PlayerManager.GetAliveMinorIDs()) do
		
		local player = Players[i]
		if GLOBAL_FREE_CITY_STATES[i] and not player:IsAlive() then
			GLOBAL_FREE_CITY_STATES[i] = nil
		end

		if player:IsAlive() then
			if Players[player:GetInfluence():GetSuzerain()]and GLOBAL_FREE_CITY_STATES[i] then
				print("City-State has Suzerain. Removing from list")
				GLOBAL_FREE_CITY_STATES[i] = nil

			elseif not (Players[player:GetInfluence():GetSuzerain()] or GLOBAL_FREE_CITY_STATES[i]) then
				print("City-State has lost its Suzerain. Adding to list")
				GLOBAL_FREE_CITY_STATES[i] = Game.GetCurrentGameTurn()
				--If the Suzerain was Eagleland remove them from that list
				for _, v in pairs(GLOBAL_EAGLELAND_SUZERAINS) do
					if v[i] then v[i] = nil end
				end
			end
		end
	end
	TSL.WriteMyCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
end



function NaturalWondersOwnerCheck()
	for _, index in pairs(GLOBAL_NATURAL_WONDERS) do
		local plot = Map.GetPlotByIndex()
		local id = plot:GetOwner()
		if IsEagleland(id) and (GLOBAL_NATURAL_WONDER_OWNERS and not GLOBAL_NATURAL_WONDER_OWNERS[id][index]) then
			print("Eagleland acquired new Natural Wonder")
			GLOBAL_NATURAL_WONDER_OWNERS[id][index] = true

			--8 / (TotalNaturalWonders / NumPlayerOwnedNaturalWonders) = bonus

		elseif not IsEagleland(id) then
			for _, v in pairs(GLOBAL_NATURAL_WONDER_OWNERS) do
				if v[index] then
					print("Eagleland lost Natural Wonder")
					v[index] = nil
				end
			end
		end

		--for eaglelandId, _ in pairs(GLOBAL_NATURAL_WONDERS_FOUND) do
			local playerVisibility = PlayersVisibility[0]
			print(playerVisibility:IsRevealed(index), (not GLOBAL_NATURAL_WONDERS_FOUND[0][plot:GetFeatureType()]))
			if playerVisibility:IsRevealed(index) and not GLOBAL_NATURAL_WONDERS_FOUND[0][plot:GetFeatureType()] then
				print("Natural Wonder found that did not fire event hook")
				OnEaglelandDiscoverNaturalWonder(nil, nil, plot:GetFeatureType())
			end
		--end

		--Logic for setting bonuses go here
		
	end
end


--Here's our order:
--Update which city-states have Suzerains
--Attempt to apply Eagleland's bonus
--Check for Natural Wonders
function OnEaglelandStartTurn(id)
	if not Players[id]:IsAlive() then return end

	local eagleland = Players[id]
	if IsEagleland(id) then
		UpdateSuzerainStatus()
		
		if not GLOBAL_NATURAL_WONDER_OWNERS[id] then GLOBAL_NATURAL_WONDER_OWNERS[id] = {} end

		local numCities = eagleland:GetCities():GetCount()
		print(numCities, #GLOBAL_EAGLELAND_SUZERAINS[id])
		if numCities > GetTableLength(GLOBAL_EAGLELAND_SUZERAINS[id]) then
			print("Checking if Eagleland can receive a City-State")
			local cityStates = GLOBAL_FREE_CITY_STATES
			--Rules: Eagleland must have met the city-state
			--Current game turn - turn city-state added to GLOBAL_FREE_CITY_STATES >= 5
			local numSuzerainsToGive = numCities - GetTableLength(GLOBAL_EAGLELAND_SUZERAINS[id])
			for k, v in pairs(GLOBAL_FREE_CITY_STATES) do
				local cityState = Players[k]
				if not cityState:IsAlive() then
					GLOBAL_FREE_CITY_STATES[k] = nil
				else
					if Game.GetCurrentGameTurn() - v >= 5 and eagleland:GetDiplomacy():HasMet(k) then
						numSuzerainsToGive = numSuzerainsToGive - 1

						local tokens = 0
						while not Players[cityState:GetInfluence():GetSuzerain()] do
							eagleland:GetInfluence():GiveFreeTokenToPlayer(k)
							tokens = tokens + 1
						end
						GLOBAL_EAGLELAND_SUZERAINS[id][k] = tokens
					end
				end

				if numSuzerainsToGive <= 0 then break end
			end

			TSL.WriteMyCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)

			NaturalWondersOwnerCheck()
		end
	end
end



function OnEaglelandDiscoverNaturalWonder(x, y, featureType)
	--Fun fact, I gave this no params because none pushed by the event are the player that discovered them
	--I'll be real, no clue how we'll handle AI players finding natural wonders
	--Thanks Firaxis
	--Also fun fact if you start the game with a Natural Wonder in view
	--This function will not trigger and you get no bonuses fuck you
	print("Eagleland Natural Wonder found", featureType)
	--My solution is just to make it so all Eagleland players get the bonus
	--Since this will only call once for every Wonder I believe
	local bonus = math.floor(50 * GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100)
	for i, _ in pairs(GLOBAL_EAGLELAND_SUZERAINS) do
		if not GLOBAL_NATURAL_WONDERS_FOUND[i][featuretype] and Players[i]:IsAlive() then
			Players[i]:GetCulture():ChangeCurrentCulturalProgress(bonus)
			Players[i]:AttachModifierByID("GRAM_NESS_GIVE_DIPLO_FAVOR")
			GLOBAL_NATURAL_WONDERS_FOUND[i][featureType] = true
		end
	end
	TSL.WriteMyCustomData("GRAM_NATURAL_WONDERS_FOUND", GLOBAL_NATURAL_WONDERS_FOUND)
end


							
function InitGame()
	TSL = ExposedMembers.GRAM_EAGLELAND
	GLOBAL_EAGLELAND_SUZERAINS = TSL.ReadMyCustomData("GRAM_EAGLELAND_SUZERAINS") or {}
	GLOBAL_FREE_CITY_STATES = TSL.ReadMyCustomData("GRAM_FREE_CITY_STATES") or {}
	GLOBAL_NATURAL_WONDERS = TSL.ReadMyCustomData("GRAM_NATURAL_WONDERS") 
	GLOBAL_NATURAL_WONDERS_FOUND = TSL.ReadMyCustomData("GRAM_NATURAL_WONDERS_FOUND") or {}



	if TSL.ReadMyCustomData("GRAM_EAGLELAND_INIT") then 
		if GetTableLength(GLOBAL_EAGLELAND_SUZERAINS) > 0 then
			GameEvents.PlayerTurnStarted.Add(OnEaglelandStartTurn)
			Events.NaturalWonderRevealed.Add(OnEaglelandDiscoverNaturalWonder)
		end
		return 
	end

	for i = 0, GameDefines.MAX_PLAYERS-3, 1 do
		local player = Players[i]
		if player:WasEverAlive() and player:IsAlive() then
			print(IsEagleland(i))
			if IsEagleland(i) then
				GLOBAL_EAGLELAND_SUZERAINS[i] = {}
				GLOBAL_NATURAL_WONDERS_FOUND[i] = {}
			end
		
			if not player:IsMajor() then
				GLOBAL_FREE_CITY_STATES[i] = Game.GetCurrentGameTurn()
			end
		end
	end 
	print(#GLOBAL_EAGLELAND_SUZERAINS)

	if GetTableLength(GLOBAL_EAGLELAND_SUZERAINS) > 0 then
		--TODO Hook our functions
		GameEvents.PlayerTurnStarted.Add(OnEaglelandStartTurn)
		Events.NaturalWonderRevealed.Add(OnEaglelandDiscoverNaturalWonder)
	end

	TSL.WriteMyCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)
	TSL.WriteMyCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
	TSL.WriteMyCustomData("GRAM_NATURAL_WONDERS_FOUND", GLOBAL_NATURAL_WONDERS_FOUND)
	TSL.WriteMyCustomData("GRAM_EAGLELAND_INIT", true)
end



if GetTableLength(GLOBAL_EAGLELAND_SUZERAINS) > 0 then
	--TODO Hook our functions
	GameEvents.PlayerTurnStarted.Add(OnEaglelandStartTurn)
	--Events.NaturalWonderRevealed.Add(OnEaglelandDiscoverNaturalWonder)
end

Events.LoadScreenClose.Add(InitGame)
