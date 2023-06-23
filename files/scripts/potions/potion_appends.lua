local mm_insert = {
    {
        material="apotheosis_mudman_mud",
        cost=1600,
    },
    {
        material="apotheosis_magic_liquid_infinite_flight",
        cost=800,
    },
    {
        material="apotheosis_magic_liquid_attunium",
        cost=800,
    },
    {
        material="apotheosis_magic_liquid_velocium",
        cost=800,
    },
	{
		material="apotheosis_magic_liquid_rideshare",
		cost=800, --Hey, I'll be real with you, cost changes literally nothing, even in the normal potion.lua file, I'm just keeping it here incase a mod far off in the future decides to change that
	},
}

--[[
for k, v in ipairs(ms_insert) do
table.insert(materials_standard, v)
end
]]--

for k=1,#mm_insert
do v = mm_insert[k]
    table.insert(materials_magic, v)
end