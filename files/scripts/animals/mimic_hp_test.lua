local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local attack = "rubber_ball" --Default attack if no others can be found, also declared here for scope purposes
local currbiome = BiomeMapGetName( x, y )

local biomelist = {
    {
        biome = "$biome_coalmine",
        proj = "mine",
    },
    {
        biome = "$biome_snowcave",
        proj = "iceball",
    },
}

for k=1,#biomelist
do local v = biomelist[k]
    if v.biome == currbiome then
        attack = v.proj
    end
end

local comps = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
if( comps ~= nil ) then
    for k=1,#comps
    do local v = comps[k]
        if ComponentGetValue2(v, "name") == "mimic_proj_file" then
            ComponentSetValue( v, "value_string", "data/entities/projectiles/deck/" .. attack .. ".xml" )
        end
    end
end