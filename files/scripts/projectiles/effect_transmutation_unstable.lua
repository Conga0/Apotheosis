dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( pos_x, pos_y )

local theta = math.rad( Random( 1,360 ) )
local length = 300

local parent_id = EntityGetParent( entity_id )

local rnd = Random( 1, 1000 )
if( rnd >= 1000 ) then
    proj_entity = "precursor"
elseif( rnd >= 999 ) then
    proj_entity = "lively_concoction"
elseif( rnd >= 998 ) then
    proj_entity = "wand_essence"
elseif( rnd >= 993 ) then
    proj_entity = "cursed_liquid"
elseif( rnd >= 978 ) then
    proj_entity = "fungus"
elseif( rnd >= 940 ) then
    proj_entity = "teleport"
elseif( rnd >= 580 ) then
    proj_entity = "poison"
elseif( rnd >= 290 ) then
    proj_entity = "acid"
else
    proj_entity = "lava"
end

if (parent_id ~= NULL_ENTITY) then
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length

	shoot_projectile( parent_id, "mods/Apotheosis/files/entities/projectiles/transmute_" .. proj_entity .. ".xml", pos_x, pos_y, vel_x, vel_y )
end