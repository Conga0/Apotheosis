
local entity = GetUpdatedEntityID() 

local root = EntityGetRootEntity( entity ) 

local x, y = EntityGetTransform(root) 
local max_hp = 0
local hp = 0
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" ) 

if damagemodel == nil then return end

local curse_damage = ComponentObjectGetValue2( damagemodel, "damage_multipliers", "curse" ) 

--Would be kind of funny if an enemy with a negative curse damage multiplier killed Heretic, but I don't want to encourage negative curse damage in any sense...
if curse_damage <= 0 then return end

local ambrosia = false
local c = EntityGetAllChildren( root )
if c ~= nil then
	for a,b in ipairs( c ) do
		local comps = EntityGetComponent( b, "GameEffectComponent", "PROTECTION_ALL" )

		if ( comps ~= nil ) then
			ambrosia = true
			break
		end
	end
end

if ambrosia == true then return end

max_hp = ComponentGetValue2( damagemodel, "max_hp" ) 
hp = ComponentGetValue2( damagemodel, "hp" ) 

local damage = max_hp / 200

if EntityHasTag( root, "enemy") and not EntityHasTag( root, "boss") and max_hp <= 350 then
	damage = max_hp / 45
	--Probably a miniboss... go easier on 'em.
	if max_hp >= 150 then
		damage = max_hp / 120
	end
end

if damage >= hp then
	damage = hp
end

--Heretic will still heal himself if you somehow cheat and end up with negative HP
if damage < 0 then
	damage = damage * -1
end

--Heretic gets a heal boost mattering on the players max health, cause it is pitiful when the player is low on max hp
local heal = damage
local max_heal = 1 --Heals capped at 25
if EntityHasTag( root, "player_unit") then
	heal = max_hp / 20

	if heal >= max_heal then
		heal = max_heal
	end
end

--I am sadly not smart enough to make an intuitive life sap that can be used by others right now... 
--So let's just give Heretic a nice pat on the back and some health inspite of wherever he is in the world :)
local heretic_id = 0
local boss = EntityGetWithTag( "miniboss" ) or nil
for bp=1,#boss do
    if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_flesh_monster" then
	heretic_id = boss[bp]
	local heretic_hp = 0
	local heretic_max_hp = 0
	local heretic_damagemodel = EntityGetFirstComponentIncludingDisabled( boss[bp], "DamageModelComponent" ) 
	heretic_hp = ComponentGetValue2( heretic_damagemodel, "hp" ) 
	heretic_max_hp = ComponentGetValue2( heretic_damagemodel, "max_hp" ) 

	if (heal + heretic_hp >= heretic_max_hp) then
	    ComponentSetValue2( heretic_damagemodel, "hp", heretic_max_hp ) 
	else
	    ComponentSetValue2( heretic_damagemodel, "hp", heretic_hp + heal ) 
	end
    end
end

EntityInflictDamage( root, damage , "DAMAGE_CURSE", "$status_apotheosis_life_drain_name", "PLAYER_RAGDOLL_CAMERA", 0, 0, heretic_id) 