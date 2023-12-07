
--The forsaken file

--Fixes guiding powder
--`orb_list` has a list of coordinates relative to 0,0 where the orb rooms are located on the biome map
--51,14 is the center of the world

orb_list =
{
	{8,1},			--Pitboss Orb
	{1,-3},			--Mountain Altar Orb
	{-9,7},			--Magical Temple Orb
	{-8,19},		--Lukki Lair Orb
	{-18,2},		--Snow Chasm Orb
	{-20,5},		--Frozen Vault Orb
	{-1,31},		--Hell Orb
	{20,31},		--Wizard's Den Orb
	{19,5},			--Sandcave's Orb
	{6,3},			--Nuke Orb
	{19,-3},		--Pyramid's Top Orb
    --Apotheosis orbs below
    {41,14},    	--Temple of Sacrilegous Remains [12]
    {-42,18},   	--Sunken Cavern                 [13]
    {36,32},    	--Virulent Caverns              [14]
    {-41,2}    	--Forest Chasm                  [15]
}

--Orb Map for down under
--[[
if GameHasFlagRun("apotheosis_everything") or GameHasFlagRun("apotheosis_downunder") then
	orb_list =
	{
		{-9,24},	--Pitboss Orb
		{1,-3},		--Mountain Altar Orb
		{-9,17},	--Magical Temple Orb
		{-7,6},		--Lukki Lair Orb
		{-18,28},	--Snow Chasm Orb
		{-20,25},	--Frozen Vault Orb
		{-1,-13},	--Hell Orb
		{25,2},		--Wizard's Den Orb
		{19,30},	--Sandcave's Orb
		{-9,26},	--Nuke Orb
		{19,22},	--Pyramid's Top Orb
		--Apotheosis orbs below
		{41,14},    --Temple of Sacrilegous Remains [12]
		{-42,18},   --Sunken Cavern                 [13]
		{36,32},    --Virulent Caverns              [14]
		{-41,2},    --Forest Chasm                  [15]
	}
end
]]--
