--Boss health multiplier insertion
dofile("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

--Dragon
local content = ModTextFileGetContent("data/entities/animals/boss_dragon.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_dragon.xml", tostring(xml))

--High Alchemist
local content = ModTextFileGetContent("data/entities/animals/boss_alchemist/boss_alchemist.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_alchemist/boss_alchemist.xml", tostring(xml))

--Leviathan
local content = ModTextFileGetContent("data/entities/animals/boss_fish/fish_giga.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_fish/fish_giga.xml", tostring(xml))

--Triangle Boss
local content = ModTextFileGetContent("data/entities/animals/boss_gate/gate_monster_a.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_gate/gate_monster_a.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/boss_gate/gate_monster_b.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_gate/gate_monster_b.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/boss_gate/gate_monster_c.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_gate/gate_monster_c.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/boss_gate/gate_monster_d.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_gate/gate_monster_d.xml", tostring(xml))

--Unohdettu
local content = ModTextFileGetContent("data/entities/animals/boss_ghost/boss_ghost.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_ghost/boss_ghost.xml", tostring(xml))

--Pyramid Boss
local content = ModTextFileGetContent("data/entities/animals/boss_limbs/boss_limbs.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_limbs/boss_limbs.xml", tostring(xml))

--Pit Boss
local content = ModTextFileGetContent("data/entities/animals/boss_pit/boss_pit.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_pit/boss_pit.xml", tostring(xml))

--Mecha Kolmi
local content = ModTextFileGetContent("data/entities/animals/boss_robot/boss_robot.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_robot/boss_robot.xml", tostring(xml))

--Master of Masters
local content = ModTextFileGetContent("data/entities/animals/boss_wizard/boss_wizard.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_wizard/boss_wizard.xml", tostring(xml))

--"Tiny"
local content = ModTextFileGetContent("data/entities/animals/maggot_tiny/maggot_tiny.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/maggot_tiny/maggot_tiny.xml", tostring(xml))

--Parrallel World Bosses
local content = ModTextFileGetContent("data/entities/animals/parallel/alchemist/parallel_alchemist.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/parallel/alchemist/parallel_alchemist.xml", tostring(xml))

--Parrallel World Bosses
local content = ModTextFileGetContent("data/entities/animals/parallel/tentacles/parallel_tentacles.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/parallel/tentacles/parallel_tentacles.xml", tostring(xml))












---------Mod Compatibility Starts Here





---purgatory
if ModIsEnabled("purgatory") then

--Dragon Fire
local content = ModTextFileGetContent("mods/purgatory/files/entities/animals/boss_dragons/fire_dragon.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/animals/boss_dragons/fire_dragon.xml", tostring(xml))

--Dragon Ice
local content = ModTextFileGetContent("mods/purgatory/files/entities/animals/boss_dragons/ice_dragon.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/animals/boss_dragons/poison_dragon.xml", tostring(xml))

--Dragon Poison
local content = ModTextFileGetContent("mods/purgatory/files/entities/animals/boss_dragons/poison_dragon.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/animals/boss_dragons/poison_dragon.xml", tostring(xml))

--Parrallel world bosses
local content = ModTextFileGetContent("mods/purgatory/files/entities/parallel_bosses/alchemist/boss_alchemist_parallel.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/parallel_bosses/alchemist/boss_alchemist_parallel.xml", tostring(xml))

local content = ModTextFileGetContent("mods/purgatory/files/entities/parallel_bosses/dragon/boss_dragon_parallel.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/parallel_bosses/dragon/boss_dragon_parallel.xml", tostring(xml))

local content = ModTextFileGetContent("mods/purgatory/files/entities/parallel_bosses/pit/bos_pit_parallel.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/parallel_bosses/pit/bos_pit_parallel.xml", tostring(xml))

local content = ModTextFileGetContent("mods/purgatory/files/entities/parallel_bosses/robot/boss_robot_parallel.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/parallel_bosses/robot/boss_robot_parallel.xml", tostring(xml))

local content = ModTextFileGetContent("mods/purgatory/files/entities/parallel_bosses/wizard/boss_wizard_parallel.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("mods/purgatory/files/entities/parallel_bosses/wizard/boss_wizard_parallel.xml", tostring(xml))


end













---Worse Enemies
if ModIsEnabled("worse_enemies") then


--Spin Boss
local content = ModTextFileGetContent("data/entities/animals/boss_spin/boss_spin.xml")
if content ~= nil then 
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
      execute_times="1"
      execute_every_n_frame="3"
      remove_after_executed="1"
      >
    </LuaComponent>
  ]]))
  ModTextFileSetContent("data/entities/animals/boss_spin/boss_spin.xml", tostring(xml))
end


--Nest Spider/Hive Wasp
local content = ModTextFileGetContent("data/entities/animals/nest_spider.xml")
if content ~= nil then 
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
      execute_times="1"
      execute_every_n_frame="3"
      remove_after_executed="1"
      >
    </LuaComponent>
  ]]))
  ModTextFileSetContent("data/entities/animals/nest_spider.xml", tostring(xml))
end

local content = ModTextFileGetContent("data/entities/animals/bossfirebug.xml")
if content ~= nil then 
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
      execute_times="1"
      execute_every_n_frame="3"
      remove_after_executed="1"
      >
    </LuaComponent>
  ]]))
  ModTextFileSetContent("data/entities/animals/bossfirebug.xml", tostring(xml))
end


--Hive Wasp, I think this is a boss??
local content = ModTextFileGetContent("data/entities/animals/hive_wasp.xml")
if content ~= nil then 
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
      execute_times="1"
      execute_every_n_frame="3"
      remove_after_executed="1"
      >
    </LuaComponent>
  ]]))
  ModTextFileSetContent("data/entities/animals/hive_wasp.xml", tostring(xml))
end
end












---Alternate Biomes
if ModIsEnabled("biome-plus") then


--Spin Boss
local content = ModTextFileGetContent("data/entities/animals/lukki/mod/electrolukki_big.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/lukki/mod/electrolukki_big.xml", tostring(xml))

end


















---new enemies
if ModIsEnabled("new_enemies") then


--aquatitan
local content = ModTextFileGetContent("data/entities/animals/aquatitan.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/aquatitan.xml", tostring(xml))

--desert_skull
local content = ModTextFileGetContent("data/entities/animals/desert_skull.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/desert_skull.xml", tostring(xml))

--hydra
local content = ModTextFileGetContent("data/entities/animals/hydra.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/hydra.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/hydra2.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/hydra2.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/hydra3.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/hydra3.xml", tostring(xml))

--mwyah
local content = ModTextFileGetContent("data/entities/animals/mwyah.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/mwyah.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/mwyah_face.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/mwyah_face.xml", tostring(xml))

--skeleboss
local content = ModTextFileGetContent("data/entities/animals/skeleboss.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/skeleboss.xml", tostring(xml))

--wraith
local content = ModTextFileGetContent("data/entities/animals/wraith_boss.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/wraith_boss.xml", tostring(xml))

--skymonster
local content = ModTextFileGetContent("data/entities/animals/skymonster.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/skymonster.xml", tostring(xml))

--seamonster
local content = ModTextFileGetContent("data/entities/animals/seamonster.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/seamonster.xml", tostring(xml))

--khulu
local content = ModTextFileGetContent("data/entities/animals/khulu.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/khulu.xml", tostring(xml))

--lempo
local content = ModTextFileGetContent("data/entities/animals/lempo.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/lempo.xml", tostring(xml))

--terminator
local content = ModTextFileGetContent("data/entities/animals/terminator.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/terminator.xml", tostring(xml))

--lempo
local content = ModTextFileGetContent("data/entities/animals/terminator.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/terminator.xml", tostring(xml))

--windmill
local content = ModTextFileGetContent("data/entities/animals/windmill.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/windmill.xml", tostring(xml))

--ghust
local content = ModTextFileGetContent("data/entities/animals/ghust.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/ghust.xml", tostring(xml))

--haries
local content = ModTextFileGetContent("data/entities/animals/harpy1.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/harpy1.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/harpy2.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/harpy2.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/harpy3.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/harpy3.xml", tostring(xml))

--furies
local content = ModTextFileGetContent("data/entities/animals/fury1.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/fury1.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/fury2.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/fury2.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/fury3.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/fury3.xml", tostring(xml))

--naga
local content = ModTextFileGetContent("data/entities/animals/naga.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/naga.xml", tostring(xml))

--seamonster
local content = ModTextFileGetContent("data/entities/animals/seamonster.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/seamonster.xml", tostring(xml))

--sorceress
local content = ModTextFileGetContent("data/entities/animals/sorceress.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/sorceress.xml", tostring(xml))

--sochaos
local content = ModTextFileGetContent("data/entities/animals/sochaos.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/sochaos.xml", tostring(xml))

--stone golem
local content = ModTextFileGetContent("data/entities/animals/golem.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/golem.xml", tostring(xml))

--lava golem
local content = ModTextFileGetContent("data/entities/animals/lava_monster.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/lava_monster.xml", tostring(xml))

--phoenix
local content = ModTextFileGetContent("data/entities/animals/bird.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/bird.xml", tostring(xml))

--dog
local content = ModTextFileGetContent("data/entities/animals/god.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/god.xml", tostring(xml))

--mother mother slime
local content = ModTextFileGetContent("data/entities/animals/slimeshooter_mega.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/slimeshooter_mega.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/animals/slimeshooter_mega_sleep.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/slimeshooter_mega_sleep.xml", tostring(xml))

--skull_abomination
local content = ModTextFileGetContent("data/entities/animals/skull_abomination.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/skull_abomination.xml", tostring(xml))

--medusa
local content = ModTextFileGetContent("data/entities/animals/medusa.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
  <LuaComponent
    script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_half.lua"
    execute_times="1"
		execute_every_n_frame="3"
    remove_after_executed="1"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/medusa.xml", tostring(xml))



end

