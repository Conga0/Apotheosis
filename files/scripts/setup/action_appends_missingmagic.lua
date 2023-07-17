-- Copi note: removing spells from progress can have issues, imo better to make 0 spawn chance and give it a never spawn flag (see how my spell disabling works) so it stays in the menu, maybe change desc to say it won't spawn so it can still appear in progress? outright removing spells makes them dissapear from copis things spell disabling menu, so I suggest not doing so, I do intend to add a way for other mods to forcibly flag a spell as disabled so it shows up in my gui as disabled too
-- Conga note: Should be done now, hopefully this prevents them from ever spawning
-- Copi note: I just manually set the fields in this update to the file

local locked_spell = {
    name        = "$spell_apotheosis_locked_spell_name",
    description = "$spell_apotheosis_locked_spell_desc",
    spawn_level = "0",
    spawn_probability = "0",
    spawn_requires_flag = "this_should_never_spawn",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/locked_spell.png",
    mana = 0,
    custom_uses_logic = true,
    action = function()
        --Nil
    end,
}

local blacklist = {
    ["BOMB"] = true,
    ["TNT"] = true,
    ["MINE"] = true,
    ["GRENADE"] = true,
    ["ROCKET"] = true,
    ["LIGHT_BULLET"] = true,
    ["SPITTER"] = true,
    ["BUBBLESHOT"] = true,
    ["RUBBERBALL"] = true,
    ["ARROW"] = true,
    ["BOUNCY_ORB"] = true,
    ["ALL_SPELLS"] = true,
    ["APOTHEOSIS_KNOWLEDGE_OF_KINGS"] = true,
}

for k=1,#actions do -- fast as fuck boi
    local v = actions[k]
    SetRandomSeed(v.price,v.mana)
    if Random(1,2) == 1 and not blacklist[v.id] then
        for key, value in pairs(locked_spell) do
            actions[k][key] = value
        end
    end
end
