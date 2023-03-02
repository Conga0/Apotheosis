
local entity_id = GetUpdatedEntityID()
parent_id = EntityGetRootEntity(entity_id)

--Prevent tentacle shenganigans giving the player a homing component
if EntityHasTag(parent_id,"player_unit") ~= true then
    EntityAddComponent2(
        parent_id,
        "HomingComponent",
        {
            homing_targeting_coeff=150.0,
            homing_velocity_multiplier=0.90,
        }
    )
end