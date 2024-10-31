
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent( entity_id )
local x,y = EntityGetTransform( GetUpdatedEntityID() )
local r = 350

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" ) or {}

local animalai = EntityGetFirstComponentIncludingDisabled(parent_id, "AnimalAIComponent")
local aggression = ComponentGetValue2(animalai, "mAggression")

for k=1, #targets
do local v = targets[k]
	local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
	if v ~= parent_id and genome ~= nil and (EntityGetHerdRelation(parent_id, v) < aggression) then
		local t_x, t_y = EntityGetTransform(v)
		local did_hit = RaytraceSurfaces(x, y, t_x, t_y)
		if not did_hit then
			local tx,ty = EntityGetTransform( v )
			local dir = math.atan2( ty - y, tx - x )
			EntitySetTransform( entity_id, x, y, dir )
			break
		end
	end
end