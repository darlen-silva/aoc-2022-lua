
local Trees = {}

for line in io.lines("./input.txt") do
	local numbers = {}
	for w in string.gmatch(line, "(%d)") do
		table.insert(numbers, tonumber(w))
	end
	table.insert(Trees, numbers)
end

function CheckCols(t, col)
	for i = col + 1, #t do
		if t[col] <= t[i] then
			break
		end
		if i == #t then
			return true
		end
	end
	for i = col - 1, 1, -1 do
		if t[col] <= t[i] then
			break
		end
		if i == 1 then
			return true
		end
	end
	return false
end

function CheckRows(t, row, col)
	for i = row + 1, #t do
		if t[row][col] <= t[i][col] then
			break
		end
		if i == #t then
			return true
		end
	end
	for i = row - 1, 1, -1 do
		if t[row][col] <= t[i][col] then
			break
		end
		if i == 1 then
			return true
		end
	end
	return false
end

function Check(t, row, col)
	if row == 1 or row == #t or col == 1 or col == #t[row] then
		return true
	elseif CheckCols(t[row], col) then
		return true
	elseif CheckRows(t, row, col) then
		return true
	else
		return false
	end
end

local view = 0
function CheckView(t, row, col)
	if row == 1 or row == #t or col == 1 or col == #t[row] then
		return
	end
	local score = {}
	for i = col + 1, #t[row] do
		if t[row][col] <= t[row][i] or i == #t[row] then
			table.insert(score, (i-col))
			break
		end
	end
	for i = col - 1, 1, -1 do
		if t[row][col] <= t[row][i] or i == 1 then
			table.insert(score, (col-i))
			break
		end
	end
	for i = row + 1, #t do
		if t[row][col] <= t[i][col] or i == #t then
			table.insert(score, (i-row))
			break
		end
	end
	for i = row - 1, 1, -1 do
		if t[row][col] <= t[i][col] or  i == 1 then
			table.insert(score, (row-i))
			break
		end
	end
	local sum = 1
	for _, value in pairs(score) do
		sum = sum * value
	end
	if sum > view then
		view = sum
	end
end

function SeeTrees(trees)
	local sum = 0
	for i = 1, #trees do
		for j = 1, #trees[i] do
			if Check(trees, i, j) then
				sum = sum + 1
			end
			CheckView(trees, i, j)
		end
	end
	return sum, view
end

local treeSee, scoreView = SeeTrees(Trees)

print("Part one:", treeSee)
print("Part two:", scoreView)
