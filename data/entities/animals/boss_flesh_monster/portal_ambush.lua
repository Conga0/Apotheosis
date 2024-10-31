--dofile_once("data/scripts/lib/utilities.lua")

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local heretic_found = false
local heretic_id = nil
local h_x, h_y = nil
local boss = EntityGetInRadiusWithTag( pos_x, pos_y, 60, "miniboss" ) or {}
for bp=1,#boss do
    if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
	heretic_found = true
	heretic_id = boss[bp]
	h_x, h_y = EntityGetTransform(heretic_id)
    	local spritecomps = EntityGetComponentIncludingDisabled(heretic_id, "SpriteComponent") or {}
    	for i = 1, #spritecomps do
	    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/flesh.png" then
		EntityLoad("data/entities/animals/boss_flesh_monster/phase3/transport_emitter_flesh.xml", pos_x, pos_y)
	    else
		EntityLoad("data/entities/animals/boss_flesh_monster/transport_emitter.xml", pos_x, pos_y)
	    end
    	end
    end
end

if (heretic_found == true) then
    local ambush_x = 21247
    local ambush_y = 5892

    local ambush_locations = { {"23347", "3810"}, {"-13587", "12505"}, {"-18826", "7860"}, {"23850", "16599"}, {"-9395", "4859"}, {"-19604", "11930"} }
    --Table of potential ambush spawn locations

    SetRandomSeed(444,777)
    local num = Random(1,6)
    ambush_x = ambush_locations[num][1]
    ambush_y = ambush_locations[num][2]

    --debug sound cue since it plays anywhere
    --GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use", ambush_x, ambush_y )

    EntityApplyTransform( heretic_id, ambush_x, ambush_y )

    EntityAddComponent(heretic_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance_end.lua",
	execute_every_n_frame=2,
	remove_after_executed=1,
    }) 

    EntityLoad( "data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief.xml", ambush_x, ambush_y )

    local spritecomps = EntityGetComponentIncludingDisabled(heretic_id, "SpriteComponent") or {}
    if #spritecomps > 0 then
	for i = 1, #spritecomps do
	    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/flesh.png" then
		EntityLoad("data/entities/animals/boss_flesh_monster/phase3/transport_emitter_flesh.xml", ambush_x, ambush_y)
	    else
		EntityLoad("data/entities/animals/boss_flesh_monster/transport_emitter.xml", ambush_x, ambush_y)
	    end
	 end
    end
end

EntityKill(entity_id)    