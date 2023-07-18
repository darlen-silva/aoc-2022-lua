
function ParseInput(input)
	local cmd = {}
	for line in io.lines(input) do
		local dir = string.sub(line, 1, 1)
		local mov = string.sub(line, 2, -1)
		table.insert(cmd, {d = dir, m = tonumber(mov)})
	end
	return cmd
end

function Rule(board, head, tail)
	local insert = function (b, k)
		if b[k] then
			b[k] = b[k] + 1
		else
			b[k] = 1
		end
	end
	if (tail.x == head.x) and (tail.y + 2 == head.y) then
		tail.y = tail.y + 1
	elseif (tail.x == head.x) and (tail.y - 2 == head.y) then
		tail.y = tail.y - 1
	elseif (tail.y == head.y) and (tail.x + 2 == head.x) then
		tail.x = tail.x + 1
	elseif (tail.y == head.y) and (tail.x - 2 == head.x) then
		tail.x = tail.x - 1
	elseif ((tail.x - 1 == head.x) and (tail.y - 2 == head.y))
		or ((tail.x - 2 == head.x) and (tail.y - 1 == head.y))
		or ((tail.x - 2 == head.x) and (tail.y - 2 == head.y)) then
		tail.x = tail.x - 1
		tail.y = tail.y - 1
	elseif ((tail.x - 1 == head.x) and (tail.y + 2 == head.y))
		or ((tail.x - 2 == head.x) and (tail.y + 1 == head.y))
		or ((tail.x - 2 == head.x) and (tail.y + 2 == head.y)) then
		tail.x = tail.x - 1
		tail.y = tail.y + 1
	elseif ((tail.x + 1 == head.x) and (tail.y - 2 == head.y))
		or ((tail.x + 2 == head.x) and (tail.y - 1 == head.y))
		or ((tail.x + 2 == head.x) and (tail.y - 2 == head.y)) then
		tail.x = tail.x + 1
		tail.y = tail.y - 1
	elseif ((tail.x + 1 == head.x) and (tail.y + 2 == head.y))
		or ((tail.x + 2 == head.x) and (tail.y + 1 == head.y))
		or ((tail.x + 2 == head.x) and (tail.y + 2 == head.y)) then
		tail.x = tail.x + 1
		tail.y = tail.y + 1
	end
	local key = tail.x .. "," .. tail.y
	insert(board, key)
end

function BoardMotions(board, tab, arr)
	if tab.d == "R" then
		for _ = 1, tab.m do
			arr[1].y = arr[1].y + 1
			for j = 1, #arr-1 do
				if board[j] == nil then
					board[j] = {}
				end
				Rule(board[j], arr[j], arr[j+1])
			end
		end
	elseif tab.d == "L" then
		for _ = 1, tab.m do
			arr[1].y = arr[1].y - 1
			for j = 1, #arr-1 do
				if board[j] == nil then
					board[j] = {}
				end
				Rule(board[j], arr[j], arr[j+1])
			end
		end
	elseif tab.d == "U" then
		for _ = 1, tab.m do
			arr[1].x = arr[1].x - 1
			for j = 1, #arr-1 do
				if board[j] == nil then
					board[j] = {}
				end
				Rule(board[j], arr[j], arr[j+1])
			end
		end
	elseif tab.d == "D" then
		for _ = 1, tab.m do
			arr[1].x = arr[1].x + 1
			for j = 1, #arr-1 do
				if board[j] == nil then
					board[j] = {}
				end
				Rule(board[j], arr[j], arr[j+1])
			end
		end
	end
end

local start = {
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
	{x = 1, y = 1},
}

local motions = ParseInput("./input.txt")
local board = {}
for i = 1, #motions do
	BoardMotions(board, motions[i], start)
end

function Result(bd)
	local sum = 0
	for _, _ in pairs(bd) do
		sum = sum + 1
	end
	return sum
end

print("Part one:", Result(board[1]))
print("Part two:", Result(board[9]))
