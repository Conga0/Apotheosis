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
	custom_xml_file = nil,
    action = function()
        --Nil
    end,
}

local blacklist = {
    ["BOMB"] = true,             --Starting Spell
    ["DYNAMITE"] = true,         --Starting Spell
    ["MINE"] = true,             --Starting Spell
    ["GRENADE"] = true,          --Starting Spell
    ["ROCKET"] = true,           --Starting Spell
    ["LIGHT_BULLET"] = true,     --Starting Spell
    ["SPITTER"] = true,          --Starting Spell
    ["BUBBLESHOT"] = true,       --Starting Spell
    ["RUBBER_BALL"] = true,      --Starting Spell
    ["ARROW"] = true,            --Starting Spell
    ["BOUNCY_ORB"] = true,       --Starting Spell
    ["ALL_SPELLS"] = true,       --Starting Spe- I mean, Quest spell
    ["SUMMON_PORTAL"] = true,       --Starting Spe- I mean, Quest spell
    ["SEA_SWAMP"] = true,           --Quest Spell
    ["ALPHA"] = true,                       --At least some form of infinite spell casting is available
    ["APOTHEOSIS_KAPPA"] = true,                       --At least some form of infinite spell casting is available
    ["BURST_2"] = true,                              --Multicast is important for wand functionality
    ["BURST_3"] = true,                              --Multicast is important for wand functionality
    ["BURST_4"] = true,                              --Multicast is important for wand functionality
    ["BLACK_HOLE"] = true,                          --Digging
    ["APOTHEOSIS_LIQUID_SPHERE_ACID"] = true,       --Digging
    ["MANA_REDUCE"] = true,                         --Mana reduction spells are essential to rapid-fire wand functionality late-game
    ["APOTHEOSIS_WATER_POWER"] = true,              --Mana reduction spells are essential to rapid-fire wand functionality late-game
    ["TELEPORT_PROJECTILE_SHORT"] = true,   --It just sucks to move around without TP, want to guarantee at least one spawns
    ["APOTHEOSIS_ALT_FIRE_TELEPORT"] = true,   --It just sucks to move around without TP, want to guarantee at least one spawns
    ["APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT"] = true,   --It just sucks to move around without TP, want to guarantee at least one spawns
    ["HEAL_BULLET"] = true,          --There's so few healing spells in the game I want to guarantee at least one spawns
    ["REGENERATION_FIELD"] = true,          --There's so few healing spells in the game I want to guarantee at least one spawns
    ["APOTHEOSIS_ALT_FIRE_COV"] = true,          --There's so few healing spells in the game I want to guarantee at least one spawns
    ["APOTHEOSIS_PORTAL_LUKKI_RED_PORTAL"] = true,      --One of a kind 
    ["APOTHEOSIS_PORTAL_LUKKI_BLUE_PORTAL"] = true,     --One of a kind 
    ["APOTHEOSIS_PORTAL_LUKKI_GREEN_PORTAL"] = true,    --One of a kind 
    ["APOTHEOSIS_KNOWLEDGE_OF_KINGS"] = true,           --Quest spell
    ["APOTHEOSIS_TERMINUS"] = true,                     --Quest spell
    ["APOTHEOSIS_SPELL_WORM"] = true,                   --Questish spell
    ["DIVIDE_2"] = true,                --Important DPS spell
    ["DIVIDE_3"] = true,                --Important DPS spell
    ["DIVIDE_4"] = true,                --Important DPS spell
    ["DIVIDE_10"] = true,               --Important DPS spell
    ["PIERCING_SHOT"] = true,           --Important DPS spell
    ["APOTHEOSIS_BLOOD_POWER"] = true,  --Important DPS spell
    ["SEA_MIMIC"] = true,
    ["APOTHEOSIS_MASS_MATERIA_CONVERSION"] = true,

    --Notes
    ["OCARINA_A"] = true,
    ["OCARINA_B"] = true,
    ["OCARINA_C"] = true,
    ["OCARINA_D"] = true,
    ["OCARINA_E"] = true,
    ["OCARINA_F"] = true,
    ["OCARINA_GSHARP"] = true,
    ["OCARINA_A2"] = true,

    ["KANTELE_A"] = true,
    ["KANTELE_D"] = true,
    ["KANTELE_DIS"] = true,
    ["KANTELE_E"] = true,
    ["KANTELE_G"] = true,

    ["APOTHEOSIS_SPELLBOOK"] = true,

    --Grahams Things Compatibility
    ["GRAHAM_GLOW_DART"] = true,       --Starting Spell
    ["GRAHAM_BRAMBALL"] = true,       --Starting Spell
    ["GRAHAM_BARREL"] = true,       --Starting Spell
    ["GRAHAM_PANIC_BOMB"] = true,       --Starting Spell
}

for k=1,#actions do -- fast as fuck boi
    local v = actions[k]
    SetRandomSeed(v.price + k,v.mana)
    if not blacklist[v.id] and Random(1,3) == 1 then
        for key, value in pairs(locked_spell) do
            actions[k][key] = value
        end
    end
end
