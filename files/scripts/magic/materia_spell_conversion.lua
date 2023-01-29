dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160

local targets = EntityGetInRadiusWithTag( x, y, r, "card_action" )

--Spells which can be converted
local inputspells =  {
    "APOTHEOSIS_BUNGAL_SHIFT",
    "APOTHEOSIS_RAT_BITE",
    "WORM_RAIN",
    "LIGHT_BULLET",
    "APOTHEOSIS_MASS_MATERIA_CONVERSION",
    "APOTHEOSIS_MASS_STATUS_DRUNK",
    "APOTHEOSIS_MASS_STATUS_WET",
    "APOTHEOSIS_MASS_STATUS_FIRE",
    "APOTHEOSIS_MASS_STATUS_URINE",
    "APOTHEOSIS_MASS_STATUS_POLYMORPH",
}

--Spells we're converting them into
--Position in this list correleations with their position in the input list
--"SPECIAL_ACTION" means something special should happen instead of just normal spell conversion, such as spawning a worm or a massive explosion
local outputspells = {
    "APOTHEOSIS_BUNGAL_SHIFT_SPAM",
    "APOTHEOSIS_RAT_BITE_CRIT",
    "SPECIAL_ACTION",
    "LIGHT_BULLET_TRIGGER",
    "SPECIAL_ACTION",
    "APOTHEOSIS_MASS_DRY",
    "APOTHEOSIS_MASS_DRY",
    "APOTHEOSIS_MASS_DRY",
    "APOTHEOSIS_MASS_DRY",
    "APOTHEOSIS_MASS_STATUS_POLYMORPH_INTENSE",
}

local effecttype = {
    "magical_symbol_materia_fungus",
    "magical_symbol",
    "magical_symbol_hobo_money",
    "magical_symbol_materia_fungus",
    "NONE",
    "magical_symbol_materia_fungus",
    "magical_symbol_materia_fungus",
    "magical_symbol_materia_fungus",
    "magical_symbol_materia_fungus",
    "magical_symbol_materia_fungus",
}

for k=1, #targets
do local v = targets[k];
    if ( v ~= entity_id ) and EntityGetParent( v ) == 0 then
		
        local comp = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent")

        local pos = 1

        for k=1, #inputspells
        do local inputmagic = inputspells[k];

            if ComponentGetValue2(comp, "action_id") == inputmagic then
                local perk_x,perk_y = EntityGetTransform( v )
            
                EntityKill(v)
                if effecttype[pos] ~= "NONE" then EntityLoad("data/entities/particles/image_emitters/" .. effecttype[pos] .. ".xml", perk_x, perk_y) end
                GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)

                if outputspells[pos] == "SPECIAL_ACTION" then
                    if inputmagic == "WORM_RAIN" then
                        EntityLoad("data/entities/animals/worm_big.xml", perk_x, perk_y)
                        CreateItemActionEntity( "APOTHEOSIS_MASS_BURROW", perk_x, perk_y )
                    elseif inputmagic == "APOTHEOSIS_MASS_MATERIA_CONVERSION" then
                        EntityLoad("mods/Apotheosis/files/entities/projectiles/materia_conversion_explosion.xml", perk_x, perk_y)
                        EntityLoad("data/entities/misc/mass_materia_conversion.xml", perk_x, perk_y)
                    end
                else
                    CreateItemActionEntity( outputspells[pos], perk_x, perk_y )
                end
            end
            pos = pos + 1
        end
    end
end

--TODO: Different spell conversions should have different particles associated to them

--Maybe use VSC to store a radius value and gradually scan outwards for spells? would look kinda cool