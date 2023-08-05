local mm_insert = {
    {
        material="apotheosis_magic_liquid_suffocatium",
        cost=400,
    },
    {
        material="apotheosis_magic_liquid_rideshare",
        cost=400,
    },
}

--[[
for k, v in ipairs(ms_insert) do
table.insert(materials_standard, v)
end
]]--

for k, v in ipairs(mm_insert) do
table.insert(potions, v)
end