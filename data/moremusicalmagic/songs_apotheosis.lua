ocarina_songs["fullhp"]  = { "d", "e", "a", "d" }

kantele_songs["fullhp"]  = { "d", "e", "a", "d" }



ocarina_funcs["fullhp"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_fullhp", -1, "data/entities/items/pickup/heart_fullhp.xml", x, y - 32, 0 )
end

kantele_funcs["fullhp"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_fullhp", -1, "data/entities/items/pickup/heart_fullhp.xml", x, y - 32, 0 )
end
