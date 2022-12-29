dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger( player_id )

	GamePrintImportant( "$biomemod_apotheosis_smoke_dense", "", "data/ui_gfx/decorations_biome_modifier/fog_of_war.png" )

    --Add flag to make dense smoke biome modifier rng in future runs
    AddFlagPersistent( "apotheosis_card_unlocked_coalpits_dense_smoke" )

	EntityKill( entity_id )
end