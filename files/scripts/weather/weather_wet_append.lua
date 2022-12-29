

--Biome modifier injection
table.insert(inject_spawns_action,
inject_spawn( g_big_enemies, 0.05, {
  prob   		= 0,
  min_count	= 1,
  max_count	= 1,
  offset_y 	= 0,    
  entity 	=  "data/entities/animals/shaman_greater_apotheosis.xml",
}))
