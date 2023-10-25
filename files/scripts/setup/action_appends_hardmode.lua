-- Copi note: removing spells from progress can have issues, imo better to make 0 spawn chance and give it a never spawn flag (see how my spell disabling works) so it stays in the menu, maybe change desc to say it won't spawn so it can still appear in progress? outright removing spells makes them dissapear from copis things spell disabling menu, so I suggest not doing so, I do intend to add a way for other mods to forcibly flag a spell as disabled so it shows up in my gui as disabled too
-- Conga note: Should be done now, hopefully this prevents them from ever spawning
-- Copi note: I just manually set the fields in this update to the file

function disablecopying(recursion_level)
    if (recursion_level) ~= nil and GameHasFlagRun("apotheosis_flag_copy_spells") == false then return true
    else return false
    end
end

--spell_apotheosis_alt_fire_cov_hardcore_name

local actions_to_edit = {

    --Fix Healing Bolt & Circle of Vigour to have updated spell descriptions
    --Make CoV spawn in Above & Below
    --Healing bolt & CoV can no longer be used by greek letters/splitshot
    ["HEAL_BULLET"] = {
        description = "$spell_apotheosis_healing_bolt_desc",
        action = function(recursion_level)
            --if (recursion_level) ~= nil then return; end
            if disablecopying(recursion_level) then return; end
            add_projectile("data/entities/projectiles/deck/heal_bullet.xml")
            c.fire_rate_wait = c.fire_rate_wait + 4
            c.spread_degrees = c.spread_degrees + 2.0
        end,
    },

    ["REGENERATION_FIELD"] = {
        description = "$spell_apotheosis_cov_desc",
        spawn_level = "1,2,3,4,10",
        spawn_probability = "0.2,0.2,0.2,0.2,2.0",
        action = function(recursion_level)
            --if (recursion_level) ~= nil then return; end
            if disablecopying(recursion_level) then return; end
            add_projectile("data/entities/projectiles/deck/regeneration_field.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },

    ["APOTHEOSIS_ALT_FIRE_COV"] = {
        description = "$spell_apotheosis_alt_fire_cov_hardcore_desc",
    },

    --Remove Teleport Bolts from the spell pool
    ["TELEPORT_PROJECTILE"] = {
        spawn_level = "0",
        spawn_probability = "0",
        spawn_requires_flag = "this_should_never_spawn",
    },
    ["TELEPORT_PROJECTILE_SHORT"] = {
        spawn_level = "0",
        spawn_probability = "0",
        spawn_requires_flag = "this_should_never_spawn",
    },
    ["GRAHAM_TELEPORT"] = {
        spawn_level = "0",
        spawn_probability = "0",
        spawn_requires_flag = "this_should_never_spawn",
    },

    --Increases the spawnrate of alt-fire teleport spells to compensate
    ["APOTHEOSIS_ALT_FIRE_TELEPORT"] = {
        spawn_probability = "1.0,0.8,0.8,0.6,0.6,0.6,1.6"
    },
    ["APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT"] = {
        spawn_probability = "1.0,0.8,0.8,0.6,0.6,0.6,1.6"
    },

    --Copis Things compatibility for finite healing spells

	--Ophiuchus Arts can no longer be used by greek letters/splitshot
	--Update Ophiuchus Arts description to match the new functionality
    ["COPIS_THINGS_OPHIUCHUS"] = {
        description = "All your damage is halved, then converted to healing, and your projectile can hit you. The next spell costs twice as much mana. Uncopiable.",
        action = function(recursion_level)
			--if (recursion_level) ~= nil then return; end
            if disablecopying(recursion_level) then return; end
            copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/particles/healing.xml,mods/copis_things/files/entities/misc/ophiuchus.xml,"
            c.friendly_fire = true
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 12
            draw_actions(1, true)
		end
    },

	--Healthy Cloud can no longer be used by greek letters/splitshot
	--Update Healthy Cloud description to match the new functionality
    ["COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION"] = {
        description = "Creates a soothing rain that cures your wounds. Uncopiable.",
        action =  function(recursion_level)
			--if (recursion_level) ~= nil then return; end
            if disablecopying(recursion_level) then return; end
            add_projectile("mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
		end,
    },
}

for i=1,#actions do -- fast as fuck boi
    if actions_to_edit[actions[i].id] then
        for key, value in pairs(actions_to_edit[actions[i].id]) do
            actions[i][key] = value
        end
        actions[i]['apotheosis_reworked'] = true
    end
end
