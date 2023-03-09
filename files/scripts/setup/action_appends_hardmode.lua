
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