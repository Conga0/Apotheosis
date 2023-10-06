
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local filepath = GlobalsGetValue( "apotheosis_bat_filepath", "data/entities/animals/bat.xml" )
EntityLoad(filepath,x,y)