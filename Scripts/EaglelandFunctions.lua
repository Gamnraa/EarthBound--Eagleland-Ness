-- EaglelandFunctions
-- Author: Anagram
-- DateCreated: 4/9/2023 10:52:38 PM
--------------------------------------------------------------

--breaking away from Hungarian notation, you will NOT take me back!
GLOBAL_EAGLELAND_SUZERAINS = ReadCustomData("GRAM_EAGLELAND_SUZERAINS") or {}
GLOBAL_FREE_CITY_STATES = ReadCustomData("GRAM_FREE_CITY_STATES") or {}

--GLOBAL_EAGLELAND = GameInfo.Civilizations["CIVILIZATION_GRAM_EAGLELAND"]

function IsEagleland(id)
	return PlayersConfigurations[id]:GetCivilizationTypeName() == CIVILIZATION_GRAM_EAGLELAND
end

function InitNewGame()
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
	end

	WriteCustomData("GRAM_EAGLELAND_SUZERAINS", GLOBAL_EAGLELAND_SUZERAINS)
	WriteCustomData("GRAM_FREE_CITY_STATES", GLOBAL_FREE_CITY_STATES)
	WriteCustomData("GRAM_EAGLELAND_INIT", true)
end

if not ReadCustomData("GRAM_EAGLELAND_INIT") then InitNewGame() end
