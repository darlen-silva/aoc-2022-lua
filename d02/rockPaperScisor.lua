
local M = {}
local ForceA = {A = 1, B = 2, C = 3}
local ForceB = {X = 1, Y = 2, Z = 3}
local Match = {
	X = {A = 0, B = -1, C = 1},
	Y = {A = 1, B = 0, C = -1},
	Z = {A = -1, B = 1, C = 0},
}
for line in io.lines("./input.txt") do
	local opMovie = string.sub(line, 1, 1)
	local myMovie = string.sub(line, 3, 3)
	table.insert(M, {op = opMovie, me = myMovie})
end

local myRes = 0
for i = 1, #M do
	local m = Match[M[i].me][M[i].op]
	if m > 0 then
		myRes = myRes + ForceB[M[i].me] + 6
	elseif m == 0 then
		myRes = myRes + ForceB[M[i].me] + 3
	else
		myRes = myRes + ForceB[M[i].me]
	end
end
print("Part one:",myRes)

local M2 = {
	-- X loses
	X = {A = "C", B = "A", C = "B"},
	-- Y draw
	Y = {A = "A", B = "B", C = "C"},
	-- Z Wins
	Z = {A = "B", B = "C", C = "A"},
}
local Match2 = {
	A = {A = 0, B = -1, C = 1},
	B = {A = 1, B = 0, C = -1},
	C = {A = -1, B = 1, C = 0},
}
local myRes2 = 0
for i = 1, #M do
	local n = M2[M[i].me][M[i].op]
	local op = M[i].op
	local m = Match2[n][op]
	if m > 0 then
		myRes2 = myRes2 + ForceA[n] + 6
	elseif m == 0 then
		myRes2 = myRes2 + ForceA[n] + 3
	else
		myRes2 = myRes2 + ForceA[n]
	end
end
print("Part two:", myRes2)
