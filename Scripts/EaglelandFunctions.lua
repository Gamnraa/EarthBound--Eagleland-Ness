-- EaglelandFunctions
-- Author: Anagram
-- DateCreated: 4/9/2023 10:52:38 PM
--------------------------------------------------------------
TSL = {} 

--breaking away from Hungarian notation, you will NOT take me back!
GLOBAL_EAGLELAND_SUZERAINS = {}
GLOBAL_FREE_CITY_STATES = {}

--GLOBAL_EAGLELAND = GameInfo.Civilizations["CIVILIZATION_GRAM_EAGLELAND"]

function IsEagleland(id)
	return PlayersConfigurations[id]:GetCivilizationTypeName() == "CIVILIZATION_GRAM_EAGLELAND"
end

function UpdateSuzerainStatus()
	for i = 20, GameDefines.MAX_PLAYERS-1, 1 do
		
		local player = Players[i]
		if GLOBAL_FREE_CITY_STATES[i] and not player:IsAlive() then
			GLOBAL_FREE_CITY_STATES[i] = nil
		end

		if player:IsAlive() and not(player:IsFreeCities() or player:IsMajor() or player:IsBarbarian()) then
			if Players[player:GetInfluence():GetSuzerain()]and GLOBAL_FREE_CITY_STATES[i] then
				print("City-State has Suzerain. Removing from list")
				GLOBAL_FREE_CITY_STATES[i] = nil

			elseif not (Players[player:GetInfluence():GetSuzerain()] and GLOBAL_FREE_CITY_STATES[i]) then
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

	local player = Players[id]
	if IsEagleland(id) then
		UpdateSuzerainStatus()

		local cities = player:GetCities()
		if #cities > #GLOBAL_EAGLELAND_SUZERAINS[id] then
			print("Checking if Eagleland can receive a City-State")
			local cityStates = GLOBAL_FREE_CITY_STATES
			--Rules: Eagleland must have met the city-state
			--Current game turn - turn city-state added to GLOBAL_FREE_CITY_STATES >= 5
			local numSuzerainsToGive = #cities - #GLOBAL_EAGLELAND_SUZERAINS[id]
			for k, v in pairs(GLOBAL_FREE_CITY_STATES) do
				local cityState = Players[k]
				if Game.GetCurrentGameTurn() - v >= 5 and player:GetDiplomacy():HasMet(k) then
					numSuzerainsToGive = numSuzerainsToGive - 1

					local tokens = 0
					while not Players[cityState:GetInfluence():GetSuzerain()] do
						player:GetInfluence():GiveFreeTokenToPlayer(k)
						tokens = tokens + 1
					end
					GLOBAL_EAGLELAND_SUZERAINS[id][k] = tokens
				end
				if numSuzerainsToGive <= 0 then break end
			end

			TSL.WriteMyCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)
		end
	end
end
							
function InitNewGame()
	TSL = ExposedMembers.GRAM_EAGLELAND
	GLOBAL_EAGLELAND_SUZERAINS = TSL.ReadMyCustomData("GRAM_EAGLELAND_SUZERAINS") or {}
	GLOBAL_FREE_CITY_STATES = TSL.ReadMyCustomData("GRAM_FREE_CITY_STATES") or {}
	if TSL.ReadMyCustomData("GRAM_EAGLELAND_INIT") then return end
	for i = 0, GameDefines.MAX_PLAYERS-1, 1 do
		local player = Players[i]
		if player:WasEverAlive() and player:IsAlive() then
			if IsEagleland(i) then
				GLOBAL_EAGLELAND_SUZERAINS[i] = {}
			end
		
			if not(player:IsFreeCities() or player:IsMajor() or player:IsBarbarian()) then
				GLOBAL_FREE_CITY_STATES[i] = Game.GetCurrentGameTurn()
			end
		end
	end

	if #GLOBAL_EAGLELAND_SUZERAINS > 0 then
		--TODO Hook our functions
		GameEvents.PlayerTurnStarted.Add(OnEaglelandStartTurn)
	end

	TSL.WriteMyCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)
	TSL.WriteMyCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
	TSL.WriteMyCustomData("GRAM_EAGLELAND_INIT", true)
end

Events.LoadScreenClose.Add(InitNewGame)
