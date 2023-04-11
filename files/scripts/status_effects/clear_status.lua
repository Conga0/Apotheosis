dofile_once("data/scripts/status_effects/status_list.lua")

local entity_id = EntityGetParent(GetUpdatedEntityID())

for k=1,#status_effects
do local v = status_effects[k]
    if v.is_harmful == true then
        EntityRemoveIngestionStatusEffect( entity_id, v.id )
        --Debugging Prints
        --GamePrint("My current Cleanse target is " .. v.id)
        --GamePrint("PlayerID is " .. EntityGetWithTag("player_unit")[1])
        --GamePrint("EntityID is " .. entity_id)
    end
end
