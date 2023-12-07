
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

do -- Player Editor
	local path = "data/entities/player_base.xml"
	local xml = nxml.parse(ModTextFileGetContent(path))

	--Makes player take contact damage from cursed liquid, poisonous gas, and other materials added by Apotheosis
	--Cursed Liquid, Cursed Liquid (Static), Poisonous Gas, Radioactive Gas (Fading)
	local attrs = xml:first_of("DamageModelComponent"):first_of("damage_multipliers").attr
	attrs.explosion = 0.66
	attrs.projectile = 2.0
	attrs.fire = 2.0
	attrs.melee = 2.0
	attrs.material = 2.0
	attrs.electricity = 2.0
	attrs.slice = 2.0
	attrs.healing = 2.0
	attrs.poison = 2.0
	attrs.radioactive = 2.0
	attrs.drill = 2.0
	attrs.ice = 2.0
	attrs.drowning = 2.0
	attrs.material_with_flash = 2.0

	ModTextFileSetContent(path, tostring(xml))
end
