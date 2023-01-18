--Appending/changing vanilla boss/creature data
dofile("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

--Pitboss can shoot blackholes if she fails a line of sight check too many times in a row, prevents talet cheese
local content = ModTextFileGetContent("data/entities/animals/boss_pit/boss_pit.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
    script_source_file="data/entities/animals/boss_pit/boss_pit_apotheosis_blackhole_check.lua"
    execute_times="-1"
    execute_every_n_frame="300"
    remove_after_executed="0"
    >
    </LuaComponent>
]]))
xml:add_child(nxml.parse([[
    <VariableStorageComponent
        name="apotheosis_blackhole_count"
        value_int="0"
        >
    </VariableStorageComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_pit/boss_pit.xml", tostring(xml))