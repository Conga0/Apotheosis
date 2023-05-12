-- Copio todo: use the table system for spell modification at some point

--Function for modifying existing spells
function modify_existing_spell(spell_id, parameter_to_modify, new_value)
	for i, spell in ipairs(actions) do
		if spell.id == spell_id then
			spell[parameter_to_modify] = new_value
			break
		end
	end
end

--CoV can no longer be used by greek letters/splitshot
modify_existing_spell(
	"REGENERATION_FIELD",
	"action",
    function(recursion_level)
        if (recursion_level) ~= nil then return; end
        --if disablecopying(recursion_level) then return; end
        add_projectile("data/entities/projectiles/deck/regeneration_field.xml")
        c.fire_rate_wait = c.fire_rate_wait + 15
    end
)

--Healing bolt can no longer be used by greek letters/splitshot
modify_existing_spell(
	"HEAL_BULLET",
	"action",
    function(recursion_level)
        if (recursion_level) ~= nil then return; end
        --if disablecopying(recursion_level) then return; end
        add_projectile("data/entities/projectiles/deck/heal_bullet.xml")
        c.fire_rate_wait = c.fire_rate_wait + 4
        c.spread_degrees = c.spread_degrees + 2.0
    end
)


--Fix Healing Bolt & Circle of Vigour to have updated spell descriptions
modify_existing_spell("REGENERATION_FIELD","description","$spell_apotheosis_cov_desc")
modify_existing_spell("HEAL_BULLET","description","$spell_apotheosis_healing_bolt_desc")

--Make CoV spawn in Above & Below
modify_existing_spell("REGENERATION_FIELD","spawn_level","1,2,3,4,10")
modify_existing_spell("REGENERATION_FIELD","spawn_probability","0.2,0.2,0.2,0.2,0.5")


--Remove Spells
function remove_spell(spell_name)
	local key_to_spell = nil
    for k=1,#actions
    do v = actions[k]
		if (v.id == spell_name) then
			key_to_spell = key
		end
	end

	if (key_to_spell ~= nil) then
		table.remove(actions, key_to_spell)
	end
end

--Remove Teleport Bolts from the spell pool
remove_spell("TELEPORT_PROJECTILE")
remove_spell("TELEPORT_PROJECTILE_SHORT")
remove_spell("GRAHAM_TELEPORT")

-- Copi note: removing spells from progress can have issues, imo better to make 0 spawn chance and give it a never spawn flag (see how my spell disabling works) so it stays in the menu, maybe change desc to say it won't spawn so it can still appear in progress? outright removing spells makes them dissapear from copis things spell disabling menu, so I suggest not doing so, I do intend to add a way for other mods to forcibly flag a spell as disabled so it shows up in my gui as disabled too

--Increases the spawnrate of alt-fire teleport spells to compensate
modify_existing_spell("APOTHEOSIS_ALT_FIRE_TELEPORT","spawn_probability","1.0,0.8,0.8,0.6,0.6,0.6,1.6")
modify_existing_spell("APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT","spawn_probability","1.0,0.8,0.8,0.6,0.6,0.6,1.6")


--Copis Things compatibility for finite healing spells
if ModIsEnabled("copis_things") then
	
	--Ophiuchus Arts can no longer be used by greek letters/splitshot
	modify_existing_spell(
		"COPIS_THINGS_OPHIUCHUS",
		"action",
		function(recursion_level)
			if (recursion_level) ~= nil then return; end
            copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/particles/healing.xml,mods/copis_things/files/entities/misc/ophiuchus.xml,"
            c.friendly_fire = true
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 12
            draw_actions(1, true)
		end
	)
	
	--Healthy Cloud can no longer be used by greek letters/splitshot
	modify_existing_spell(
		"COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION",
		"action",
		function(recursion_level)
			if (recursion_level) ~= nil then return; end
            add_projectile("mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
		end
	)

	--Update Ophiuchus Arts description to match the new functionality
	modify_existing_spell("COPIS_THINGS_OPHIUCHUS","description","All your damage is halved, then converted to healing, and your projectile can hit you. The next spell costs twice as much mana. Uncopiable.")

	--Update Healthy Cloud description to match the new functionality
	modify_existing_spell("COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION","description","Creates a soothing rain that cures your wounds. Uncopiable.")
end