local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local pos_x, pos_y = EntityGetTransform(parent_id)
local entity_name = EntityGetName(parent_id)
local vsc_comp = EntityGetFirstComponentIncludingDisabled(parent_id)
local has_spoken = ComponentGetValue2(vsc_comp,"value_bool")

local resist_data = {
    {"$enemy_apotheosis_whisp_giga",
        {
            {
                "Vu nopea bakare parva tricium",
                "Maranis kwe tu savais taconia-kuu mimica Sol vokum usurper?",
                "tu givala Vu omnikife logium taconia exstingure tu"
            }
        }
    },
    {"$enemy_apotheosis_whisp_big",
        {
            {
                "Sol order, nop Vu verpea senta Sol?",
                "Tricium Sol?"
            },
            {
                "Tu senta falsa",
                "tu falsa Sol"
            }
        }
    }
}

if entity_name == "$enemy_apotheosis_whisp" then
    --Successful Bind
    EntityKill(parent_id)
    CreateItemActionEntity( "APOTHEOSIS_FAE_LANTERN", pos_x, pos_y )
    GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/create", pos_x, pos_y )
    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/rune/destroy", pos_x, pos_y )

    EntityLoad("mods/Apotheosis/files/entities/projectiles/solbind_blast.xml",pos_x,pos_y)

    if HasFlagPersistent("apotheosis_fae_lantern_unlocked") == false then
        GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/barren_puzzle_completed/create", pos_x, pos_y )
        AddFlagPersistent("apotheosis_fae_lantern_unlocked")
        AddFlagPersistent("apotheosis_card_unlocked_whisp_lantern")
    end
elseif has_spoken == false then
    --Resisted Bind
    math.randomseed(pos_x + pos_y)
    for k=1,#resist_data do
        if resist_data[k][1] == entity_name then
            local rng = math.random(1,#resist_data[k][2])
            for z=1,#resist_data[k][2][rng] do
                local text = table.concat({GameTextGetTranslatedOrNot(entity_name),": ",resist_data[k][2][rng][z]})
                GamePrint(text)
            end
            break
        end
    end
    GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/game_effect_end", pos_x, pos_y )
end
