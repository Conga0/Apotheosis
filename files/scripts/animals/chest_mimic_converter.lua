local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if currbiome == "$biome_underwater" then
	local eid = EntityLoad( "data/entities/animals/sunken_cave/chest_mimic.xml", pos_x, pos_y )
	EntityLoad( "mods/Apotheosis/files/entities/particles/image_emitters/chest_clam_convert.xml", pos_x, pos_y )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	if ( Random(1,2) == 1 ) then
		local spritecomp = EntityGetFirstComponentIncludingDisabled(eid, "SpriteComponent")
		ComponentSetValue2(spritecomp, "image_file", "mods/Apotheosis/files/enemies_gfx/chest_mimic_clam_alt.xml")
		EntityAddComponent2(eid, "LuaComponent", {
			script_death="mods/Apotheosis/files/scripts/animals/chest_mimic_clam_death.lua",
			execute_every_n_frame=-1,
		})
	end
	EntityKill(entity_id)
end