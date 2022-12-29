dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()
local enemy_list = EntityGetWithTag( "mortal" )

for id,enemy in pairs(enemy_list) do
    if EntityHasTag(enemy, "acid") ~= true then

        local iter_count = tonumber( GlobalsGetValue( "apotheosis_creature_shift_iteration", "0" ) )

        if iter_count >= 1 then
            repeat 
                
                local targ_count = tostring(iter_count)

                local target1 = (GlobalsGetValue("apotheosis_global_Cshift_" .. targ_count .. "_targ1", "failed") )
                local target2 = (GlobalsGetValue("apotheosis_global_Cshift_" .. targ_count .. "_targ2", "failed") )
                if (EntityGetFilename(enemy) == "data/entities/animals/" .. target2 .. ".xml") then

                    local health = 0
                    local max_health = 0

                    local pos_x,pos_y = EntityGetTransform(enemy)
                    local shiftto = EntityLoad("data/entities/animals/" .. target1 .. ".xml", pos_x, pos_y)
                    --GamePrint(tostring(target1))

                    local comp = EntityGetFirstComponent(enemy, "DamageModelComponent" )
                    if comp ~= nil then
                        max_health = ComponentGetValue2(comp, "max_hp")
                        health = ComponentGetValue2(comp, "hp")
                    end
        
                    local comp = EntityGetFirstComponent(shiftto, "DamageModelComponent" )
                    if comp ~= nil then
                        ComponentSetValue2(comp, "max_hp", max_health)
                        ComponentSetValue2(comp, "hp", health)
                    end
                    
                    EntityKill(enemy)
        
                end


                iter_count = iter_count - 1
            
            until (iter_count == 0)
        end
    end
end


--TODO: Add smoke fx