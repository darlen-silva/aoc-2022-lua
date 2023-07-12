
-- local count = 0

function ReadInput(input)
	local sum = 0
	local total = {}
	for lines in io.lines(input) do
		if lines ~= '' then
			sum = sum + tonumber(lines)
		else
			table.insert(total, sum)
			sum = 0
		end
	end
	table.insert(total,sum)
	table.sort(total)
	return total
end

local total = ReadInput("./input.txt");
local sum = 0;
for i = 0, 2 do
	sum = sum + total[#total - i]
	-- print(total[#total - i])
end
print("Part one:", total[#total])
print("Part two:", sum)

