dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160

local targets = EntityGetInRadiusWithTag( x, y, r, "card_action" )

for i,v in ipairs( targets ) do
    if ( v ~= entity_id ) and EntityGetParent( v ) == 0 then
		
        local comp = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent")

        if ComponentGetValue2(comp, "action_id") == "APOTHEOSIS_MASS_MATERIA_CONVERSION" then
            local perk_x,perk_y = EntityGetTransform( v )
        
            EntityKill(v)
            EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", perk_x, perk_y)
            GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
            EntityLoad("mods/Apotheosis/files/entities/projectiles/materia_conversion_explosion.xml", perk_x, perk_y)
            EntityLoad("data/entities/misc/mass_materia_conversion.xml", perk_x, perk_y)
        end
    end
end
