dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

function shot( projectile_id )
    if projectile_id == nil then return end
    local comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"ProjectileComponent")
    ComponentSetValue2(comp,"friendly_fire",true)
end

function damage_received( damage, desc, entity_who_caused, is_fatal )
    local entity_id    = GetUpdatedEntityID()
    local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    local current_modifiers = tonumber(ComponentGetValue2(vcomp,"value_string"))
    if has_bit_flag(current_modifiers,2) then
        local pos_x, pos_y = EntityGetTransform(entity_id)
        local targ_x, targ_y = EntityGetTransform( entity_who_caused )

        if( entity_who_caused == 0 ) then return end
        local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/orb_holy_pixie.xml",pos_x,pos_y)
        GameShootProjectile( entity_id, pos_x, pos_y, targ_x, targ_y, pid)
        
        GameEntityPlaySound( entity_id, "shoot" )
    end
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local current_level = ComponentGetValue2(vcomp,"value_int")
local current_exp = ComponentGetValue2(vcomp,"value_float")
local current_modifiers = tonumber(ComponentGetValue2(vcomp,"value_string"))
SetRandomSeed(pos_x * pos_y,pos_x + pos_y)

local level_table = {
    200, --A level 1 pixie needs 200 hp worth of kills to level up
    800, --A level 2 pixie needs 800 hp worth of kills to level up
    3200, --A level 1 pixie needs 3200 hp worth of kills to level up
    12800 --A level 1 pixie needs 12800 hp worth of kills to level up
}

local stats_table = {
    {
        --Level 1 pixie stats
        hp = 10,
    },
    {
        --Level 2 pixie stats
        hp = 30,
        dmg_mult_projectile = 0.5,
        dmg_mult_explosion = 0.5,
        main_attack = "mods/Apotheosis/files/entities/projectiles/orb_holy_pixie.xml",
    },
    {
        --Level 3 pixie stats
        hp = 120,
        breathless = true,
        main_attack = "mods/Apotheosis/files/entities/projectiles/orb_holy_shotgun.xml",
        main_attack_count_min = 7,
        main_attack_count_max = 7,
        matter_eater = true,
        new_tag = "polymorphable_NOT",
    },
    {
        --Level 4 pixie stats
        hp = 500,
        dmg_mult_projectile = 0.25,
        dmg_mult_explosion = 0.25,
        dmg_mult_melee = 0.5,
        new_tag = "touchmagic_immunity",
        --Add health regeneration
    }
}

function PixieSetLevel(new_level)
    local dcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    ComponentSetValue2(dcomp,"max_hp",stats_table[new_level].hp)
    ComponentSetValue2(dcomp,"hp",stats_table[new_level].hp)
    if stats_table[new_level].breathless then ComponentSetValue2(dcomp,"air_needed",false) end
    if stats_table[new_level].dmg_mult_projectile then ComponentObjectSetValue2( dcomp, "damage_multipliers", "projectile", stats_table[new_level].dmg_mult_projectile ) end
    if stats_table[new_level].dmg_mult_explosion then ComponentObjectSetValue2( dcomp, "damage_multipliers", "explosion", stats_table[new_level].dmg_mult_explosion ) end
    if stats_table[new_level].dmg_mult_electricity then ComponentObjectSetValue2( dcomp, "damage_multipliers", "electricity", stats_table[new_level].dmg_mult_electricity ) end
    if stats_table[new_level].dmg_mult_melee then ComponentObjectSetValue2( dcomp, "damage_multipliers", "melee", stats_table[new_level].dmg_mult_melee ) end
    if stats_table[new_level].dmg_mult_fire then ComponentObjectSetValue2( dcomp, "damage_multipliers", "fire", stats_table[new_level].dmg_mult_fire ) end
    if stats_table[new_level].dmg_mult_ice then ComponentObjectSetValue2( dcomp, "damage_multipliers", "ice", stats_table[new_level].dmg_mult_ice ) end
    if stats_table[new_level].dmg_mult_drill then ComponentObjectSetValue2( dcomp, "damage_multipliers", "drill", stats_table[new_level].dmg_mult_drill ) end

    local aaicomp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
    if stats_table[new_level].main_attack then ComponentSetValue2(aaicomp, "attack_ranged_entity_file", stats_table[new_level].main_attack) ComponentSetValue2(aaicomp, "attack_ranged_enabled", true) end
    if stats_table[new_level].main_attack_count_min then ComponentSetValue2(aaicomp, "attack_ranged_entity_count_min", stats_table[new_level].main_attack_count_min) end
    if stats_table[new_level].main_attack_count_max then ComponentSetValue2(aaicomp, "attack_ranged_entity_count_max", stats_table[new_level].main_attack_count_max) end

    local cecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"CellEaterComponent")
    if stats_table[new_level].matter_eater then EntitySetComponentIsEnabled( entity_id, cecomp, true ) end

    if stats_table[new_level].new_tags then EntityAddTag(entity_id,stats_table[new_level].new_tag) end
end

function PixieCheckExp(level,exp)
    local exp_needed = level_table[level]
    if exp > exp_needed then
        GamePrint("Pixie is now level " .. level+1)
        ComponentSetValue2(vcomp,"value_int",level + 1)
        ComponentSetValue2(vcomp,"value_float",exp - exp_needed)
        PixieSetLevel(level+1)
    end
end

function ApplyLevellingScript(pos_x,pos_y)
    local targets = EntityGetInRadiusWithTag(pos_x,pos_y,256,"mortal") or {}
    local did_shoot = false
    for k=1,#targets do
        local v = targets[k]
        if v ~= entity_id then
            local found_script = false
            local v_lcomps = EntityGetComponentIncludingDisabled(v,"LuaComponent") or {}
            for z=1,#v_lcomps do
                if ComponentGetValue2(v_lcomps[z],"script_death") == "mods/Apotheosis/files/scripts/animals/pixie_kill_tracker.lua" then
                    found_script = true
                    break
                end
            end

            --Add death script to the entity to reward pixie exp when they die
            if found_script == false then
            EntityAddComponent2(
                v,
                "LuaComponent",
                {
                    execute_on_added = false,
                    script_death = "mods/Apotheosis/files/scripts/animals/pixie_kill_tracker.lua",
                    execute_every_n_frame = -1,
                    remove_after_executed = false,
                    execute_times=-1
                }
            )
            end
        end
    end
end

--Raytrace to the victim?
--Beam needs line of sight to kill them, creates an explosion on contact with either terrain or ground, ignore liquids
function AttackBeam(pos_x,pos_y,base_damage, percent_damage)
    SetRandomSeed(pos_x+pos_y,pos_y + 777)
    local targets = EntityGetInRadiusWithTag(pos_x,pos_y,256,"mortal") or {}
    for k=1,#targets do
        local v = targets[k]
        local targ_x, targ_y = EntityGetTransform(v)
        --local did_hit, hit_x, hit_y = RaytraceSurfaces( pos_x, pos_y, targ_x, targ_y )

        --Pick an entity at random, that's within line of sight, then after a 4 second delay blast them with a death laser
        if v ~= entity_id and Random(1,#targets-k + 1) == 1 then
            --Play audio when zapping victim
            GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", pos_x, pos_y )
            GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", pos_x, pos_y )

            --Inflict Damage
            local v_hpcomp = EntityGetFirstComponentIncludingDisabled(v,"DamageModelComponent")
            local v_hp = ComponentGetValue2(v_hpcomp,"max_hp")
            EntityInflictDamage( v, base_damage + (v_hp * percent_damage), table.concat({"DAMAGE_HOLY"}), "$enemy_apotheosis_pixie", "NONE", 0, 0, entity_id )

            --Graphics
            --Here we load an entity to trail a draw, then tell that trail to draw from the projectile to the target
            --Conga: Could be optimised with the new GameCreateCosmeticParticle function? Uncertain if worth the effort
            local child = EntityLoad("mods/Apotheosis/files/entities/animators/pixie_beam_fx_large.xml", targ_x, targ_y - 6)
            local comp = EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent")
            ComponentSetValue2(comp, "mExPosition", pos_x, pos_y)

            return
        end
    end
end

function AttackAura(pos_x,pos_y,damage,radius)
    local targets = EntityGetInRadiusWithTag(pos_x,pos_y,radius,"mortal") or {}
    local did_shoot = false
    for k=1,#targets do
        local v = targets[k]
        if v ~= entity_id then
            --Inflict Damage
            local v_hpcomp = EntityGetFirstComponentIncludingDisabled(v,"DamageModelComponent")
            local v_hp = ComponentGetValue2(v_hpcomp,"max_hp")
            EntityInflictDamage( v, damage + (v_hp * 0.02), table.concat({"DAMAGE_HOLY"}), "$enemy_apotheosis_pixie", "NONE", 0, 0, entity_id )

            --Graphics
            --Here we load an entity to trail a draw, then tell that trail to draw from the projectile to the target
            --Conga: Could be optimised with the new GameCreateCosmeticParticle function? Uncertain if worth the effort
            local targ_x, targ_y = EntityGetTransform(v)
            local child = EntityLoad("mods/Apotheosis/files/entities/animators/pixie_beam_fx.xml", targ_x, targ_y - 6)
            local comp = EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent")
            ComponentSetValue2(comp, "mExPosition", pos_x, pos_y)

            --Play audio when zapping victims
            GamePlaySound( "data/audio/Desktop/animals.bank", "animals/wraith_storm/damage/explosion", targ_x, targ_y )
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------- Actual AI Behavior Below -----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

local current_frame = GameGetFrameNum()

--Check if it's time to level up every second
if current_frame % 60 == 0 then
    GamePrint("Pixie exp is now " .. current_exp)
    PixieCheckExp(current_level,current_exp)
end

--Attack where the pixie glows brightly before letting loose a sudden laserbeam that does (100 * level) + 5% victim health damage?
--Pixie gains a shield at higher levels
--Projectile repulsion aura if it kills something related to air?
--Mage projectiles if it kills mages
--Gains the ability to teleport if it kills teleport-capable enemies or drinks teleportation (liquid suction field around the pixie?)

--Basic levelling behavior below
--Every second, damage nearby entities for (10 * current_level) damage
if current_frame % 60 == 0 then
    AttackAura(pos_x,pos_y,current_level * 0.40, 24 + math.min(current_level * 24,48))
end

--Every 11 seconds shoot a large laserbeam if the pixie is level 3 or greater
if current_frame % 660 == 0 then
    if current_level >= 3 then
        AttackBeam(pos_x,pos_y,4 * (current_level - 2), 0.10)
    end
end

--Every 5 seconds, make sure nearby entities are viable to level up pixies
if current_frame % 300 == 0 then
    ApplyLevellingScript(pos_x,pos_y)
end

--Special Modifiers below
--Every 6 seconds, try to teleport
if current_frame % 360 == 0 and has_bit_flag(current_modifiers,1) then
    
    local aaicomp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
    local target = ComponentGetValue2(aaicomp,"mGreatestThreat")
    if target > 0 then
        local targ_x,targ_y = EntityGetTransform(target)
        local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/teleport_projectile_invisible.xml",pos_x,pos_y)
        GameShootProjectile( entity_id, pos_x, pos_y, targ_x, targ_y, pid)

        --25% chance to immediately jump back after teleporting
        if Random(1,4) == 1 then
            local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/teleport_projectile_invisible_static.xml",pos_x,pos_y)
            GameShootProjectile( entity_id, pos_x, pos_y, pos_x, pos_y, pid)
        end
    end
end