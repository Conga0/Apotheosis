dofile_once("data/scripts/lib/utilities.lua")

--Spawns the Message of the day if enabled
local year, month, day, hour = GameGetDateAndTimeLocal()

local filepath = "data/biome/_pixel_scenes.xml"

if ModIsEnabled("purgatory") then
    filepath = "mods/purgatory/files/biome/_pixel_scenes.xml"
elseif ModIsEnabled("noitavania") then
    filepath = "mods/noitavania/data/biome/_pixel_scenes.xml"
end

if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent(filepath)
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
        <PixelScene pos_x="505" pos_y="-105" just_load_an_entity="mods/Apotheosis/files/entities/props/sign_motd/sign_motd.xml" />
    ]]))
    ModTextFileSetContent(filepath, tostring(xml))

end