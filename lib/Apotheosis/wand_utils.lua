

function SetVariables(entity_id, compname, table)
  local comp = EntityGetComponentIncludingDisabled(entity_id, compname)
  for k=1,#table
  do v = table[k]
    ComponentSetValue2(compname,table)
  end
end