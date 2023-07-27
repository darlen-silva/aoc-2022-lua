
function ParseInput(input)
	local instructions = {}
	for line in io.lines(input) do
		local intr = string.match(line, "(%l+)")
		local val = string.match(line, "(-?%d+)$") or 0
		table.insert(instructions, {ins = intr, val = tonumber(val)})
	end
	return instructions
end

function CreateBoard(rows, cols)
	local board = {}
	for i = 1, rows do
		board[i] = {}
		for j = 1, cols do
			board[i][j] = "."
		end
	end
	return board
end

function PrintBoard(board)
	for i = 1, #board do
		for j = 1, #board[i] do
			io.write(board[i][j])
		end
		print()
	end
	return board
end

function ProgramInstructions(inst)
	local x = 1
	local cycle = 0
	local reg = {}
	for i = 1, #inst do
		if inst[i].ins == "addx" then
			reg[cycle+1] = x
			reg[cycle+2] = x
			x = x + inst[i].val
			cycle = cycle + 2
		else
			reg[cycle+1] = x
			cycle = cycle + 1
		end
	end
	return reg
end

function DrawPixels(inst, board)
	local x = 1
	local row = 1
	local col = 0
	for i = 1, #inst do
		if inst[i].ins == "addx" then
			local cnt = 0
			while cnt < 2 do
				if col >= 40 then
					row = row + 1
					col = 0
				end
				if col >= x-1 and col <= x+1 then
					board[row][col+1] = "#"
				end
				col = col + 1
				cnt = cnt + 1
			end
			x = x + inst[i].val
		elseif inst[i].ins == "noop" then
			if col >= 40 then
				row = row + 1
				col = 0
			end
			if col >= x-1 and col <= x+1 then
				board[row][col+1] = "#"
			end
			col = col + 1
		end
	end
end

function SignalStrength(inp)
	local sum = 0
	for i = 20, #inp, 40 do
		sum = sum + (i * inp[i])
	end
	return sum
end

local prog = ParseInput("./input.txt")
local res = ProgramInstructions(prog)
local board = CreateBoard(6, 40)
DrawPixels(prog, board)

print("Part one:", SignalStrength(res))
print("Part two:")
PrintBoard(board)
