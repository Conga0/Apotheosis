dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 128
local charmTest = GameGetGameEffectCount( entity_id, "CHARM" )

local allies_tag = "enemy"
if charmTest >= 1 then allies_tag = "player_unit" end
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, allies_tag )

local allies_are_burning = false
local allies_are_frozen = false

local physics_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
local physics_pixel_count = ComponentGetValue2(physics_comp,"mPixelCount")
local current_frame = GameGetFrameNum()

function ExtinguishNearbyEntities()
	local how_many = 12
	local angle_inc = ( 2 * 3.14159 ) / how_many
	local theta = 0
	local length = 120
	GamePlaySound( "data/audio/Desktop/player.bank", "player/jump_water", pos_x, pos_y );

	for i=1,how_many do
		local vel_x = math.cos( theta ) * length
		local vel_y = math.sin( theta ) * length
		theta = theta + angle_inc

		shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/deck/mass_status_wet_effect.xml", pos_x, pos_y, vel_x, vel_y )
	end

	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

	for i,v in ipairs( targets ) do		
		if EntityHasTag(v, "hittable") then
			local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_status_wet_ailment.xml", pos_x, pos_y )
			EntityAddChild( v, eid )
			EntityAddRandomStains( v, CellFactory_GetType("water"), 400 )
		end
	end
end

function UnfreezeNearbyEntities()
	GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/create", pos_x, pos_y )

	local eid = EntityLoad( "data/entities/animals/ai/drone_status_ailment_unfreeze_fx.xml", pos_x, pos_y )
	EntityAddChild( entity_id, eid )

	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

	for i,v in ipairs( targets ) do
		if ( v ~= entity_id ) then
			local comp = GameGetGameEffect( v, "FROZEN" )
			if comp ~= 0 then
				ComponentSetValue2( comp, "frames", 1)
			end
		end
	end
end

function runAIUpdate()
    for k=1, #targets do
        local v = targets[k]
        local dmg_comp = EntityGetFirstComponent( v, "DamageModelComponent" ) or 0
        if dmg_comp ~= 0 then
            if ComponentGetValue2( dmg_comp, "is_on_fire" ) or GameGetGameEffectCount(v, "RADIOACTIVE") > 0 or GameGetGameEffectCount(v, "POISON") > 0 or GameGetGameEffectCount(v, "OILED") > 0 or GameGetGameEffectCount(v, "SLIMY") > 0 then
                allies_are_burning = true
            end
        end

        if GameGetGameEffectCount( v, "FROZEN" ) > 0 then
            allies_are_frozen = true
        end

        if allies_are_burning and allies_are_frozen then break end
    end

    if allies_are_burning then ExtinguishNearbyEntities() end
    if allies_are_frozen then UnfreezeNearbyEntities() end

    --Is the physics body unloaded? If so then run this code
    if physics_pixel_count == 0 then
        --Regenerate the physics body by removing it and creating a new one
        EntityRemoveComponent( entity_id, physics_comp )

		EntityAddComponent2(
			entity_id,
			"PhysicsBodyComponent",
			{
                allow_sleep=true,
                angular_damping=0.02,
                fixed_rotation=false,
                is_bullet=false,
                linear_damping=0, 
                on_death_leave_physics_body=true
			}
		)
    end
end

runAIUpdate()