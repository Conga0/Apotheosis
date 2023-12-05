-- Copi note: removing spells from progress can have issues, imo better to make 0 spawn chance and give it a never spawn flag (see how my spell disabling works) so it stays in the menu, maybe change desc to say it won't spawn so it can still appear in progress? outright removing spells makes them dissapear from copis things spell disabling menu, so I suggest not doing so, I do intend to add a way for other mods to forcibly flag a spell as disabled so it shows up in my gui as disabled too
-- Conga note: Should be done now, hopefully this prevents them from ever spawning
-- Copi note: I just manually set the fields in this update to the file

-- Copi note 11/28/23: Not aware of any better way to manually decrement uses as of now, interfacing with hand[1] or current_action.uses_remaining seems to return -1 when MCd with reset

function refreshmissingcheck(deck,discarded)
    for k=1,#deck do
        if deck[k].id == "RESET" then
            return false
        end
    end
    return true
end

function disablecopying(recursion_level)
	local nocopy = not GameHasFlagRun("apotheosis_flag_copy_spells")
	if (recursion_level) ~= nil and nocopy then
		return true
	-- all below here is unholy blasphemous gun.lua adjacent hackery, consult me (copi) if it breaks
	elseif playing_permanent_card and nocopy then
		return true
		-- Copi: you should possibly add some fizzle particle or sound (might get annoying?) in this case @conga
	elseif not reflecting then
		local inventory = EntityGetFirstComponent( GetUpdatedEntityID(), "Inventory2Component" ) --[[@cast inventory number]]
		local spells = EntityGetAllChildren(ComponentGetValue2( inventory, "mActiveItem" )) or {}
        if refreshmissingcheck(deck,discarded) then
            for i=1, #spells do
                local itemcomp = EntityGetFirstComponentIncludingDisabled(spells[i], "ItemComponent") --[[@cast itemcomp number]]
                if current_action.inventoryitem_id == ComponentGetValue2(itemcomp, "mItemUid") then
                    local uses_remaining = ComponentGetValue2(itemcomp, "uses_remaining")
                    -- Decrement uses remaining manually
                    ComponentSetValue2(itemcomp, "uses_remaining", uses_remaining - 1)
                    current_action.uses_remaining = uses_remaining - 1
                    goto quit
                end
            end
        end
		::quit::
	end
	return false
end
--spell_apotheosis_alt_fire_cov_hardcore_name

local actions_to_edit = {

	-- Shitty workaround
    --Conga 02/12/2023: This happens in vanilla too, but heavy spread, octuple cast, heal bolt, heal bolt, heal bolt, wand refresh causes the bolts to cast twice. Whatever you say Nolla
	["RESET"] = {
		action = function ( )
            if playing_permanent_card then mana = mana + 20 end
			current_reload_time = current_reload_time - 25

			local copyspells = GameHasFlagRun("apotheosis_flag_copy_spells")
			local copylock_spells = {}

			for i,v in ipairs( hand ) do
				--copylock_spells[]
				if copyspells and v.hardcore_copylock then
					copylock_spells[v.inventoryitem_id] = true
				end
				table.insert( discarded, v )
			end

			if copyspells then
				local inventory = EntityGetFirstComponent( GetUpdatedEntityID(), "Inventory2Component" ) --[[@cast inventory number]]
				local spells = EntityGetAllChildren(ComponentGetValue2( inventory, "mActiveItem" )) or {}
				for i=1, #spells do
					local itemcomp = EntityGetFirstComponentIncludingDisabled(spells[i], "ItemComponent") --[[@cast itemcomp number]]
					if copylock_spells[ComponentGetValue2(itemcomp, "mItemUid")] then
						local uses_remaining = ComponentGetValue2(itemcomp, "uses_remaining")
						-- Decrement uses remaining manually
						ComponentSetValue2(itemcomp, "uses_remaining", uses_remaining + 1)
						goto quit
					end
				end
				::quit::
			end

			for i,v in ipairs( deck ) do
				-- print( "removed " .. v.id .. " from deck" )
				table.insert( discarded, v )
			end

			hand = {}
			deck = {}

			if ( force_stop_draws == false ) then
				force_stop_draws = true
				move_discarded_to_deck()
				order_deck()
			end
		end
	},

	--Fix Healing Bolt & Circle of Vigour to have updated spell descriptions
	--Make CoV spawn in Above & Below
	--Healing bolt & CoV can no longer be used by greek letters/splitshot
	["HEAL_BULLET"] = {
		description = "$spell_apotheosis_healing_bolt_desc",
        spawn_level                       = "2,3,4,5,6,10",
        spawn_probability                 = "1,1,1,2,2,0.2",
		custom_uses_logic = true,
		hardcore_copylock = true,
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
		custom_uses_logic = true,
		hardcore_copylock = true,
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

	["APOTHEOSIS_KAPPA"] = {
		action = function(recursion_level)
			local can_copy = reflecting or GameHasFlagRun("apotheosis_flag_copy_spells")
			c.fire_rate_wait = c.fire_rate_wait + 50


			if ( discarded ~= nil ) then
				for k=1,#discarded
				do local v = discarded[k]
					if ( v.type == ACTION_TYPE_PASSIVE ) and ( v.custom_uses_logic ) and (v.id ~= "APOTHEOSIS_ALT_FIRE_COV" or can_copy) then
						add_projectile(v.related_projectiles[1])
					end
				end
			end


			if ( deck ~= nil ) then
				for k=1,#deck
				do local v = deck[k]
					if ( v.type == ACTION_TYPE_PASSIVE ) and ( v.custom_uses_logic ) and (v.id ~= "APOTHEOSIS_ALT_FIRE_COV" or can_copy) then
						add_projectile(v.related_projectiles[1])
					end
				end
			end


			if ( hand ~= nil ) then
				for k=1,#hand
				do local v = hand[k]
					if ( v.type == ACTION_TYPE_PASSIVE ) and ( v.custom_uses_logic ) and (v.id ~= "APOTHEOSIS_ALT_FIRE_COV" or can_copy) then
						add_projectile(v.related_projectiles[1])
					end
				end
			end

		end
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
	["TELEPORT_PROJECTILE_STATIC"] = {
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
		spawn_probability = "2.0,2.0,2.0,1.6,1.6,1.6,1.6"
	},
	["APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT"] = {
		spawn_probability = "2.0,2.0,2.0,1.6,1.6,1.6,1.6"
	},

	--Copis Things compatibility for finite healing spells

	--Ophiuchus Arts can no longer be used by greek letters/splitshot
	--Update Ophiuchus Arts description to match the new functionality
	-- Copi: does this break disablecopying haxx? I may add alt custom strings to my own mod for the desc so it isn't hardcoded, unless the translations are done in apo
	["COPIS_THINGS_OPHIUCHUS"] = {
		description = "All your damage is halved, then converted to healing, and your projectile can hit you. The next spell costs twice as much mana. Uncopiable.",
		custom_uses_logic = true,
		hardcore_copylock = true,
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
	-- Copi: I may add alt custom strings to my own mod for the desc so it isn't hardcoded, unless the translations are done in apo
	["COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION"] = {
		description = "Creates a soothing rain that cures your wounds. Uncopiable.",
		custom_uses_logic = true,
		hardcore_copylock = true,
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