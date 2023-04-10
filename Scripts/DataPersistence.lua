-- DataPersistence
-- Author: 
-- DateCreated: 4/10/2023 11:54:12 AM
--------------------------------------------------------------
include("Civ6Common");

ExposedMembers.GRAM_EAGLELAND = {}

function WriteMyCustomData(TableStringKey, TableValue)
    WriteCustomData(TableStringKey, TableValue);
end

function ReadMyCustomData(TableStringKey)
    local MyDatatable = ReadCustomData(TableStringKey);
    return MyDatatable;
end

ExposedMembers.GRAM_EAGLELAND.WriteMyCustomData = WriteMyCustomData;
ExposedMembers.GRAM_EAGLELAND.ReadMyCustomData = ReadMyCustomData;