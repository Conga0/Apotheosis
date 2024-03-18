dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local vel_x, vel_y = ComponentGetValue2(comp,"mTargetVec")
local cooldown = -10000
local cooldowncomp = 0
local frame = GameGetFrameNum()
local cooldown_duration = 7 * 60 --In Seconds

local cooldown_bigacid = 0

local VSCs = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
for k=1,#VSCs
do local v = VSCs[k]
    if ComponentGetValue2(v,"name") == "acid_atk_storage" then
        cooldown = ComponentGetValue2(v,"value_int")
        cooldown_bigacid = ComponentGetValue2(v,"value_float")
        cooldowncomp = v
    end
end

if frame > cooldown + cooldown_duration and cooldown_bigacid < 5 then
    vel_x = vel_x * math.random(800,900)
    vel_y = vel_y * math.random(800,900)
    shoot_projectile( entity_id, "data/entities/animals/boss_adult_centipede/projectiles/acidshot.xml", pos_x, pos_y, vel_x, vel_y )
    if frame > cooldown + cooldown_duration + 60 then
        --set acid attack back on CD, increment towards acid sphere attack
        ComponentSetValue2(cooldowncomp,"value_int",frame)
        ComponentSetValue2(cooldowncomp,"value_float",cooldown_bigacid + 1)
    end
elseif cooldown_bigacid >= 5 then
    vel_x = vel_x * 900
    vel_y = vel_y * 900
    --Conga:
    --Cool particle effect to "charge up" a big acid shot would be sick here
    --However.. This attack struggles to hit.. well, anything
    --
    --Original idea for this boss is it would spit large amounts of acid-based attacks as well as summon enslaved ants to come to it's aid
    --However, I feel the acid conflicts with the ants, this may be a nice piece of subtle story telling as it shows how the adult centipede's acid both annihilates the ants, and their queen by relation, but also
    --Show how little regard the centipede has for it's victim's life.
    --However, what good is a boss that's killing it's own minions for you; then never hits you with it's own attacks?
    --Maybe worm bosses are harder to work with than I thought
    shoot_projectile( entity_id, "data/entities/animals/boss_adult_centipede/projectiles/liquidsphere_acid.xml", pos_x, pos_y, vel_x, vel_y )

    --Set acid attack back on CD, reset acid sphere attack increment
    ComponentSetValue2(cooldowncomp,"value_float",0)
    ComponentSetValue2(cooldowncomp,"value_int",frame)
end
