if ModIsEnabled("Hydroxide") then
  ocarina_songs["tinker"] = { "a2", "f", "d", "b", "a", "c", "e", "gsharp", "a2" }
  ocarina_funcs["tinker"] = function()
    local x, y = EntityGetTransform( entity_id )
    EntityLoad( "mods/Hydroxide/files/entities/misc/tinkersong.xml", x, y )
    GamePrintImportant( "The Gods sing along to your song", "Can you hear them?" )
  end
end
