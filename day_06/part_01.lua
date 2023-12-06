local file = io.open("real_input", "r")
local unpack = table.unpack

function findOptimalHoldTime(max_time, record)
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
	local starting = os.clock()
	local lines = {}

	for line in content:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	-- Correcting the pattern to capture four groups of numbers
	local times = {}
	for a, b, c, d in lines[1]:gmatch("Time:%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)") do
		times = { tonumber(a), tonumber(b), tonumber(c), tonumber(d) }
	end

	local distances = {}
	for a, b, c, d in lines[2]:gmatch("Distance:%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)") do
		distances = { tonumber(a), tonumber(b), tonumber(c), tonumber(d) }
	end

	print(times[1], times[2], times[3], times[4])
	print(distances[1], distances[2], distances[3], distances[4])

	local output = 1

	for i = 1, 4 do
		local wins = findOptimalHoldTime(times[i], distances[i])

		output = wins * output
	end

	local end_time = os.clock() - starting
	print("Output is : " .. output .. " | Time taken: " .. end_time .. " seconds")
	file:close()
end
