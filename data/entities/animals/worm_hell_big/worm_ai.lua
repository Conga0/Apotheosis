
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")
local iframes_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")

local angle = math.atan2(targ_y, targ_x)
local acidspit_cooldown_duration = 18 * 60
local current_frame = GameGetFrameNum()

function Stage1()
    --Disable the barrage lua script
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
end

function Stage2()

    --Set to normal speed and wait for next attack opportunity
	ComponentSetValue2( wormAiComp, "speed", 4 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 4 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.05 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.05 )    
end

function Stage3()
    --Slow down the worm for the upcoming barrage

	ComponentSetValue2( wormAiComp, "speed", 2 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 2 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.00001 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.00001 )    

	local c = EntityGetAllChildren( entity_id )
	if c ~= nil then
	for a,b in ipairs( c ) do
		local childname = EntityGetName( b )

		if ( childname == "segment" ) then
			EntitySetComponentsWithTagEnabled(b,"enabled_by_liquid",false)
		end
	end
	end
end

function Stage4()
    --Enables barrage lua script
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)

    --GameShootProjectile(entity_id, pos_x, pos_y, pos_x + targ_x, pos_y + targ_y, EntityLoad("data/entities/animals/worm_hell_big/projectiles/liquidsphere_lava.xml", pos_x, pos_y))

	--ComponentSetValue2( wormAiComp, "speed", 6 )
	--ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
	--ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
	--ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )    
end

function Stage5()
    --Allow the worm to speed back up

	ComponentSetValue2( wormAiComp, "speed", 6 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )    

	local c = EntityGetAllChildren( entity_id )
	if c ~= nil then
	for a,b in ipairs( c ) do
		local childname = EntityGetName( b )

		if ( childname == "segment" ) then
			EntitySetComponentsWithTagEnabled(b,"enabled_by_liquid",true)
		end
	end
	end
end

local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
for k=1,#variablecomp
do local v = variablecomp[k]
    if ComponentGetValue2(v,"name") == "basic_ai" then
        variablecomp = v
        break
    end
end
local cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
local laser_stage = ComponentGetValue2( variablecomp, "value_float" )
local chilly_meter = tonumber(ComponentGetValue2( variablecomp, "value_string" ))
--GamePrint("My stage is " .. laser_stage)

local depth_cap = 17390
local safety_cap = 40000
local depth_check = (pos_y <= depth_cap)
local safety_check = (pos_y >= safety_cap)
local target_distance = 50
local cold_limit = 1200
if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
if GameHasFlagRun("apotheosis_everything") or GameHasFlagRun("apotheosis_downunder") then
	depth_cap = -7180
	safety_cap = -30000
	depth_check = (pos_y >= depth_cap)
	safety_check = (pos_y <= safety_cap)
	target_distance = -50
end

if (depth_check and chilly_meter <= 0) then
	local movement_target = EntityLoad("data/entities/animals/worm_hell_big/safety_movement_target.xml", pos_x, pos_y + target_distance)
	local inheritcomp = EntityGetFirstComponentIncludingDisabled( movement_target, "InheritTransformComponent" )
	ComponentSetValue2(inheritcomp, "Transform", 0, target_distance, 1, 1, 0)
	EntityAddChild( entity_id, movement_target )
	ComponentSetValue2( variablecomp, "value_float", 2 )
	laser_stage = 2
	ComponentSetValue2( variablecomp, "value_int", current_frame )
	cooldown_frame = current_frame
	ComponentSetValue2( wormAiComp, "speed", 8 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.05 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.05 )

	ComponentSetValue2( variablecomp, "value_string", tostring(chilly_meter + 1) )
	chilly_meter = chilly_meter + 1
	local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
	for i, comp in ipairs(sprite_comps) do
		ComponentSetValue2(comp, "rect_animation", "freezing")
		ComponentSetValue2(comp, "next_rect_animation", "cold") --next_rect doesn't work >:(
	end
	local spritecomp = EntityGetFirstComponent( entity_id, "SpriteComponent" )
	ComponentSetValue2(spritecomp, "rect_animation", "freezing_1")
	ComponentSetValue2(spritecomp, "next_rect_animation", "freezing_1")
	EntityAddComponent(entity_id, "LuaComponent", {
		script_source_file="data/entities/animals/worm_hell_big/brain_freeze_animation.lua",
		execute_every_n_frame=9,
		execute_on_added=0,
		remove_after_executed=0,
	}) 
	local damagecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
	ComponentSetValue2(damagecomp, "ragdoll_material", "rock_hard_border")
	ComponentSetValue2( damagecomp, "damage_multipliers", "ice", 2 )

	EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
	local c = EntityGetAllChildren( entity_id )
	if c ~= nil then
	for a,b in ipairs( c ) do
		local childname = EntityGetName( b )

		if ( childname == "segment" ) then
			EntitySetComponentsWithTagEnabled(b,"enabled_by_liquid",false)
		end
	end
	end
elseif (depth_check) then
	ComponentSetValue2( variablecomp, "value_string", tostring(chilly_meter + 1) )
end

if (chilly_meter >= cold_limit) then
	local c = EntityGetAllChildren( entity_id )
	if c ~= nil then
	for a,b in ipairs( c ) do
		local childname = EntityGetName( b )

		if ( childname == "segment" ) then
			local s_x, s_y = EntityGetTransform( b )
			GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/create", s_x, s_y );
		end
	end
	end
	GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/create", pos_x, pos_y );
	EntityConvertToMaterial( entity_id, "rock_hard_border", false, true )
	EntityKill( entity_id )
elseif (chilly_meter > 0 and safety_check) then
	ComponentSetValue2(wormAiComp,"give_up_area_radius",150)
	ComponentSetValue2( variablecomp, "value_string", tostring(0) )
	chilly_meter = 0
	local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
	for i, comp in ipairs(sprite_comps) do
		ComponentSetValue2(comp, "rect_animation", "unfreezing")
		ComponentSetValue2(comp, "next_rect_animation", "stand")
	end
	local spritecomp = EntityGetFirstComponent( entity_id, "SpriteComponent" )
	ComponentSetValue2(spritecomp, "rect_animation", "freezing_4")
	ComponentSetValue2(spritecomp, "next_rect_animation", "freezing_4")
	EntityAddComponent(entity_id, "LuaComponent", {
		script_source_file="data/entities/animals/worm_hell_big/brain_unfreeze_animation.lua",
		execute_every_n_frame=9,
		execute_on_added=0,
		remove_after_executed=0,
	}) 
	local damagecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
	ComponentSetValue2(damagecomp, "ragdoll_material", "apotheosis_meat_big_hell_worm")
	ComponentSetValue2( damagecomp, "damage_multipliers", "ice", 0.3 )

    local movement_id = nil
    local c = EntityGetAllChildren(entity_id) or {}
    if ( c ~= nil ) then
	for a,b in ipairs( c ) do
	    local childname = EntityGetName( b )
	    if ( childname == "movement_target" ) then
		movement_id = b
	    end
	end
    end
    if movement_id ~= nil then
	if EntityHasTag(movement_id,"mortal") then
	    EntityKill(movement_id)
	end
    end
end
end

if (chilly_meter <= 0) then
do
    if (current_frame >= cooldown_frame) and laser_stage == 1 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 2 )
        Stage1()
    elseif (current_frame >= cooldown_frame) and laser_stage == 2 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 1200 )
        ComponentSetValue2( variablecomp, "value_float", 3 )
        Stage2()
    elseif (current_frame >= cooldown_frame) and laser_stage == 3 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 4 )
        Stage3()
    elseif (current_frame >= cooldown_frame) and laser_stage == 4 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 420 )
        ComponentSetValue2( variablecomp, "value_float", 5 )
        Stage4()
    elseif (current_frame >= cooldown_frame) and laser_stage == 5 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 1 )
        Stage5()
    end
end
end



--Worm Laser "AI" explanation
-- 1. begin emitting particles/fake laser from the worm's head, in the direction it's moving
-- 2. begin slowing the worm down and intensify beam particles
-- 3. 0.5-1 seconds later, unleash a massive powerful laser beam
-- 4. After 2-3 seconds pass, disable the laser beam and give the worm it's normal movement back, but potentially disengage with the player
-- 5. After the cooldown finishes, chase after the player again



--Keeps worm focused on the player
--Also now targets a retreat target if the player drags them out too far
if chilly_meter > 0 then
    local movement_id = nil
    local c = EntityGetAllChildren(entity_id) or {}
    if ( c ~= nil ) then
	for a,b in ipairs( c ) do
	    local childname = EntityGetName( b )
	    if ( childname == "movement_target" ) then
		movement_id = b
	    end
	end
    end
    if movement_id ~= nil then
	if EntityHasTag(movement_id,"mortal") then
	    ComponentSetValue2(wormAiComp,"mTargetEntityId",movement_id)
	    ComponentSetValue2(wormAiComp,"mNextTargetCheckFrame",current_frame)
	end
    end
else
    local player_id = EntityGetWithTag("player_unit")[1] or 0
    if player_id ~= 0 then
	ComponentSetValue2(wormAiComp,"mTargetEntityId",player_id)
    end
end

--Ticks down iframes counter
local iframes = ComponentGetValue2(iframes_comp,"value_int")
ComponentSetValue2(iframes_comp,"value_int",iframes - 1)

