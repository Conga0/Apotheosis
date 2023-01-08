dofile_once("data/scripts/lib/utilities.lua")

local targets = EntityGetWithTag( "player_unit" )

for i,v in ipairs( targets ) do
    local comp = GameGetGameEffect( v, "PROTECTION_POLYMORPH" )
    GamePrint("DEBUG 1")
    if comp ~= 0 then
        local duration = ComponentGetValue2( comp, "frames")
        GamePrint(tostring(duration))
        GamePrint("DEBUG 2")
        if duration >= 1600 then
            GamePrint("Mina has over 300 seconds of poly protection Mate")
        end
    end
end
