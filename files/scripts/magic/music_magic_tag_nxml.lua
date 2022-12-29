dofile("data/scripts/lib/utilities.lua")

--Musicstone tag addition
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/items/pickup/musicstone.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("LightComponent").attr
attrs._tags = attrs._tags .. ",musical_stone"
xml.attr.tags = xml.attr.tags .. ",musical_stone"
ModTextFileSetContent("data/entities/items/pickup/musicstone.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/props/music_machines/base_music_machine.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="0"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/props/music_machines/base_music_machine.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/kantele/kantele_a.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/kantele/kantele_a.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/kantele/kantele_d.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/kantele/kantele_d.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/kantele/kantele_dis.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/kantele/kantele_dis.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/kantele/kantele_e.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/kantele/kantele_e.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/kantele/kantele_g.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/kantele/kantele_g.xml", tostring(xml))

--Stuff
ModMaterialsFileAdd( "mods/Apotheosis/files/scripts/magic/console_test.xml" )


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_a.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_a.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_a2.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_a2.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_b.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_b.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_c.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_c.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_d.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_d.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_e.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_e.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_f.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_f.xml", tostring(xml))


local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/entities/projectiles/deck/ocarina/ocarina_gsharp.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
xml:add_child(nxml.parse([[
    <LightComponent
		_tags="enabled_in_world,enabled_in_hand,musical_stone,fx"
		_enabled="1"
		radius="0"
		r="255"
		g="255"
		b="255"
		fade_out_time="0.1"
		>
	</LightComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/ocarina/ocarina_gsharp.xml", tostring(xml))











--Deprecated example
--Musicstone tag addition
--local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
--local content = ModTextFileGetContent("data/entities/items/pickup/musicstone.xml")
--local xml = nxml.parse(content)
--xml:add_child(nxml.parse([[
--    <LuaComponent
--        script_source_file="mods/Apotheosis/files/scripts/magic/music_magic_tag.lua"
--        execute_every_n_frame="1"
--        remove_after_executed="1"
--        >
--    </LuaComponent>
--]]))
--local attrs = xml:first_of("LightComponent").attr
--attrs._tags = attrs._tags .. ",musical_stone"
--ModTextFileSetContent("data/entities/items/pickup/musicstone.xml", tostring(xml))