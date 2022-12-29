dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local radius = 125

local eyes = EntityGetInRadiusWithTag( x, y, radius, "musical_stone" )
local found = false

local musicinitiated = tonumber( GlobalsGetValue( "apotheosis_king_secret_music", "0" ) )
if musicinitiated == 1 then musicinitiated = true end


local comp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
local symbolName = ComponentGetValue2( comp, "value_string" )
local symbolinitiated = ComponentGetValue2( comp, "value_bool" )
--GamePrint(tostring(symbolinitiated))



if ( #eyes > 0 ) then
	for i,v in ipairs( eyes ) do
		local t = EntityGetFirstComponent( v, "LightComponent", "magic_eye_check" )
		
		if ( t ~= nil ) then
			found = true
			break
		end
	end
end


if found then
    EntitySetComponentsWithTagEnabled( entity_id, "magic_eye", true )
    if symbolinitiated == false then
		EntityLoad( "mods/Apotheosis/files/entities/items/books/book_symbol_" .. symbolName .. ".xml", x, y )
        EntityLoad("mods/Apotheosis/files/entities/particles/poof_green_dense.xml", x, y )
        ComponentSetValue2( comp, "value_bool", true )
    end
    if musicinitiated ~= true then
        GlobalsSetValue( "apotheosis_king_secret_music", "1" )
        GameTriggerMusicFadeOutAndDequeueAll( 5.0 )
        GameTriggerMusicEvent( "music/oneshot/tripping_balls_01", false, x, y )
    end    
else
    EntitySetComponentsWithTagEnabled( entity_id, "magic_eye", false )
end

