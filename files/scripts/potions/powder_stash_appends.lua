local standard_insert = {
    {
        material="apotheosis_redstone",
        cost=800,
    },
    {
        material="apotheosis_milk_powder",
        cost=800,
    },
}

local magic_insert = {
    {
        material="apotheosis_redstone",
        cost=800,
    },
}


for k=1,#standard_insert
do v = standard_insert[k]
    table.insert(materials_standard, v)
end

for k=1,#magic_insert
do v = magic_insert[k]
    table.insert(materials_magic, v)
end