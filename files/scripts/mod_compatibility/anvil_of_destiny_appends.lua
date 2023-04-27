--[[
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
]]--

--New stuff below
--Magical Mud
--Magical Mud Transmutation AC
append_effect("apotheosis_mudman_mud", function(wand)
    wand.spellsPerCast = wand.spellsPerCast + 1
    wand.capacity = wand.capacity + 1

    local spells, attached_spells = wand:GetSpells()
    local count = 0
    for i = 1, #attached_spells do
        if attached_spells[i].id == "APOTHEOSIS_HITFX_MUDMAN_SLIMY" then
            count = count + 1
        end
    end
    if count < 1 then
        wand:AttachSpells("APOTHEOSIS_HITFX_MUDMAN_SLIMY")
    end
end)


--Attunium
--Random homing spell AC
append_effect("apotheosis_magic_liquid_attunium", function(wand)
    local IDTable = {}

    for k=1,#actions
    do local v = actions[k]
        if v.subtype == "homing" then
            table.insert(IDTable,k)
        end
    end

    local rnd = Random( 1, #IDTable )
    local data = actions[IDTable[rnd]]
    wand:AttachSpells(data.id)
end)


--Velocium
--Random speed up spell AC
append_effect("apotheosis_magic_liquid_velocium", function(wand)
    wand.spellsPerCast = 1
    local options = { "SPEEDUP", "ACCELERATING_SHOT", "HOMING_ACCELERATING" }
    wand:AttachSpells(options[math.random(1,#options)])
end)


--Milk
--Random stat gets super boosted
--I know this works awful, tried implementing a table it could look up but it didn't feel like cooperating
append_effect("apotheosis_milk", function(wand)
    local rnd = math.random(1,8)

    if rnd == 1 then
        wand.spellsPerCast = math.min(wand.capacity, wand.spellsPerCast + 11)
    elseif rnd == 2 then
        wand.manaChargeSpeed = math.max(wand.manaChargeSpeed * 3, wand.manaChargeSpeed + 300)
    elseif rnd == 3 then
        wand.manaMax = math.max(wand.manaMax * 3, wand.manaMax + 400)
    elseif rnd == 4 then
        wand.speedMultiplier = wand.speedMultiplier * 5
    elseif rnd == 5 then
        wand.spread = wand.spread - 30
    elseif rnd == 6 then
        wand.rechargeTime = math.min(wand.rechargeTime * 0.33, wand.rechargeTime - 0.20)
    elseif rnd == 7 then
        wand.rechargeTime = math.min(wand.castDelay * 0.33, wand.castDelay - 0.20)
    else
        wand.capacity = math.min(math.max(wand.capacity * 2, wand.capacity + 6), 30)
    end
end)


--Nukium
--Nukes
append_effect("apotheosis_magic_liquid_nukes", function(wand)
    local options = { "ALL_NUKES", "NUKE", "NUKE_GIGA" }
    wand:AttachSpells(options[math.random(1,#options)])
end)


--Soarium
--Gives spells related to anti-gravity and gravity defial
--Slightly reduce cast delay & recharge time
do
    append_effect("apotheosis_magic_liquid_infinite_flight", function(wand)
        wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
        wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))
    end)

    local spells = { "GRAVITY_ANTI" }
    if ModIsEnabled("copis_things") then
        table.insert(spells,"COPIS_THINGS_LEVITY_SHOT")
    end
    add_spells_to_effect("blood", spells)
end


--Pure Light
--Add many pin points of light as an always cast
append_effect("apotheosis_magic_liquid_pure_light", function(wand)
    local rnd =  math.random(1,4)
    for k=1,rnd do
        wand:AttachSpells("GLOWING_BOLT")
    end
end)


--Escium
--Turns wand into a burst-fire
-- 60 = 1 second
-- 45 = 0.75 seconds
append_effect("apotheosis_magic_liquid_escium", function(wand)
    wand.spellsPerCast = wand.spellsPerCast + Random(1, 3)
    wand.manaMax = wand.manaMax * 8
    wand.manaChargeSpeed = wand.manaChargeSpeed * 0.5
    wand.rechargeTime = math.max(wand.rechargeTime * 2, 0.45)
    wand.castDelay = math.max(wand.castDelay * 0.25, 0.15)
end)


--Suffocatium
--Random water related spell AC + stat boost
append_effect("apotheosis_magic_liquid_suffocatium", function(wand)

    wand.manaMax = wand.manaMax + Random(80, 200)
    wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
    wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))

    local options = { "CIRCLE_WATER", "MATERIAL_WATER", "TOUCH_WATER", "SEA_WATER", "CLOUD_WATER", "HITFX_CRITICAL_WATER", "WATER_TRAIL", "APOTHEOSIS_LIQUIDSPHERE_WATER" }
    wand:AttachSpells(options[math.random(1,#options)])
end)


--Redstone
--Adding creature shift spell to the wand would be cool, behaves similar to Fungal Shift spell
append_effect("apotheosis_redstone", function(wand)

    wand.manaMax = wand.manaMax + Random(80, 200)
    wand.rechargeTime = wand.rechargeTime - math.max(Random(1, 2), wand.rechargeTime * Randomf(0.05, 0.1))
    wand.castDelay = wand.castDelay - math.max(Random(1, 2), wand.castDelay * Randomf(0.05, 0.1))

    local options = { "MIST_BLOOD", "MATERIAL_BLOOD", "TOUCH_BLOOD", "CLOUD_BLOOD", "HITFX_CRITICAL_BLOOD" }
    wand:AttachSpells(options[math.random(1,#options)])
end)


--Divine Liquid
--2 Random stats gets super boosted
append_effect("apotheosis_magic_liquid_divine", function(wand)
    for k=1,2 do
        SetRandomSeed(k * GameGetFrameNum(), k * 666)
        local rnd = Random(1,8)

        if rnd == 1 then
            wand.spellsPerCast = math.min(wand.capacity, wand.spellsPerCast + 11)
        elseif rnd == 2 then
            wand.manaChargeSpeed = math.max(wand.manaChargeSpeed * 3, wand.manaChargeSpeed + 300)
        elseif rnd == 3 then
            wand.manaMax = math.max(wand.manaMax * 3, wand.manaMax + 400)
        elseif rnd == 4 then
            wand.speedMultiplier = wand.speedMultiplier * 5
        elseif rnd == 5 then
            wand.spread = wand.spread - 30
        elseif rnd == 6 then
            wand.rechargeTime = math.min(wand.rechargeTime * 0.33, wand.rechargeTime - 0.20)
        elseif rnd == 7 then
            wand.rechargeTime = math.min(wand.castDelay * 0.33, wand.castDelay - 0.20)
        else
            wand.capacity = math.min(math.max(wand.capacity * 2, wand.capacity + 6), 30)
        end
    end
end)


--Yggdrasil's Knowledge
--2 Random stats gets super boosted
append_effect("apotheosis_liquid_knowledge_of_kings", function(wand)
    for k=1,2 do
        SetRandomSeed(k * GameGetFrameNum(), k * 666)
        local rnd = Random(1,8)

        if rnd == 1 then
            wand.spellsPerCast = math.min(wand.capacity, wand.spellsPerCast + 11)
        elseif rnd == 2 then
            wand.manaChargeSpeed = math.max(wand.manaChargeSpeed * 3, wand.manaChargeSpeed + 300)
        elseif rnd == 3 then
            wand.manaMax = math.max(wand.manaMax * 3, wand.manaMax + 400)
        elseif rnd == 4 then
            wand.speedMultiplier = wand.speedMultiplier * 5
        elseif rnd == 5 then
            wand.spread = wand.spread - 30
        elseif rnd == 6 then
            wand.rechargeTime = math.min(wand.rechargeTime * 0.33, wand.rechargeTime - 0.20)
        elseif rnd == 7 then
            wand.rechargeTime = math.min(wand.castDelay * 0.33, wand.castDelay - 0.20)
        else
            wand.capacity = math.min(math.max(wand.capacity * 2, wand.capacity + 6), 30)
        end
    end
end)


--Cursed Liquid
--Random Stat Boosts
append_effect("apotheosis_cursed_liquid_red", function(wand)
    wand.spellsPerCast = math.max(1, wand.spellsPerCast + Random(-2, 2))
    wand.castDelay = wand.castDelay + Random(-24, 12)
    wand.rechargeTime = wand.rechargeTime + Random(-24, 12)
    wand.manaMax = math.max(100, wand.manaMax + Random(-400, 600))
    wand.manaChargeSpeed = math.max(30, wand.manaChargeSpeed + Random(-200, 300))
    wand.capacity = math.min(math.max(26, wand.capacity), wand.capacity + Random(0, 3))
    wand.spread = wand.spread + Random(-20, 10)
end)
append_effect("apotheosis_cursed_liquid_red_static", function(wand)
    wand.spellsPerCast = math.max(1, wand.spellsPerCast + Random(-2, 2))
    wand.castDelay = wand.castDelay + Random(-24, 12)
    wand.rechargeTime = wand.rechargeTime + Random(-24, 12)
    wand.manaMax = math.max(100, wand.manaMax + Random(-400, 600))
    wand.manaChargeSpeed = math.max(30, wand.manaChargeSpeed + Random(-200, 300))
    wand.capacity = math.min(math.max(26, wand.capacity), wand.capacity + Random(0, 3))
    wand.spread = wand.spread + Random(-20, 10)
end)





---------------------------Add Modded spells to vanilla liquids below------------------------------------------------------------------------------------------------------------------------------------

add_spells_to_effect("water", { "APOTHEOSIS_LIQUIDSPHERE_WATER" })
add_spells_to_effect("acid", { "APOTHEOSIS_LIQUIDSPHERE_ACID" })
add_spells_to_effect("magic_liquid_teleportation", { "APOTHEOSIS_LIQUIDSPHERE_TELEPORTATIUM" })
add_spells_to_effect("magic_liquid_unstable_teleportation", { "APOTHEOSIS_LIQUIDSPHERE_TELEPORTATIUM" })
