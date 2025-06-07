
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)
local pos_x,pos_y = EntityGetTransform(player_id)
local evscomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local curse_increment = ComponentGetValue2(evscomp,"value_float")
local curse_init = 0
local sound_muted = ComponentGetValue2(evscomp,"value_bool")
local curse_id = 0

--Check if player already has phantom curse inflicted
local children = EntityGetAllChildren(player_id)
if children then
    for k=1,#children
    do local v = children[k]
        if EntityGetName(v) == "apotheosis_phantom_curse" and v ~= entity_id then
            curse_id = v
            break
        end
    end
end

if curse_id ~= 0 then
    local uicomp = EntityGetFirstComponentIncludingDisabled(curse_id,"UIIconComponent")
    local vcomp = EntityGetFirstComponentIncludingDisabled(curse_id,"VariableStorageComponent")
    local curse = ComponentGetValue2(vcomp,"value_float") + curse_increment
    curse_init = ComponentGetValue2(vcomp,"value_float")
    ComponentSetValue2(vcomp,"value_float",curse)
    local text = GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_name")
    ComponentSetValue2(uicomp,"name",table.concat({string.format(text, curse),"%"}))

    local desc = GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_desc")

    --Potential curses:
    --Permanent vulnerability
    --Suffer wounding upon taking damage
    --Normal world orbs of true knowledge are considered cursed (Could synergize well with learning orb, granting a huge damage boost if you intentionally curse yourself)
    --Possess nearby objects (ukko rocks fly into the player?)
    --Limit health

    --Hints/Descriptors:
    --Your blood is eager to leave your body
    --The knowledge entering your mind feels corrupted
    --You feel you're having a hard time breathing
    --You feel you're having a very hard time breathing

    if curse >= 20 then
        --enable hardcore wounding
        EntitySetComponentsWithTagEnabled( player_id, "hardcore_healing", true )

        --Update ui icon & description
        desc = table.concat({desc,"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_01")})
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/curse_phantom_01.png")
    else
        --disable hardcore wounding
        EntitySetComponentsWithTagEnabled( player_id, "hardcore_healing", false )

        --Update ui icon & description
        desc = table.concat({desc,"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_00")})
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/curse_phantom_00.png")
    end

    if curse >= 40 then
        --enable corrupt knowledge

        --Update ui icon & description
        desc = table.concat({desc,"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_02")})
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/curse_phantom_02.png")
    else
        --disable corrupt knowledge
    end

    if curse >= 60 then
        --Limit health to 75% of max
        GlobalsSetValue("apotheosis_healthcap","0.75")

        --Update health if it's above this threshold
        local health_cap = 0.75
        local hpcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        local hp_max = ComponentGetValue2(hpcomp,"max_hp")
        local hp = ComponentGetValue2(hpcomp,"hp")
        local hp_limit = hp_max * health_cap
        if hp > hp_limit then
            EntityInflictDamage( player_id, 0.04, "DAMAGE_CURSE", "jojo fans when they see 2 identical rocks", "NONE", 0, 0, player_id )
            ComponentSetValue2(hpcomp,"hp",hp_limit)
        end

        --Update ui icon
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/curse_phantom_03.png")
    else
        --Restore health cap to 100%
        GlobalsSetValue("apotheosis_healthcap","1")
    end

    if curse >= 80 then
        --Limit health to 50% of max
        GlobalsSetValue("apotheosis_healthcap","0.5")

        --Update health if it's above this threshold
        local health_cap = 0.5
        local hpcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        local hp_max = ComponentGetValue2(hpcomp,"max_hp")
        local hp = ComponentGetValue2(hpcomp,"hp")
        local hp_limit = hp_max * health_cap
        if hp > hp_limit then
            EntityInflictDamage( player_id, 0.04, "DAMAGE_CURSE", "jojo fans when they see 2 identical rocks", "NONE", 0, 0, player_id )
            ComponentSetValue2(hpcomp,"hp",hp_limit)
        end

        --Update ui icon
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/curse_phantom_04.png")
    end

    --Update description
    if curse >= 80 then
        desc = table.concat({desc,"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_04")})
    elseif curse >= 60 then
        desc = table.concat({desc,"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_03")})
    end

    --Inflict fatal damage at full curse
    if curse >= 100 then
        local text = GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_name")
        local hpcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        local hp_max = ComponentGetValue2(hpcomp,"max_hp")
        EntityInflictDamage( player_id, hp_max * 100, "DAMAGE_CURSE", text, "NONE", 0, 0, player_id )

        --Update ui icon & description
        desc = table.concat({desc,"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_05")})
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/curse_phantom_05.png")
    end

    if curse <= 0 then
        EntityKill(curse_id)
    end

    --Update the ui icon description with hints towards the curse's effects
    ComponentSetValue2(uicomp,"description",desc)
elseif curse_increment > 0 then
    local c = EntityLoad("mods/Apotheosis/files/entities/misc/curse_phantom.xml",pos_x, pos_y)
    local uicomp = EntityGetFirstComponentIncludingDisabled(c,"UIIconComponent")
    local text = GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_name")
    ComponentSetValue2(uicomp,"name",table.concat({string.format(text, curse_increment),"%"}))
    ComponentSetValue2(uicomp,"description",table.concat({GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_desc"),"\n",GameTextGetTranslatedOrNot("$status_apotheosis_phantom_curse_state_00")}))
    local vcomp = EntityGetFirstComponentIncludingDisabled(c,"VariableStorageComponent")
    ComponentSetValue2(vcomp,"value_float",curse_increment)
    EntityAddChild(player_id,c)
end

--I don't like using this sound, it'll mislead the player into thinking their own spells ran out of charges
if EntityHasTag(player_id,"player_unit") then
    if curse_increment > 0 and sound_muted == false then
        GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/action_consumed", pos_x, pos_y )
    elseif curse_increment < 0 then
        --Blessing sound, removing curse from the player
        GamePlaySound( "data/audio/Desktop/projectiles.bank", "projectiles/revive/destroy", pos_x, pos_y )
    end

    --Play sound to notify the player their curse reached a new breakpoint
    local breakpoints = {20,40,60,80,100}
    for k=1,#breakpoints do
        local breakpoint = breakpoints[k]
        if curse_init < breakpoint and curse_init + curse_increment >= breakpoint then
	        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/greed_curse/create", pos_x, pos_y )
            GamePrint("The curse sinks deeper...")
            break
        end
    end
end

EntityKill(entity_id)