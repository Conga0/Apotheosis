local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

--Inflict infiltration on the target, pervent them from recieving ambrosia
function Infiltration(v)
    local children = EntityGetAllChildren( v )
    local valid = true
    
    if children ~= nil then
        for z=1, #children
        do local c = children[z];
            if EntityGetName(c) == "apotheosis_dry_magic" then
                valid = false
            end
        end
    end

    if valid == true then
        local comp = EntityGetFirstComponentIncludingDisabled(v,"SpriteStainsComponent")
        if comp ~= nil then
            EntitySetComponentIsEnabled(v,comp,false)

            local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_status_dry.xml", pos_x, pos_y)
            EntityAddChild(v,c)
        end
    end
end

--If the target has ambrosia, remove their stain effects and replace it with (dulled ambrosia)
function DullAmbrosia(v)
    EntityAddRandomStains( v, CellFactory_GetType("apotheosis_magic_liquid_protection_all_fading_dulled"), 400 )
end

local player_id = EntityGetRootEntity(entity_id)

local ambrosiaTest = GameGetGameEffectCount( player_id, "PROTECTION_ALL" )
if ambrosiaTest <= 0 then
    Infiltration(player_id)
else
    DullAmbrosia(player_id)
end

GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )

EntityKill( entity_id )