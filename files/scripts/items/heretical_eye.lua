
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then
    
    local incarncomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
    local mode = ComponentGetValue2( incarncomp, "value_string")
    if mode == "homesick" then
        local pos_x, pos_y = EntityGetTransform(entity_id)
        local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
        local radius = math.floor((cam_w / 4) * 4.5)
        if #EntityGetInRadiusWithTag( pos_x, pos_y, radius, "player_unit" ) ~= 0 then
            local bodycomp = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsBodyComponent")
	    local shapecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsImageShapeComponent")
	    local projectilecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
	    EntitySetComponentIsEnabled(entity_id,bodycomp,false)
	    EntitySetComponentIsEnabled(entity_id,shapecomp,false)
	    EntitySetComponentIsEnabled(entity_id,projectilecomp,false)
	    local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
	    EntitySetComponentIsEnabled(entity_id,spritecomp,false)
	    ComponentSetValue2( incarncomp, "value_string", "")
        end
    end

    local eye = EntityGetAllChildren(entity_id)[1]
    if EntityGetComponent(eye, "SpriteComponent", "enabled_in_world") == nil then
        EntitySetComponentsWithTagEnabled(eye,"enabled_in_world",true)
    end

    --Disables the lua component so it doesn't keep run unnecessarily
    --Sorry, but you're under new management now >:) -Spoop
    --local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
    --EntitySetComponentIsEnabled(entity_id,comp,false)

    --If Heretic has too many chunks taken out of him, then enter a regeneration state where you then respawn yourself
    local bodycomp = EntityGetFirstComponent( entity_id, "PhysicsBodyComponent" )
    if bodycomp ~= nil then
	local body_amount = ComponentGetValue2( bodycomp, "mPixelCount")
	if body_amount <= 160 then
	    --Enable particles and make sure he can't get picked up
	    EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true)
	    local itemcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "ItemComponent" )
	    EntitySetComponentIsEnabled( entity_id, itemcomp, false)

	    EntityAddComponent( entity_id, "LuaComponent",
	    {
		script_source_file="mods/Apotheosis/files/scripts/items/heretical_eye_regrowth.lua",
		execute_every_n_frame="250",
	    })
	end
    end

    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    local timer = ComponentGetValue2( timercomp, "value_float")
    local current_time = GameGetFrameNum()
    local thrown_time = ComponentGetValue2( timercomp, "value_int")
    local time = 0

    if thrown_time <= 0 then
        thrown_time = ComponentSetValue2( timercomp, "value_int", current_time)
    elseif thrown_time > 0 then
        time = current_time - thrown_time
    end

    local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
    local kicks_timer = ComponentGetValue2( kickcomp, "value_float")
    local kick_time = 300 --5 seconds

    if (GameGetFrameNum() >= kicks_timer + kick_time) then
	ComponentSetValue2( kickcomp, "value_int", 0)
    end

    ComponentSetValue2( timercomp, "value_float", time)

else
    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)
    local picked_frame = tonumber(ComponentGetValue2( timercomp, "value_string"))
    if (picked_frame == 0) or (picked_frame > GameGetFrameNum()) then
	ComponentSetValue2( timercomp, "value_string", tostring(GameGetFrameNum()))
    end
end

if GameHasFlagRun("heretic_dead_dead") then
    local eye = EntityGetAllChildren(entity_id)[1]
    local pupilcomp = EntityGetFirstComponentIncludingDisabled(eye, "SpriteComponent", "enabled_in_world")
    ComponentSetValue2( pupilcomp, "image_file", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/pupil_pained.png")

    local otherpupilcomp = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent" )[2]
    ComponentSetValue2( otherpupilcomp, "image_file", "mods/Apotheosis/files/items_gfx/heretical_eye_pupil_pained.png")

    if GameHasFlagRun("apotheosis_heretalk_id_3") then
	local pos_x, pos_y = EntityGetTransform(entity_id)
	EntityKill(entity_id)
	EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/eye_killed_emitter.xml", pos_x, pos_y)
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/heretical_eye_husk.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bomb_holy/create", pos_x, pos_y )
    end
end
