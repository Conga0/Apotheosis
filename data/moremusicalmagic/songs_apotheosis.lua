ocarina_songs["fullhp"]  = { "d", "e", "a", "d" }                 --Hinted at in Core Mines
ocarina_songs["spawnpouch"]  = { "b", "a2", "f", "e" }            --Hinted at in Sink Hole (Desert)
ocarina_songs["spawnpotion"]  = { "d", "d", "e", "e" }            --Hinted at in Sunken Cavern
ocarina_songs["krittycats"]  = { "a", "b", "d", "c" }             --Hinted at in Tree Top (Above achievement pillars)

kantele_songs["fullhp"]  = { "d", "e", "a", "d" }
kantele_songs["spawnpouch"]  = { "g", "dsharp", "e", "a" }
kantele_songs["spawnpotion"]  = { "dsharp", "dsharp", "e", "e" }
kantele_songs["krittycats"]  = { "a", "d", "e", "g" }      



ocarina_funcs["fullhp"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_fullhp", -1, "data/entities/items/pickup/heart_fullhp.xml", x, y - 32, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

ocarina_funcs["spawnpouch"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_spawnpouch", -1, "data/entities/items/pickup/powder_stash.xml", x, y - 32, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

ocarina_funcs["spawnpotion"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_spawnpotion", -1, "data/entities/items/pickup/potion.xml", x, y, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

ocarina_funcs["krittycats"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_krittycats", -1, "data/entities/buildings/intro_kitty_populator.xml", x, y, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end


kantele_funcs["fullhp"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_fullhp", -1, "data/entities/items/pickup/heart_fullhp.xml", x, y - 32, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

kantele_funcs["spawnpouch"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_spawnpouch", -1, "data/entities/items/pickup/powder_stash.xml", x, y - 32, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

kantele_funcs["spawnpotion"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_spawnpotion", -1, "data/entities/items/pickup/potion.xml", x, y, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

kantele_funcs["krittycats"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_krittycats", -1, "data/entities/buildings/intro_kitty_populator.xml", x, y, 0 )
  AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end
