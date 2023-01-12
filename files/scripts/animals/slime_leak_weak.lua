dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local pos_x, pos_y = EntityGetTransform( entity_id )
local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 64, "mortal") --This should probably check for genome differences instead, to allow infighting, and stop if you stack more love
local attack = false

for k=1, #targets
do local v = targets[k];
	if EntityGetHerdRelation( entity_id, v) <= 55 then
		attack = true
	end
end

if attack == true then
	EntitySetComponentsWithTagEnabled(entity_id, "enabled_by_liquid", true)
else
	EntitySetComponentsWithTagEnabled(entity_id, "enabled_by_liquid", false)
end

--I AM A CODING WIZARD!!
--AARRGGHHHH HAHAHAHAHAH!!! MWYHAHAHAHAHAH AAAAAAAAAAAAAAAAAAAAAAA!!!! HELL YEAHHHH WOO YEAH WIZARDING WOO WIZARD FUMBLEMORE ISRAPHEL