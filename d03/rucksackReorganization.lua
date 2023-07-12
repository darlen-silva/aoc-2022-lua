
local T = {}
local G = {}

for line in io.lines("./input.txt") do
	local len = string.len(line)
	local s1 = string.sub(line, 1, len/2)
	local s2 = string.sub(line, (len/2)+1, -1)
	local m = string.match(s1, "[" .. s2 .. "]")
	table.insert(T, m)
	table.insert(G, line)
	-- print(line)
end

local T2 = {}

for i = 1, #G, 3 do
	local s = ""
	for w in string.gmatch(G[i], "[" .. G[i+1] .. "]") do
		s = s .. w
	end
	local m = string.match(G[i+2], "[" .. s .. "]")
	table.insert(T2, m)
end

local sum = function (table)
	local sum = 0
	for v = 1, #table do
		local b = string.byte(table[v])
		if (b >= 65 and b <= 90) then
			sum = sum + (b - 64) + 26
		else
			sum = sum + (b - 96)
		end
	end
	return sum
end
print("Part one:", sum(T))
print("Part two:", sum(T2))

