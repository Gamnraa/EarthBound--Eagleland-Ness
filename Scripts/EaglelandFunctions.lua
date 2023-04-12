-- EaglelandFunctions
-- Author: Anagram
-- DateCreated: 4/9/2023 10:52:38 PM
--------------------------------------------------------------
TSL = {} 

--breaking away from Hungarian notation, you will NOT take me back!
GLOBAL_EAGLELAND_SUZERAINS = {}
GLOBAL_FREE_CITY_STATES = {}

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
	return PlayerConfigurations[id]:GetCivilizationTypeName() == "CIVILIZATION_GRAM_EAGLELAND"
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

function OnEaglelandStartTurn(id)
	if not Players[id]:IsAlive() then return end

	local eagleland = Players[id]
	if IsEagleland(id) then
		UpdateSuzerainStatus()
	
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
		end
	end
end

function OnEaglelandDiscoverNaturalWonder()
	--Fun fact, I gave this no params because none pushed by the event are the player that discovered them
	--I'll be real, no clue how we'll handle AI players finding natural wonders
	--Thanks Firaxis
	print("Eagleland Natural Wonder")
	local player = Players[Game.GetLocalPlayer()]
	if not (player and IsEagleland(Game.GetLocalPlayer())) then return end
	
	local bonus = math.floor(50 * GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100)

	player:GetCulture():ChangeCurrentCulturalProgress(bonus)
	player:ChangeDiplomaticFavor(bonus)
	
end
							
function InitGame()
	TSL = ExposedMembers.GRAM_EAGLELAND
	GLOBAL_EAGLELAND_SUZERAINS = TSL.ReadMyCustomData("GRAM_EAGLELAND_SUZERAINS") or {}
	GLOBAL_FREE_CITY_STATES = TSL.ReadMyCustomData("GRAM_FREE_CITY_STATES") or {}


	if TSL.ReadMyCustomData("GRAM_EAGLELAND_INIT") then 
		if GetTableLength(GLOBAL_EAGLELAND_SUZERAINS) > 0 then
			GameEvents.PlayerTurnStarted.Add(OnEaglelandStartTurn)
			--Events.NaturalWonderRevealed.Add(OnEaglelandDiscoverNaturalWonder)
		end
		return 
	end

	for i = 0, GameDefines.MAX_PLAYERS-3, 1 do
		local player = Players[i]
		if player:WasEverAlive() and player:IsAlive() then
			print(IsEagleland(i))
			if IsEagleland(i) then
				GLOBAL_EAGLELAND_SUZERAINS[i] = {}
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
		--Events.NaturalWonderRevealed.Add(OnEaglelandDiscoverNaturalWonder)
	end

	TSL.WriteMyCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)
	TSL.WriteMyCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
	TSL.WriteMyCustomData("GRAM_EAGLELAND_INIT", true)
end


if GetTableLength(GLOBAL_EAGLELAND_SUZERAINS) > 0 then
	--TODO Hook our functions
	GameEvents.PlayerTurnStarted.Add(OnEaglelandStartTurn)
	--Events.NaturalWonderRevealed.Add(OnEaglelandDiscoverNaturalWonder)
end

Events.LoadScreenClose.Add(InitGame)
