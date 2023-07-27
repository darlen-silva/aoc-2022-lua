
function ParseInput(input)
	local inspection = {}
	local monkey = 1
	for line in io.lines(input) do
		if string.match(line, "^Monkey") then
			inspection[monkey] = {}
			inspection[monkey]["inter"] = 0
			monkey = monkey + 1
		elseif string.match(line, "^%s+Starting") then
			inspection[monkey-1]["itens"] = {}
			for item in string.gmatch(line, "(%d+)") do
				table.insert(inspection[monkey-1]["itens"], tonumber(item))
			end
		elseif string.match(line, "^%s+Operation") then
			inspection[monkey-1]["oper"] = {}
			local sign = string.match(line, "([+*-/])")
			local value = string.match(line, "(%w+)$")
			inspection[monkey-1]["oper"]["sig"] = sign
			inspection[monkey-1]["oper"]["val"] = value
		elseif string.match(line, "^%s+Test") then
			local test = string.match(line, "(%d+)$")
			inspection[monkey-1]["test"] = tonumber(test)
		elseif string.match(line, "^%s+If") then
			if inspection[monkey-1]["if"] == nil then
				inspection[monkey-1]["if"] = {}
			end
			local res = string.match(line, "(%d+)$")
			if string.match(line, "(true)") then
				inspection[monkey-1]["if"]["true"] = res
			else
				inspection[monkey-1]["if"]["false"] = res
			end
		end
	end
	return inspection
end

function Actions(inp, monkey, worry)
	local result = function(num1, num2, sig)
		if sig == "*" then
			if worry == 1 then
				return (num1 * num2)
			end
			return math.floor((num1 * num2) / 3)
		elseif sig == "+" then
			if worry == 1 then
				return (num1 + num2)
			end
			return math.floor((num1 + num2) / 3)
		end
	end
	for index, v in pairs(inp[monkey]["itens"]) do
		local val = inp[monkey]["oper"]["val"]
		local sig = inp[monkey]["oper"]["sig"]
		if val == "old" then
			inp[monkey]["itens"][index] = result(v, v, sig)
		else
			inp[monkey]["itens"][index] = result(v, tonumber(val), sig)
		end
		inp[monkey]["inter"] = inp[monkey]["inter"] + 1
	end
end

function PrintItens(inp)
	local sum = 1
	for i = 1, #inp do
		io.write("Monkey: " .. i, " ")
		for _, value in ipairs(inp[i]["itens"]) do
			io.write(value, " ")
		end
		sum = sum * inp[i]["test"]
		print()
	end
	print(sum)
end

function Operations(oper, wor)
	local sum = 1
	for i = 1, #oper do
		sum = sum * oper[i]["test"]
	end
	for i = 1, #oper, 1 do
		Actions(oper, i, wor)
		while #oper[i]["itens"] >= 1 do
			local val = table.remove(oper[i]["itens"], 1)
			if (val % oper[i]["test"]) == 0 then
				local m = oper[i]["if"]["true"]
				if wor == 1 then
					table.insert(oper[m+1]["itens"], val%sum)
				else
					table.insert(oper[m+1]["itens"], val)
				end
			else
				local m = oper[i]["if"]["false"]
				if wor == 1 then
					table.insert(oper[m+1]["itens"], math.ceil(val%sum))
				else
					table.insert(oper[m+1]["itens"], val)
				end
			end
		end
	end
end

function InspectedItens(inp)
	local itens = {}
	for i = 1, #inp do
		table.insert(itens, inp[i]["inter"])
	end
	table.sort(itens)
	return itens[#itens] * itens[#itens-1]
end

function Rounds(inp, rd, wor)
	for _ = 1, rd, 1 do
		Operations(inp, wor)
	end
end

local inp = ParseInput("./input.txt")
local inp2 = ParseInput("./input.txt")
Rounds(inp, 20, 3)
Rounds(inp2, 10000, 1)
print("Part one:", InspectedItens(inp))
print("Part two:", InspectedItens(inp2))

