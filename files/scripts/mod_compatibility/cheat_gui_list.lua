
local apoth_items = {
    {path="mods/Apotheosis/files/entities/items/pickups/heretical_eye.xml", name="$item_apotheosis_heretical_eye_name", xml="heretical_eye.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/stone_heretic.xml", name="$item_apotheosis_stone_heretic_name", xml="stone_heretic.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/stone_radar.xml", name="$item_apotheosis_stone_radar_name", xml="stone_radar.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/stone_fungus.xml", name="$item_apotheosis_fungus_stone_name", xml="stone_fungus.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/orb_affluence.xml", name="$item_apotheosis_orb_affluence_name", xml="orb_affluence.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/orb_cirno.xml", name="$item_apotheosis_orb_cirno_name", xml="orb_cirno.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml", name="$item_apotheosis_orb_mattereater_name", xml="orb_mattereater.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/potion_reinforced.xml", name="$item_apotheosis_potion_reinforced_name", xml="potion_reinforced.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/potion_rare.xml", name="Rare Potion", xml="potion_rare.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/potion_mimicium.xml", name="Mimicium Potion", xml="potion_mimicium.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/fishing_rod.xml", name="$item_apotheosis_fishing_rod_name", xml="fishing_rod.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/egg_volcanic_lukki.xml", name="$item_apotheosis_egg_fire_lukki_name", xml="egg_volcanic_lukki.xml"},
    {path="data/entities/items/pickup/apotheosis/egg_fairy.xml", name="$item_apotheosis_egg_fairy_name", xml="egg_fairy.xml"},
    {path="data/entities/items/pickup/apotheosis/egg_mud.xml", name="$item_apotheosis_egg_mud_name", xml="egg_mud.xml"},
    {path="data/entities/items/pickup/apotheosis/egg_robot.xml", name="$item_apotheosis_egg_robot_name", xml="egg_robot.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/waterstone_pink.xml", name="$item_apotheosis_stone_water_pink", xml="waterstone_pink.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/perk_angler.xml", name="$item_apotheosis_skill_angler_name", xml="perk_angler.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/perk_copyspells.xml", name="$perk_apotheosis_copy_spells", xml="perk_copyspells.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/perk_ourgift.xml", name="$perk_apotheosis_infinite_flight", xml="perk_ourgift.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/essence_fungus.xml", name="$item_apotheosis_essence_fungus_name", xml="essence_fungus.xml"},
    {path="mods/Apotheosis/files/entities/downunder/items/pickups/essence_water.xml", name="$item_apotheosis_essence_polymorphine_reveal_name", xml="downunder/essence_water.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/runestones/runestone_alchemy.xml", name="$item_apotheosis_runestone_alchemy_name", xml="runestone_alchemy.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/chest_portals.xml", name="$item_apotheosis_chest_portals", xml="chest_portals.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/chest_random_cursed.xml", name="$item_apotheosis_chest_cursed", xml="chest_random_cursed.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/chest_volcanic.xml", name="$item_apotheosis_chest_volcanic", xml="chest_volcanic.xml"},
    {path="mods/Apotheosis/files/entities/items/pickups/chest_death_cross.xml", name="$item_apotheosis_chest_death_cross", xml="chest_death_cross.xml"},
    {path="mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml", name="$wand_apotheosis_wand_of_wonders_name", xml="wand_of_wonders.xml"},
    {path="mods/Apotheosis/files/entities/items/wands/custom/rat_wand.xml", name="$wand_apotheosis_rat_name", xml="rat_wand.xml"},
    {path="mods/Apotheosis/files/entities/items/wands/custom/cat_wand.xml", name="$wand_apotheosis_cat_name", xml="cat_wand.xml"},
    {path="mods/Apotheosis/files/entities/items/wands/custom/mana_battery.xml", name="$wand_apotheosis_mana_battery_name", xml="mana_battery.xml"},
    {path="mods/Apotheosis/files/entities/items/wands/custom/deck_of_cards.xml", name="$wand_apotheosis_deck_of_cards_name", xml="deck_of_cards.xml"},
    {path="mods/Apotheosis/files/entities/items/wands/custom/aimbot_wand.xml", name="$wand_apotheosis_aimbot_name", xml="aimbot_wand.xml"},
}

local valid = true

if valid then
    for k=1,#apoth_items do
        table.insert(special_spawnables,apoth_items[k])
    end
    valid = false
end
