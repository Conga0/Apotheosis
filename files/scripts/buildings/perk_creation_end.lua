
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local active = false
local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/buildings/perk_creation.lua" then
	active = true
	EntityRemoveComponent( entity_id, luacomps[i] )
	break
    end
end

if not active then return end

local c = EntityGetAllChildren( entity_id )
for a,b in ipairs( c ) do
    local name = EntityGetName( b )

    if ( name == "gear_sounds" ) then
	EntityKill( b )
    end
end

local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
ComponentSetValue2(sprite_comp, "rect_animation", "inactive")
