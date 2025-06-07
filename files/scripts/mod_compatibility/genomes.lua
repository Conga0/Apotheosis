--Todo:
--Corrupt Wizard Genome (evil corrupt wizards vs normie non-corrupt wizards)
--Maybe give porings a unique genome so they aren't giga hated
--More infighting might be fun
--
--
--Conga: There's probably a more efficient way to run all of this.. will need to investigate after my modjam entry is complete
--

-- Big thank you to Horscht for this genome adding function :)
function split_string(inputstr, sep)
    sep = sep or "%s"
    local t= {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
    return t
  end
  
  function add_new_genome(content, genome_name, default_relation_ab, default_relation_ba, self_relation, relations)
    local lines = split_string(content, "\r\n")
    local output = ""
    local genome_order = {}
    local function get_relation(herd, index)
      if type(relations[herd]) == "number" then
        return relations[herd]
      elseif type(relations[herd]) == "table" then
        if type(index) ~= "number" then
          error("Wrong format", 3)
        end
        return relations[herd][index]
      end
    end
    for i, line in ipairs(lines) do
      if i == 1 then
        output = output .. line .. "," .. genome_name .. "\r\n"
      else
        local herd = line:match("([%w_-]+),")
        local relation = get_relation(herd, 2)
        output = output .. line .. ","..(relation or default_relation_ba).."\r\n"
        table.insert(genome_order, herd)
      end
    end
  
    local line = genome_name
    for i, v in ipairs(genome_order) do
      local relation = get_relation(v, 1)
      line = line .. "," .. (relation or default_relation_ab)
    end
  
    return output .. line .. "," .. self_relation
  end
  
  local content = ModTextFileGetContent("data/genome_relations.csv")
  content = add_new_genome(content, "mage_corrupted", 40, 60, 100, {
      player = -100,
      ["-1"] = 0,
      robot = { 50, 50 },
      fly = 100,
      boss_dragon = 0,
      crawler = 0,
      helpless = 0,
      eel = 0,
      fire = { 90, 100 },
      ghoul = { 90, 50 },
      giant = { 0, 50 },
      ice = 0,
      spider = { 0, 60 },
      rat = { 60, 0 },
      wolf = 0,
      worm = 0,
      nest = 100,
      mage = { 0, 0 },
      boss_limbs = 0,
      apparition = 50,
      bat = { 100, 90 },
      mage_swapper = { 100, 0 },
      curse = 100,
      trap = 100,
      ghost_boss = 100,
      healer = 100,
  })
  content = add_new_genome(content, "ghost_whisp", 90, 90, 100, {
      player = 0,
      ["-1"] = 0,
      nest = 100,
      boss_limbs = 0,
      healer = 100,
      apparition = 50,
      bat = { 100, 90 },
      mage_swapper = { 90, 0 },
      curse = 100,
      trap = 100,
      ghost_boss = 100,
      ghost_fairy = { 0, 0 },
  })
  content = add_new_genome(content, "ghost_fairy", 90, 90, 100, {
      player = 0,
      ["-1"] = 0,
      nest = 100,
      boss_limbs = 0,
      healer = 100,
      apparition = 50,
      bat = { 100, 90 },
      mage_swapper = { 90, 0 },
      curse = 100,
      trap = 100,
      ghost_boss = 100,
      ghost_whisp = { 0, 0 },
      orcs = { 90, 70 },
  })
  content = add_new_genome(content, "mimic", 100, 100, 100, {
      player = { 0, 100 },
      ["-1"] = 0,
      nest = { 0, 100 },
      boss_limbs = 100,
      healer = { 0, 100 },
      apparition = { 0, 100 },
      bat = { 0, 100 },
      mage = 0,
      mage_swapper = 0,
      curse = 100,
      trap = 100,
      ghost_boss = 100,
      mage_corrupted = 0,
      ghost_fairy = 100,
      ghost_whisp = 100,
      orcs = { 0, 100 },
  })
  
  ModTextFileSetContent("data/genome_relations.csv", content)