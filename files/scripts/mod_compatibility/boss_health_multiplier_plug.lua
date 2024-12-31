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











