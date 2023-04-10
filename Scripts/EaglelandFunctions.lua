-- EaglelandFunctions
-- Author: Anagram
-- DateCreated: 4/9/2023 10:52:38 PM
--------------------------------------------------------------

--breaking away from Hungarian notation, you will NOT take me back!
GLOBAL_EAGLELAND_SUZERAINS = ReadCustomData("GRAM_EAGLELAND_SUZERAINS") or {}
GLOBAL_FREE_CITY_STATES = ReadCustomData("GRAM_FREE_CITY_STATES") or {}

--GLOBAL_EAGLELAND = GameInfo.Civilizations["CIVILIZATION_GRAM_EAGLELAND"]

function IsEagleland(id)
	return PlayersConfigurations[id]:GetCivilizationTypeName() == "CIVILIZATION_GRAM_EAGLELAND"
end

function UpdateSuzerainStatus()
	for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do
		
		local player = Players[i]
		if GLOBAL_FREE_CITY_STATES[i] and not player:IsAlive() then
			GLOBAL_FREE_CITY_STATES[i] = nil
		end

		if player:IsAlive() and not(player:IsFreeCities() or player:IsMajor() or player:IsBarbarian()) then
			if Players[player:GetInfluence():GetSuzerain()]and GLOBAL_FREE_CITY_STATES[i] then
				print("City-State has Suzerain. Removing from list")
				GLOBAL_FREE_CITY_STATES[i] = nil
			elseif not (Players[player:GetInfluence:GetSuzerain] and GLOBAL_FREE_CITY_STATES[i]) then
				print("City-State has lost its Suzerain. Adding to list")
				GLOBAL_FREE_CITY_STATES[i] = Game.GetCurrentGameTurn()
			end
		end
	end
	WriteCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
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
			for k, v in pairs(GLOBAL_FREE_CITY_STATES)
				local cityState = Players[k]
					if Game.GetCurrentGameTurn() - v >= 5 and player:GetDiplomacy:HasMet(k) then
						numSuzerainsToGive = numSuzerainsToGive - 1

						local tokens = 0
						while not Players[cityState():GetInfluence():GetSuzerain()] do
							player:GetInfluence():GiveFreeTokenToPlayer(k)
							tokens = tokens + 1
						end
						GLOBAL_EAGLELAND_SUZERAINS[id][k] = tokens
					end
				if numSuzerainsToGive <= 0 then break end
			end
		end
	end
end
							
function InitNewGame()
	for i = 0, GameDefines.MAX_CIV_PLAYERS-1, 1 do
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

	WriteCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)
	WriteCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
	WriteCustomData("GRAM_EAGLELAND_INIT", true)
end

if not ReadCustomData("GRAM_EAGLELAND_INIT") then InitNewGame() end
