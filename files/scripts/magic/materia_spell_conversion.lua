dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160

local targets = EntityGetInRadiusWithTag( x, y, r, "card_action" )

--Conga: Could be cleaned up into a single table, but unless there's a lot more work planned to be done here, it shouldn't be necessary work

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
    "LIFETIME",
    "LIFETIME_DOWN",
    "BULLET",
    "BOMB",
    "ALPHA",
    "GAMMA",
    "TAU",
    "OMEGA",
    "MU",
    "PHI",
    "SIGMA",
    "APOTHEOSIS_CHI",
    "ZETA",
    "POLLEN",
    "RUBBER_BALL",
    "APOTHEOSIS_MUSICAL_STRIKE",
    "BUBBLESHOT",
    "MINE",
    "PIPE_BOMB",
    "APOTHEOSIS_ALT_FIRE_TELEPORT",
    "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT",
    "TELEPORT_PROJECTILE",
    "TELEPORT_PROJECTILE_SHORT",
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
    "LIFETIME_DOWN",
    "LIFETIME",
    "BULLET_TRIGGER",
    "APOTHEOSIS_BOMB_GIGA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_KAPPA",
    "APOTHEOSIS_POLLEN_TRIGGER",
    "APOTHEOSIS_RUBBER_BALL_TRIGGER",
    "APOTHEOSIS_MUSICAL_STRIKE_TRIGGER",
    "BUBBLESHOT_TRIGGER",
    "MINE_DEATH_TRIGGER",
    "PIPE_BOMB_DEATH_TRIGGER",
    "SPECIAL_ACTION",
    "SPECIAL_ACTION",
    "APOTHEOSIS_ALT_FIRE_TELEPORT",
    "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT",
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
    "magical_symbol_materia_red",
    "magical_symbol_materia_blue",
    "magical_symbol_hobo_money",
    "magical_symbol_materia_red",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "magical_symbol_hobo_money",
    "NONE",
    "NONE",
    "magical_symbol_plasma",
    "magical_symbol_plasma",
}

local god_cheat = false

for k=1, #targets
do local v = targets[k];
    if ( v ~= entity_id ) and EntityGetParent( v ) == 0 then
		
        local comp = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent")

        for k=1, #inputspells
        do local inputmagic = inputspells[k];

            if ComponentGetValue2(comp, "action_id") == inputmagic then
                local perk_x,perk_y = EntityGetTransform( v )
                local cost_component = EntityGetFirstComponent(v,"ItemCostComponent")
                local gold_cost = ComponentGetValue2(cost_component,"cost") or 0
            
                EntityKill(v)
                if effecttype[k] ~= "NONE" then EntityLoad("data/entities/particles/image_emitters/" .. effecttype[k] .. ".xml", perk_x, perk_y) end
                GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
                local output_spell = 0

                if outputspells[k] == "SPECIAL_ACTION" then
                    if inputmagic == "WORM_RAIN" then
                        EntityLoad("data/entities/animals/worm_big.xml", perk_x, perk_y)
                        output_spell = CreateItemActionEntity( "APOTHEOSIS_MASS_BURROW", perk_x, perk_y )
                    elseif inputmagic == "APOTHEOSIS_MASS_MATERIA_CONVERSION" then
                        EntityLoad("mods/Apotheosis/files/entities/projectiles/materia_conversion_explosion.xml", perk_x, perk_y)
                        EntityLoad("data/entities/misc/mass_materia_conversion.xml", perk_x, perk_y)
                    elseif inputmagic == "APOTHEOSIS_ALT_FIRE_TELEPORT" then
                        --if (GameHasFlagRun("apotheosis_everything") or GameHasFlagRun("apotheosis_hardmode")) and not GameHasFlagRun("apotheosis_flag_copy_spells") then
                        if true == false then
                            GameScreenshake(50, perk_x, perk_y)
                            GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", perk_x, perk_y )
                            if god_cheat == false then
                                god_cheat = true
                                GamePrintImportant("$log_apotheosis_upgrade_alwayscast_cheater_name", "")
                            end
                            output_spell = CreateItemActionEntity( "APOTHEOSIS_ALT_FIRE_TELEPORT", perk_x, perk_y )
                        else
                            output_spell = CreateItemActionEntity( "TELEPORT_PROJECTILE", perk_x, perk_y )
                            EntityLoad("data/entities/particles/image_emitters/magical_symbol_plasma.xml", perk_x, perk_y)
                        end
                    elseif inputmagic == "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT" then
                        --if (GameHasFlagRun("apotheosis_everything") or GameHasFlagRun("apotheosis_hardmode")) and not GameHasFlagRun("apotheosis_flag_copy_spells") then
                        if true == false then
                            GameScreenshake(50, perk_x, perk_y)
                            GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", perk_x, perk_y )
                            if god_cheat == false then
                                god_cheat = true
                                GamePrintImportant("$log_apotheosis_upgrade_alwayscast_cheater_name", "")
                            end
                            output_spell = CreateItemActionEntity( "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT", perk_x, perk_y )
                        else
                            output_spell = CreateItemActionEntity( "TELEPORT_PROJECTILE_SHORT", perk_x, perk_y )
                            EntityLoad("data/entities/particles/image_emitters/magical_symbol_plasma.xml", perk_x, perk_y)
                        end
                    end
                else
                    output_spell = CreateItemActionEntity( outputspells[k], perk_x, perk_y )
                end

                if gold_cost ~= 0 then
                    EntityAddComponent2(
                        output_spell,
                        "ItemCostComponent",
                        {
                             _enabled=true,
                            _tags="enabled_in_world,shop_cost",
                            cost=gold_cost,
                            stealable=true
                        }
                    )

                    EntityAddComponent2(
                        output_spell,
                        "SpriteComponent",
                        {
                             _enabled=true,
                            _tags="enabled_in_world,shop_cost",
                            text=tostring(gold_cost),
                            image_file="data/fonts/font_pixel_white.xml",
                            is_text_sprite=true,
                            offset_x=5.5,
                            offset_y=25,
                            z_index = -1
                        }
                    )
                end
            end
        end
    end
end

if GameHasFlagRun("apotheosis_materia_converted") == false then 
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	GameTriggerMusicEvent( "music/oneshot/dark_01", true, x, y )
    GameAddFlagRun("apotheosis_materia_converted")
end

--TODO: Different spell conversions should have different particles associated to them

--Maybe use VSC to store a radius value and gradually scan outwards for spells? would look kinda cool