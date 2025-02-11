dofile_once("data/scripts/lib/utilities.lua")

if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
        <PixelScene pos_x="505" pos_y="-105" just_load_an_entity="mods/Apotheosis/files/entities/props/sign_motd/sign_welcome_hint.xml" />
    ]]))
    ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

    AddFlagPersistent( "apotheosis_card_unlocked_welcome_hint" )

end