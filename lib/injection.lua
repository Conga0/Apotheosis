---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

-- Nathan injection functions

local ENABLE_LOGGING = false -- change this thing if you want to spam the console

local function getfile(file)
	content = ModTextFileGetContent(file)
	content = content:gsub("\r+\n", "\n")
	ModTextFileSetContent(file, content)
	return content
end

local function log(log_table)
	print(table.concat(log_table))
end

local function append(file, target, text)
	local content = getfile(file)
	local first, last = content:find(target, 0, true)
	if not first then
		log({ "INJECTION (APPEND) FAILED: NO HOOK\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
		return
	end
	local before = content:sub(1, last)
	local after = content:sub(last + 1)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if ENABLE_LOGGING then
		log({ "Injected (append) ", text, " in ", file, " at ", target, " causing:\n", new, "\nfrom: \n", content })
	end
	if content == new then
		log({ "INJECTION (APPEND) FAILED: NO CHANGE\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
	end
end

local function prepend(file, target, text)
	local content = getfile(file)
	local first, last = content:find(target, 0, true)
	if not first then
		log({ "INJECTION (PREPEND) FAILED: NO HOOK\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
		return
	end
	local before = content:sub(1, first - 1)
	local after = content:sub(first)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if ENABLE_LOGGING then
		log({ "Injected (prepend) ", text, " in ", file, " at ", target, " causing:\n", new, "\nfrom: \n", content })
	end
	if content == new then
		log({ "INJECTION (PREPEND) FAILED: NO CHANGE\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
	end
end

local function replace(file, target, text)
	local content = getfile(file)
	local first, last = content:find(target, 0, true)
	if not first then
		log({ "INJECTION (REPLACE) FAILED: NO HOOK\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
		return
	end
	local before = content:sub(1, first - 1)
	local after = content:sub(last + 1)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if ENABLE_LOGGING then
		log({ "Injected (replace) ", text, " in ", file, " at ", target, " causing:\n", new, "\nfrom: \n", content })
	end
	if content == new then
		log({ "INJECTION (REPLACE) FAILED: NO CHANGE\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
	end
end

--- @enum arg
args = {
	FF           = 0,
	FS           = 1,
	SF           = 2,
	SS           = 3,
	FileFile     = 0,
	FileString   = 1,
	StringFile   = 2,
	StringString = 3,
}

--- @enum mode
modes = {
	P       = 0,
	R       = 1,
	A       = 2,
	PREPEND = 0,
	REPLACE = 1,
	APPEND  = 2,
}

--- @param args arg (use enum) What type are hook & new, (f)ile or (s)tring, write like (ff) or (sf). hook -> new.
--- @param mode mode (use enum) What injection mode, (p)repend, (r)eplace, (a)ppend.
--- @param file string The file to inject into.
--- @param hook string The files name or if using a string the string to match, this is the point where the injection hooks into.
--- @param new string The file with the new content to be added or the string of new content to be added.
function inject(args, mode, file, hook, new)
	local arg1T = args < 2 -- true is file
	local arg2T = args % 2 == 0
	if arg1T then
		hook = getfile(hook)
	end
	if arg2T then
		new = getfile(new)
	end
	if mode == modes.P then
		prepend(file,hook,new)
		return
	end
	if mode == modes.R then
		replace(file,hook,new)
		return
	end
	if mode == modes.A then
		append(file,hook,new)
		return
	end
end
