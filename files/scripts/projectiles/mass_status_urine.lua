dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 512

-- check that we're only shooting every 10 frames
if script_wait_frames( entity_id, 10 ) then  return  end

local how_many = 12
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 400

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/deck/mass_status_urine_effect.xml", pos_x, pos_y, vel_x, vel_y )
end

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		local children = EntityGetAllChildren( v )
		local valid = true
		
		if children ~= nil then
			for z=1, #children
			do local c = children[z];
				if EntityGetName(c) == "apotheosis_urine_magic" then
					valid = false
				end
			end
		end


		if valid == true then
			local comp = EntityGetFirstComponentIncludingDisabled(v,"SpriteStainsComponent")
			if comp ~= nil then
				local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_status_urine.xml", pos_x, pos_y)
				EntityAddRandomStains( v, CellFactory_GetType("apotheosis_urine_fading"), 400 )
				EntityAddChild(v,c)
			end
		end
	end
end