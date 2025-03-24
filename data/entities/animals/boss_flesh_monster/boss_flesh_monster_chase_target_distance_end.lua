--dofile_once("data/scripts/lib/utilities.lua")

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local players = EntityGetWithTag( "player_unit" )
local player_id = players[1]

local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
local limbstate = ComponentGetValue2(limbbosscomp, "state")

if player_id ~= nil then
    local p_x, p_y = EntityGetTransform(player_id)
    local dis_x = p_x - pos_x
    local dis_y = p_y - pos_y

    local distance = get_magnitude(dis_x, dis_y)

    --GamePrint("distance: " .. distance )
if distance <= 800 then
    ComponentSetValue2(limbbosscomp, "state", 1)

    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
    --[[
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua" then
	    EntitySetComponentIsEnabled(entity_id, luacomps[i], true)
	end
    ]]--
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_ambush.lua" then
	    EntityRemoveComponent(entity_id, luacomps[i])
	end
    end

    local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
    ComponentSetValue2(cellcomp, "radius", 60)

    EntitySetComponentsWithTagEnabled(entity_id, "invincible", true)

    --The stuff below here makes it so if Heretic were at 0 hp he would heal to max health if left for 10 minutes
    --May be a little outrageous but this is meant to be a punishment phase anyhow
    local frame = GameGetFrameNum()
    local flee_frame = tonumber(GlobalsGetValue("HERETIC_FLEE_FRAME"))

    local time = 36000 --10 minutes
    local flee_time = frame - flee_frame
    local heal_mult = flee_time / time
    if flee_time >= time then
	heal_mult = 1
    end

    --[[
    print("flee_time: " .. tostring(flee_time))
    print("heal_mult: " .. tostring(heal_mult))
    ]]--

    local max_hp = 0         
    local hp = 0
    local damagecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "DamageModelComponent" ) 
    max_hp = ComponentGetValue2( damagecomp, "max_hp" )
    hp = ComponentGetValue2( damagecomp, "hp" )

    local heal = max_hp * heal_mult

    print("heal: " .. tostring(heal))

    if (hp + heal) >= max_hp then
	ComponentSetValue2( damagecomp, "hp", max_hp )
    else
	ComponentSetValue2( damagecomp, "hp", hp + heal )
    end

    local audioloopcomps = EntityGetComponentIncludingDisabled(entity_id, "AudioLoopComponent") or {}
    for i = 1, #audioloopcomps do
	if ComponentGetValue2(audioloopcomps[i], "event_name") == "mocreeps_audio/animals/boss_flesh_monster/chase_movement_loop" then
	    EntityRemoveComponent(entity_id, audioloopcomps[i])
	end
    end

    local c = EntityGetAllChildren( entity_id )
    if c ~= nil then
    for a,b in ipairs( c ) do
    	if EntityHasTag( b, "acid" ) then
    	    local particlename = EntityGetName( b )
    	    if ( particlename == "chase_particles" ) then
        	EntityKill( b )
    	    end
        end
    end
    end

    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/deaggro", pos_x, pos_y )

    local physcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent")
    --This just abruptly disabled in the middle of testing, so uh... that's not good, I'll just put this here...
    local free_static = ComponentGetValue2(physcomp, "free_if_static")
    if free_static == false then
	ComponentSetValue2(physcomp, "free_if_static", true)
    end

    local f_coeff = ComponentGetValue2(physcomp, "force_coeff")
    if f_coeff == 70 then
	local varcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
	local phase = ComponentGetValue2( varcomp, "value_int" )
	local fleshy = false
	local fvalue = 32

	local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
	if spritecomp ~= nil and ComponentGetValue2( spritecomp, "image_file" ) == "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/flesh.png" then
	    fleshy = true
	end

	if fleshy then
	    if phase == 1 or phase == 2 then
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		    fvalue = 50
		else
		    fvalue = 32
		end
	    elseif phase == 3 then
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		    fvalue = 60
		else
		    fvalue = 48
		end
	    elseif phase == 4 then
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		    fvalue = 60
		else
		    fvalue = 32
		end
	    end
	else
	    if phase == 1 then
		fvalue = 16
	    elseif phase == 2 or phase == 4 then
		fvalue = 24
	    elseif phase == 3 then
		fvalue = 48
	    end
	end
	ComponentSetValue2(physcomp, "force_coeff", fvalue )
    end

    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )

    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id, comp_id)

elseif distance >= 4096 then
--If the Heretic is 8 biome chunks or more away from the player

    local physcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent")
    local f_coeff = ComponentGetValue2(physcomp, "force_coeff")
    if f_coeff ~= 70 then
	ComponentSetValue2(physcomp, "force_coeff", 70 )
    end

  if GameHasFlagRun("apotheosis_flesh_boss_stone_converted") then
    --GamePrint("seems legit")

    local plane_locations = { {"22790", "2400"}, {"-12538", "13613"}, {"-17146", "6445"}, {"23302", "14637"}, {"-11514", "4397"}, {"-18170", "11565"} }
    --Table of potential portal spawn locations

    SetRandomSeed(444,777)
    local num = Random(1,6)
    local plane_x = plane_locations[num][1]
    local plane_y = plane_locations[num][2]

    --Checks to see how far the player is from the planes portal
    local pdis_x = p_x - plane_x
    local pdis_y = p_y - plane_y

    local pdistance = get_magnitude(pdis_x, pdis_y)

    --Checks to see how far Heretic is from the planes portal
    local hdis_x = pos_x - plane_x
    local hdis_y = pos_y - plane_y

    local hdistance = get_magnitude(hdis_x, hdis_y)

    --If the player is 10 biome chunks close to the portal and heretic is 7 biome chunks or more away from it, then begin ambush
    if pdistance <= 5120 then
    --GamePrint("hdistance: " .. hdistance)
	if hdistance >= 3584 then
	--GamePrint("heretic is far")
	    if limbstate == 5 then
		ComponentSetValue2(limbbosscomp, "state", 1)
		EntityAddComponent(entity_id, "LuaComponent", {
		    script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_ambush.lua",
		    execute_every_n_frame=600,
		}) 
	    end
        elseif hdistance < 3584 then
            --If Heretic's near the portal then he likely already ambushed and so we should go back to chasing
	    if limbstate == 1 then
		ComponentSetValue2(limbbosscomp, "state", 5)

		local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
		EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )

		local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
		for i = 1, #luacomps do
		    if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_ambush.lua" then
			EntityRemoveComponent(entity_id, luacomps[i])
		    end
	        end
	    end
        end
    end
  end
else
    --Every 20 seconds try to get Heretic to move cause they stop sometimes if the player doesn't move...
    --Fun Fact: This same thing happens to Kolmisilma when they're chasing you : )
    if GameGetFrameNum() % 40 then
	ComponentSetValue2(limbbosscomp, "state", 1)
    end
    if limbstate == 1 then
	ComponentSetValue2(limbbosscomp, "state", 5)

	local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
	EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )

	local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
	for i = 1, #luacomps do
	    if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_ambush.lua" then
		EntityRemoveComponent(entity_id, luacomps[i])
	    end
        end
    end
end
else
    ComponentSetValue2(limbbosscomp, "state", 1)
end