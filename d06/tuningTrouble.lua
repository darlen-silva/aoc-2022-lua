
local t = io.read("*a")

function match(str)
	for i = 1, #str - 1 do
		local w1 = string.byte(str, i, i)
		for j = i + 1, #str do
			local w2 = string.byte(str, j, j)
			if w1 == w2 then
				return false
			end
		end
	end
	return true
end

function FindPos(str, len)
	local pos = -1
	local lim = #str - len
	for i = 1, lim do
		local sub = string.sub(str, i, i+len-1)
		if match(sub) then
			pos = i + #sub - 1
			return pos
		end
	end
	return pos
end

print("Part one:", FindPos(t, 4))
print("Part two:", FindPos(t, 14))
