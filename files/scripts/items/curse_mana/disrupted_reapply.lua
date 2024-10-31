
local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )
local count = 0

local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
for k=1,#comps
do v = comps[k]
    if ComponentGetValue2(v,"script_damage_received") == "mods/Apotheosis/files/scripts/items/curse_mana/curse_mana_disrupt.lua" then
        count = count + 1
    end
end

if count <= 0 then
	EntityAddComponent( entity_who_picked, "LuaComponent", 
	{ 
		execute_every_n_frame=-1,
		script_damage_received="mods/Apotheosis/files/scripts/items/curse_mana/curse_mana_disrupt.lua",
		remove_after_executed=0,
	})
end