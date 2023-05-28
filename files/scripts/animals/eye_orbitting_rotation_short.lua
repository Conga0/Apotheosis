dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local boss_id = EntityGetRootEntity( entity_id )
local x,y = EntityGetTransform( boss_id )
local speed = 0.01
local distance = 25

local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "wizard_orb_id" )
if ( comp ~= nil ) then
	local id = ComponentGetValue2( comp, "value_int" )

    if id > 3 then
        speed = -0.01
        distance = 50
    end
	
	local count = 4
	local circle = math.pi * 2
	local inc = circle / count
	
	local dir = inc * id + GameGetFrameNum() * speed
	
	local nx = x + math.cos( dir ) * distance
	local ny = y - math.sin( dir ) * distance
	
	EntitySetTransform( entity_id, nx, ny )
end