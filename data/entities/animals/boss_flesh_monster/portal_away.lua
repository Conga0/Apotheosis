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
	EntityKill(heretic_id)
    end
end

if (heretic_found == true) then
    local prison_x = 21247
    local prison_y = 5892
    if GameHasFlagRun("apotheosis_downunder") or GameHasFlagRun("apotheosis_everything") then
	prison_x = 21760
	prison_y = 9991
    elseif tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 then
	prison_x = 21246
	prison_y = 7938
    else
	prison_x = 21247
	prison_y = 5892
    end
    EntityLoad( "mods/apotheosis/files/entities/misc/spawn_boss_flesh_monster.xml", prison_x, prison_y )

    local telecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "TeleportComponent")

    EntitySetComponentIsEnabled(entity_id, telecomp, true)

    ComponentSetValue2(telecomp, "target", prison_x, prison_y+200)

    local safe_mode = false

    local player_id = EntityGetWithTag("player_unit")[1]
    targ_x, targ_y = EntityGetTransform(player_id)

    local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()

    local range = cam_h / 2

    local a_x = pos_x - targ_x
    local a_y = pos_y - targ_y

    local distance = get_magnitude(a_x, a_y)
    if ( distance > range ) then
	--oh no! the player likely cannot see this nonsense transpiring!
	--let's cool things down a bit so they can see the portal before it disappears
	safe_mode = true
    end

    if safe_mode == false then
	EntityAddComponent(entity_id, "LifetimeComponent", {
	    lifetime=7200,
	    fade_sprites=1,
	})

	EntityAddComponent(entity_id, "LuaComponent", {
	    script_source_file="data/entities/animals/boss_flesh_monster/portal_fade.lua",
	    execute_every_n_frame=1,
	}) 
    else
	EntityAddComponent(entity_id, "LuaComponent", {
	    script_source_file="data/entities/animals/boss_flesh_monster/portal_find_player.lua",
	    execute_every_n_frame=2,
	}) 
    end

    local minions = EntityGetInRadiusWithTag( pos_x, pos_y, 500, "touchmagic_immunity" ) or {}
    for m=1,#minions do
	if EntityGetName(minions[m]) == "Korruptoitunut Mestari" then
    	    EntityKill(minions[m])
	end
    end

    --Was gonna use this to make it so dormant Heretic disappears when he teleports but he'd be gone anyway :p
    --GameAddFlagRun( "apotheosis_miniboss_boss_flesh_monster_portal" )
else
    EntityKill(entity_id)
end

    