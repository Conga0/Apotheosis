dofile_once("data/scripts/lib/utilities.lua")

function item_pickup( entity_item, entity_who_picked, name )
    
end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
    local pos_x,pos_y = EntityGetTransform(entity_id)

    --visual effects
    local how_many = 12
    local angle_inc = ( 2 * 3.14159 ) / how_many
    local theta = 0
    local length = 400
    local r = 80
    GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", pos_x, pos_y )
    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/rune/create", pos_x, pos_y )

    for i=1,how_many do
        local vel_x = math.cos( theta ) * length
        local vel_y = math.sin( theta ) * length
        theta = theta + angle_inc

        shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/mass_status_jellyfish_pearl_effect.xml", pos_x, pos_y, vel_x, vel_y )
    end

    --Remove curses
    local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "apotheosis_cursed_item" )

    for k=1,#targets do
        EntitySetComponentsWithTagEnabled( targets[k], "invincible", true )
        EntitySetComponentsWithTagEnabled( targets[k], "enabled_in_world", false )
    end

    local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

    for i,v in ipairs( targets ) do
        if ( v ~= entity_id ) then
            local c = EntityGetAllChildren( v )
            
            if EntityHasTag(v, "hittable") then
                local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_phantom_curse_cure_100.xml", pos_x, pos_y )
                EntityAddChild( v, eid )
            end
        end
    end
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local paper_books = EntityGetInRadiusWithTag(pos_x,pos_y,70,"paper_book") or {}
local book_present = false
for k=1,#paper_books do
    local v = paper_books[k]
    if EntityGetRootEntity(v) == v then
        book_present = true
    end
end

if book_present then
    EntityAddTag(entity_id,"forgeable")
else
    EntityRemoveTag(entity_id,"forgeable")
end