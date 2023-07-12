
local T = {}
for line in io.lines("./input.txt") do
	local match = {}
	for v1, v2 in string.gmatch(line, "(%d+)-(%d+)") do
		table.insert(match, {r1 = tonumber(v1), r2 = tonumber(v2)})
	end
	table.insert(T, match)
end

local sum = 0
for i = 1, #T do
	if (T[i][1].r1 >= T[i][2].r1) and (T[i][1].r2 <= T[i][2].r2) then
		sum = sum + 1
	elseif (T[i][1].r2 >= T[i][2].r2) and (T[i][1].r1 <= T[i][2].r1) then
		sum = sum + 1
	end
end
print("Part one:", sum)

local sum2 = 0
for i = 1, #T do
	local n1 = T[i][1].r1
	local n2 = T[i][1].r2
	local n3 = T[i][2].r1
	local n4 = T[i][2].r2

	if (n1 >= n3) and (n1 <= n4) then
		sum2 = sum2 + 1
	elseif (n3 >= n1) and (n3 <= n2) then
		sum2 = sum2 + 1
	end
end
print("Part two:", sum2)
