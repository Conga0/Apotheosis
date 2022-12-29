dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160

local targets = EntityGetInRadiusWithTag( x, y, r, "card_action" )

for i,v in ipairs( targets ) do
    if ( v ~= entity_id ) and EntityGetParent( v ) == 0 then
		
        local comp = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent")

        if ComponentGetValue2(comp, "action_id") == "WORM_RAIN" then
            local perk_x,perk_y = EntityGetTransform( v )
        
            EntityKill(v)
            EntityLoad("data/entities/particles/image_emitters/magical_symbol_hobo_money.xml", perk_x, perk_y)
            GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
            CreateItemActionEntity( "apotheosis_SUMMON_WORM_BIG", perk_x, perk_y )
        end
    end
end
