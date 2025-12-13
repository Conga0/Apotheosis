local par = ParallelParity

table.insert(par.worlds["data/biome/_pixel_scenes.xml"], "mods/Apotheosis/files/biome_impl/biome_map.png")
par.settings.apotheosis = {
    statue_room = ModSettingGet("parallel_parity.apotheosis.statue_room") --this is basically "parallel_parity.mods." .. (path to your setting in settings append)
}

par.pixel_scenes["mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room.png"] = par.settings.apotheosis.statue_room or true
par.pixel_scenes["mods/Apotheosis/files/scripts/biomes/boss_spawns/statue_room_populator_entity.xml"] = par.settings.apotheosis.statue_room or true