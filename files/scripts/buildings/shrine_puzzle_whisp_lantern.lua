dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)
local player = getPlayer()
local player_distance = getDistanceFromTarget(entity_id,player)

function findGlyph(pos_x,pos_y)
    local entities = EntityGetInRadius( pos_x, pos_y, 256 )
    for k=1,#entities do
        if EntityGetName(entities[k]) == "shrine_puzzle_whisp_glyph" then
            return entities[k]
        end
    end
end

function checkSpellsForFlammables()
    local list_of_flammable_spells = {"TORCH","TORCH_ELECTRIC","FLAMETHROWER","FIREBALL","METEOR","ARC_FIRE","FIRE_TRAIL","BURN_TRAIL","FIRE_BLAST","ORBIT_FIREBALLS","APOTHEOSIS_FAE_LANTERN","APOTHEOSIS_FIRE_CHARGE","APOTHEOSIS_MASS_STATUS_FIRE"}

    local spell_cards = EntityGetInRadiusWithTag( pos_x, pos_y, 20, "card_action" ) or {}
    for k=1,#spell_cards do
        local comp = EntityGetFirstComponentIncludingDisabled( spell_cards[k], "ItemActionComponent")
        for z=1,#list_of_flammable_spells do
            if ComponentGetValue2(comp, "action_id") == list_of_flammable_spells[z] then
                return true
            end
        end
    end

    return false
end


function checkPotionsForFlammables(player_id)
    local inventories = EntityGetAllChildren(player_id) or {}
    for inventory_index = 1, #inventories do
        if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
            -- Find last potion tagged item
            local children = EntityGetAllChildren(inventories[inventory_index]) or {}
            for i = 1, #children do
                if EntityHasTag(children[i], "potion") then
                    local potion = children[i]
                    local mat_id = GetMaterialInventoryMainMaterial(potion)

                    if CellFactory_HasTag( mat_id, "[fire]" ) or CellFactory_HasTag( mat_id, "[fire_strong]" ) or CellFactory_HasTag( mat_id, "[hot]" ) or CellFactory_HasTag( mat_id, "[molten_metal]" ) then
                        return true
                    end
                end
            end
            break
        end
    end

    return false
end

function doesPlayerHaveFlammables(player)
    local check_1 = checkSpellsForFlammables()
    local check_2 = checkPotionsForFlammables(player)
    return check_1 or check_2
end

function isShrineSafe()
    local checks_passed = 0
    local pos_to_check = {
        --{pos_x,pos_y,targ_x,targ_y}
        {0,0,20,0},
        {0,0,-20,0},
        {45,35,55,35},
        {-45,35,-55,35},
        {45,55,55,55},
        {-45,55,-55,55},
        {35,8,35,18},
        {-35,8,-35,18},
        {0,0,0,-20},
        {0,80,0,90}
    }
    for k=1,#pos_to_check do
        local did_hit = Raytrace( pos_x + pos_to_check[k][1], pos_y + pos_to_check[k][2], pos_x + pos_to_check[k][3], pos_y + pos_to_check[k][4] )
        if did_hit then checks_passed = checks_passed + 1 end
    end

    if checks_passed > 4 then return true end
    return false
end

function interacting( player_id, building_id, interactable_name )
    local pos_x,pos_y = EntityGetTransform(building_id)

    if isDayTime(pos_x,pos_y) == false then
        if doesPlayerHaveFlammables(player_id) then
            local glyph_id = findGlyph(pos_x,pos_y)
            EntitySetComponentsWithTagEnabled( glyph_id, "invincible", true )           --Enable burning glyphs
            EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )         --Disable lantern interaction
            EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", true )   --Enable lantern flame

            GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/create", pos_x, pos_y )
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/barren_puzzle_completed/create", pos_x, pos_y )
        else
            GamePrint("$log_apotheosis_shrine_lantern_failure_fuel")
            GamePlaySound( "data/audio/Desktop/materials.bank", "collision/metalhollow/liquid_container_hit", pos_x, pos_y )
        end
    else
        GamePrint("$log_apotheosis_shrine_lantern_failure_time")
        GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/game_effect_end", pos_x, pos_y )
    end
end

--If it's daytime, disable the burning glyphs & the lantern's flame
--If it's daytime and the lantern is off-screen, "remove it" ( hide it )
--If it's night time and the lantern's sprite is visible, enable interaction with it
--If it's night time and the lantern's sprite is not visible, and it's off-screen, "add it" ( unhide it )
if isDayTime(pos_x,pos_y) then
    local particle_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
    if ComponentGetIsEnabled( particle_comp ) then
        local glyph_id = findGlyph(pos_x,pos_y)
        EntitySetComponentsWithTagEnabled( glyph_id, "invincible", false )          --Disable burning glyphs
        EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )          --Enable lantern interaction
        EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", false )  --Disable lantern flame
        GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/game_effect_end", pos_x, pos_y )
    end

    if player_distance > 300 then
        EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", false )  --Disable the lanterns sprite if it's off-screen & day time
        EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )         --Disable lantern interaction
    end
else
    if player_distance > 300 and isShrineSafe() then
        EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true )  --Enable the lanterns sprite if it's off-screen & night time
    end

    local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
    local particle_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
    if ComponentGetIsEnabled( sprite_comp ) and ComponentGetIsEnabled( particle_comp ) == false then
        EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )          --Enable lantern interaction
    end
end