
local input = 'input.txt'
local Root = {}

function DirNav(file)
	local pwd = '/'
	local dir = ""
	Root[pwd] = 0
	for line in io.lines(file) do
		if string.match(line, "^(%$.+cd)") then
			dir = string.match(line, "[%l+%p+]%.?$")
			if dir == ".." then
				local strrev = string.reverse(pwd)
				local pos = string.find(strrev, "/", 2) or 1
				local substr = string.sub(strrev, pos)
				pwd = string.reverse(substr)
			else
				if dir ~= "/" then
					pwd = pwd .. dir .. "/"
					Root[pwd] = 0
				end
			end
			-- print(pwd)
		elseif string.match(line, "^%d+") then
			local size = tonumber(string.match(line, "^%d+"))
			local filename = string.match(line, "%l?%p?%l+$")
			local path = pwd .. filename
			local sub = "/"
			Root[path] = size
			Root[sub] = Root[sub] + size
			for w in string.gmatch(pwd, "(%l+%p)") do
				sub = sub .. w
				Root[sub] = Root[sub] + size
			end
		else
		end
	end
end

DirNav(input)

local sum = 0
local freeSpace = 70000000 - Root["/"]
local available = {}
for key, value in pairs(Root) do
	if string.match(key, "/$") and value <= 100000 then
		sum = sum + value
	elseif (freeSpace + value) > 30000000 then
		table.insert(available, value)
	end
end
table.sort(available)
print("Part one:", sum)
print("Part two:", available[1])
