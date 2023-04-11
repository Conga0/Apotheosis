
local apotheosis_appends = {
    blood = function(wand)
        local spells = merge_spells("blood", {
            "MIST_BLOOD", "MATERIAL_BLOOD", "TOUCH_BLOOD", "CRITICAL_HIT", "BLOOD_TO_ACID",
            "CLOUD_BLOOD", "HITFX_CRITICAL_BLOOD", "CURSED_ORB", "BLOOD_MAGIC"
        })
        wand.spellsPerCast = wand.spellsPerCast + Random(1, 2)
        wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
        wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))
        add_spells_to_wand(wand, spells, math.min(Random(2,4), math.floor(wand.capacity / 2)))
    end,
    apotheosis_mudman_mud = function(wand)
        local spells = merge_spells("apotheosis_mudman_mud", {
            "APOTHEOSIS_HITFX_MUDMAN_SLIMY"
        })
        wand.spellsPerCast = wand.spellsPerCast + Random(1, 2)
        wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
        wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))
        add_spells_to_wand(wand, spells, math.min(Random(4,6), math.floor(wand.capacity / 2)))
    end,
    apotheosis_magic_liquid_attunium = function(wand)
        local spells = merge_spells("apotheosis_magic_liquid_attunium", {
            "HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA", "APOTHEOSIS_HOMING_DELAYED", "APOTHEOSIS_MIST_ATTUNIUM"
        })
        wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
        wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))
        add_spells_to_wand(wand, spells, math.min(Random(4,6), math.floor(wand.capacity / 2)))
    end,
    apotheosis_magic_liquid_velocium = function(wand)
        local spells = merge_spells("apotheosis_magic_liquid_velocium", {
            "SPEEDUP", "ACCELERATING_SHOT", "HOMING_ACCELERATING"
        })
        wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
        wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))
        wand.speedMultiplier = (if wand.speedMultiplier >= 2 then wand.speedMultiplier * 1.2 else wand.speedMultiplier * 1.6 end)
        add_spells_to_wand(wand, spells, math.min(Random(4,6), math.floor(wand.capacity / 2)))
    end,
}

for k=1,#apotheosis_appends
do local v = apotheosis_appends[k]
    table.insert(bonuses,v)
end