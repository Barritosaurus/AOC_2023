local file = io.open("real_input", "r")
local unpack = table.unpack

function find_wins(max_time, record)
	local possible_wins = 0

	for holdTime = 0, max_time do
		local distance = holdTime * (max_time - holdTime)

		if distance > record then
			possible_wins = possible_wins + 1
		end
	end

	return possible_wins
end

if file then
	local content = file:read("*a")
	local lines = {}

	for line in content:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	-- Correcting the pattern to capture four groups of numbers
	local times = {}
	local a, b, c, d = lines[1]:match("Time:%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
	local time = a .. b .. c .. d
	times = { tonumber(time) }

	local distances = {}
	local a, b, c, d = lines[2]:match("Distance:%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
	local dist = a .. b .. c .. d
	distances = { tonumber(dist) }

	local output = 1
	local wins = find_wins(times[1], distances[1])
	output = wins * output

	print("Output is : " .. output)
	file:close()
end
