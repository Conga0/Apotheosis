
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 

EntityAddComponent2(
    player,
    "LuaComponent",
    {
        execute_every_n_frame = -1,
        script_death  = "data/scripts/items/drop_money.lua",
        remove_after_executed = true
    }
)
