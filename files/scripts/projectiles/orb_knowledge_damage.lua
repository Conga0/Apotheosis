
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local orbcount = tonumber(GlobalsGetValue("DEBUG_ORBS","0"))--GameGetOrbCountThisRun() + tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") ) --Three-Eyed Orb? Kolmi-orb?
local damage = ComponentGetValue2(comp,"damage")
damage = damage * (1 + (0.1 * orbcount)) + (0.2 * orbcount) -- +10% damage increase, plus 5 flat damage per orb collected
ComponentSetValue2(comp,"damage",damage)

--todo: make this work with every damage type instead of just projectile damage.
--Flat damage increases shouldn't apply to other damage types, just the multiplier
--Icon is an orb with an opened book inside
--If cursed knowledge is acquired, enable self-damage
