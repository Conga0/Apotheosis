dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x,y = EntityGetTransform( root_id )

if not EntityGetIsAlive(root_id) then return end

local angle = 0

local stone_found = false
local stone_id = nil

if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
	local heretic_stones = EntityGetInRadiusWithTag(pos_x,pos_y,145000,"poopstone") or {}
	for k=1,#heretic_stones
	do local v = heretic_stones[k]
		local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
		if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
			stone_id = v
			stone_found = true
			break
		end
	end
end

local him = false
local wizard_id = nil
local wizard = EntityGetInRadiusWithTag(x,y,400,"boss") or {}
for k=1,#wizard
do local v = wizard[k]
	if ( EntityGetName(v) == "$animal_boss_wizard" ) then
		--OH NO IT'S HIM!
		him = true
		wizard_id = v
		break
	elseif ( EntityGetName(v) == "$animal_boss_centipede" ) then
		--oh it's uh... this guy... I think I've heard of him being strong?
		--so uh... I guess I'll leave.
		him = true
		wizard_id = v
		break
	end
end

--While fun for flavor and giving Heretic personality, might be a bit too resource intensive ,:)
--Nevermind, dextercd himself confirmed that it seems fine so I'm doing it!!!
local dislike = false
local targets = EntityGetInRadiusWithTag( x, y, 80, "mortal" ) or {}
local target_id = nil
local biggest_hp = -10

for k=1, #targets
do local v = targets[k]
	if v ~= root_id then
		local genome = EntityGetFirstComponent(v, "GenomeDataComponent") or nil
		local hatred_found = false
		local list = {"$enemy_apotheosis_poring_holy","$enemy_apotheosis_poring_holy_arch","$enemy_apotheosis_poring_devil","$enemy_apotheosis_angel"}
		for s=1, #list 
		do local hated = list[s]
			if ( EntityGetName(v) == hated ) then
				hatred_found = true
			end
		end
		if genome ~= nil and ((EntityGetHerdRelation(root_id, v) < 40) or hatred_found == true) then
			dislike = true
			--Checks their hp and sees if it is bigger than the other entities iterated upon thus far
			local hp = 0
			local damagemodel = EntityGetFirstComponentIncludingDisabled( v, "DamageModelComponent" ) 
			hp = ComponentGetValue2( damagemodel, "hp" ) 
			if (hp > biggest_hp) then
				target_id = v
				biggest_hp = hp
			end
		end
	end
end

--Focusing down player so he shouldn't be looking at other fellows
local limbbosscomp = EntityGetFirstComponentIncludingDisabled( root_id, "LimbBossComponent" )
if limbbosscomp ~= nil then
	local limbstate = ComponentGetValue2(limbbosscomp, "state")
	if limbstate == 5 then
		him = false
		dislike = false
	end
end

if stone_found == true then
	if ( stone_id ~= nil ) then
		local s = stone_id
		local sx,sy = EntityGetTransform( s )
		angle = get_direction( x, y, sx, sy )
	end
elseif him == true then
	if ( wizard_id ~= nil ) then
		local w = wizard_id
		local wx,wy = EntityGetTransform( w )
		angle = get_direction( x, y, wx, wy )
	end
elseif dislike == true then
	if ( target_id ~= nil ) then
		local t = target_id
		local tx,ty = EntityGetTransform( t )
		angle = get_direction( x, y, tx, ty )
	end
else
	local players = EntityGetWithTag( "player_unit" )
	if ( #players > 0 ) then
		local p = players[1]
		local px,py = EntityGetTransform( p )
		angle = get_direction( x, y, px, py )
	end
end

angle = math.pi + angle

EntitySetTransform( entity_id, x + math.cos( angle ) * 3, y - math.sin( angle ) * 3 )