
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
local pos_x, pos_y = EntityGetTransform(entity_id)
local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if currbiome == "$biome_lava_excavation" then
    if parent == 0 then
	EntityAddComponent( entity_id, "LuaComponent",
	{
	    script_source_file="mods/Apotheosis/files/scripts/items/egg_volcanic_lukki_convert.lua",
	    execute_every_n_frame="180",
	})
    end

    local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
    ComponentSetValue2( itemcomp, "ui_description", "$item_apotheosis_egg_fire_lukki_desc_alt")
end
