-- DataPersistence
-- Author: 
-- DateCreated: 4/10/2023 11:54:12 AM
--------------------------------------------------------------
include("Civ6Common")

ExposedMembers.GRAM_EAGLELAND = {}

function WriteMyCustomData(TableStringKey, TableValue)
    WriteCustomData(TableStringKey, TableValue)
end

function ReadMyCustomData(TableStringKey)
    local MyDatatable = ReadCustomData(TableStringKey)
    return MyDatatable
end

ExposedMembers.GRAM_EAGLELAND.WriteMyCustomData = WriteMyCustomData
ExposedMembers.GRAM_EAGLELAND.ReadMyCustomData = ReadMyCustomData

function ChangeMyDiplomaticFavor(player, amount)
	player:ChangeDiplomaticFavor(amount)
end

ExposedMembers.GRAM_EAGLELAND.ChangeMyDiplomaticFavor = ChangeMyDiplomaticFavor

MAP_X, MAP_Y = Map.GetGridSize()

local naturalWonders = {}
local naturalWonderPlots = {}

for _, row in pairs(DB.Query("SELECT * FROM Features WHERE NaturalWonder = '1'")) do
	for k, v in pairs(row) do 
		print(k, v)
	end
	naturalWonders[row.FeatureType] = true
end

function MapSweep()
	for x = 0, MAP_X - 1, 1 do
		for y = 0, MAP_Y - 1, 1 do
			local plot = Map.GetPlot(x, y)
			if plot then
				for k, _ in pairs(naturalWonders) do
					if GameInfo.Features[k].Index == plot:GetFeatureType() then
						print("Plot has a natural wonder, adding to list")
						table.insert(naturalWonderPlots, plot)
					end
				end
			end
		end
	end
end
MapSweep()
	
WriteMyCustomData("GRAM_NATURAL_WONDER_PLOTS", naturalWonderPlots)			

