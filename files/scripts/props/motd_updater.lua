dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local year, month, day, hour = GameGetDateAndTimeLocal()

local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "InteractableComponent" )

--Sets MOTD message depending on date & time, automatically updates between days
if month == 1 and day == 1 then                                                    
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_new_year" )        --New Year
elseif ( month == 7 ) and (( day >= 20 ) and ( day <= 22 )) then                      
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_birthday" )        --Birthday
elseif ( month == 10 ) and ( day >= 15 ) and (hour % 2 == 0) then                       
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_halloween" )       --Halloween
elseif ( month == 12 ) and ( day >= 15 ) and (hour % 2 == 0) then                  
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_smissmass" )       --Smissmass
elseif ( day == 1 )  then                                                         
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_001" )             --Normal Events
elseif ( day == 2 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_002" )
elseif ( day == 3 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_003" )
elseif ( day == 4 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_004" )
elseif ( day == 5 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_005" )
elseif ( day == 6 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_006" )
elseif ( day == 7 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_007" )
elseif ( day == 8 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_008" )
elseif ( day == 9 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_009" )
elseif ( day == 10 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_010" )
elseif ( day == 11 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_011" )
elseif ( day == 12 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_012" )
elseif ( day == 13 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_013" )
elseif ( day == 14 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_014" )
elseif ( day == 15 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_015" )
elseif ( day == 16 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_016" )
elseif ( day == 17 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_017" )
elseif ( day == 18 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_018" )
elseif ( day == 19 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_019" )
elseif ( day == 20 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_020" )
elseif ( day == 21 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_021" )
elseif ( day == 22 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_022" )
elseif ( day == 23 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_023" )
elseif ( day == 24 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_024" )
elseif ( day == 25 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_025" )
elseif ( day == 26 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_026" )
elseif ( day == 27 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_027" )
elseif ( day == 28 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_028" )
elseif ( day == 29 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_029" )
elseif ( day == 30 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_030" )
elseif ( day == 31 )  then
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description_031" )
else
    ComponentSetValue2( comp, "ui_text", "$book_apotheosis_motd_description" )                --This should never appear under any circumstances.. Unless you did something really, *really* bad
end