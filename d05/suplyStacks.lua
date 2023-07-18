
local stacks = {}
local Stk = {}

for line in io.lines("./input.txt") do
	if string.match(line, "(%d+)") then break end
	local len = math.ceil(#line/4)
	if #stacks < len then
		for i = 1, len do
			stacks[i] = {}
			Stk[i] = {}
		end
	end
	local index = 1
	for i = 1, #line, 4 do
		local sub = string.sub(line, i, i+3)
		local w = string.match(sub, "(%w)")
		if w then
			table.insert(stacks[index], 1, w)
			table.insert(Stk[index], 1, w)
		end
		index = index + 1
	end
end

for line in io.lines("./input.txt") do
	local m = {}
	if string.match(line, "^move") then
		for w in string.gmatch(line, "(%d+)") do
			table.insert(m, w)
		end
		local move = tonumber(m[1])
		local from = tonumber(m[2])
		local to = tonumber(m[3])
		while move >= 1 do
			local tmp = table.remove(stacks[from])
			local pos = #Stk[from] - move + 1
			local tmp2 = table.remove(Stk[from], pos)
			table.insert(stacks[to], tmp)
			table.insert(Stk[to], tmp2)
			move = move - 1
		end
	end
end

local s = ""
local s2 = ""
for i = 1, #stacks do
	s = s .. stacks[i][#stacks[i]]
	s2 = s2 .. Stk[i][#Stk[i]]
end
print("Part one:", s)
print("Part two:", s2)
