local file = io.open("real_input", "r")

function extract_numbers(number_string, opt_table)
	local numbers = opt_table or {}
	for number in number_string:gmatch("%d+") do
		table.insert(numbers, tonumber(number))
	end
	return numbers
end

function map(number, mappingTable)
	for _, line in ipairs(mappingTable) do
		local destStart, srcStart, rangeLength = unpack(line)

		if number >= srcStart and number < srcStart + rangeLength then
			return destStart + (number - srcStart)
		end
	end
	return number
end

if file then
	local sum = 0
	local content = file:read("*a")
	local starting = os.clock()
	local lines = {}
	local seeds = {}

	local seeds_to_soil = {}
	local soil_to_fertilizer = {}
	local fertilizer_to_water = {}
	local water_to_light = {}
	local light_to_temperature = {}
	local temperature_to_humidity = {}
	local humidity_to_location = {}

	for line in content:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	for i = 1, #lines do
		if lines[i]:match("^seeds:") then
			for seed in lines[i]:gmatch("%d+") do
				table.insert(seeds, tonumber(seed))
			end
		elseif lines[i]:match("^seed%-to%-soil map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(seeds_to_soil, values)
				end
				i = i + 1
			end
		elseif lines[i]:match("^soil%-to%-fertilizer map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(soil_to_fertilizer, values)
				end
				i = i + 1
			end
		elseif lines[i]:match("^fertilizer%-to%-water map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(fertilizer_to_water, values)
				end
				i = i + 1
			end
		elseif lines[i]:match("^water%-to%-light map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(water_to_light, values)
				end
				i = i + 1
			end
		elseif lines[i]:match("^light%-to%-temperature map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(light_to_temperature, values)
				end
				i = i + 1
			end
		elseif lines[i]:match("^temperature%-to%-humidity map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(temperature_to_humidity, values)
				end
				i = i + 1
			end
		elseif lines[i]:match("^humidity%-to%-location map:") then
			i = i + 1
			while lines[i] and lines[i]:match("%d+%s+%d+%s+%d+") do
				local values = {}
				for value in lines[i]:gmatch("%d+") do
					table.insert(values, tonumber(value))
				end
				if #values == 3 then
					table.insert(humidity_to_location, values)
				end
				i = i + 1
			end
		end
	end

	local lowestLocation = math.huge
	for i = 1, #seeds do
		local seed = seeds[i]

		local soil = map(seed, seeds_to_soil)
		local fertilizer = map(soil, soil_to_fertilizer)
		local water = map(fertilizer, fertilizer_to_water)
		local light = map(water, water_to_light)
		local temperature = map(light, light_to_temperature)
		local humidity = map(temperature, temperature_to_humidity)
		local location = map(humidity, humidity_to_location)

		if location < lowestLocation then
			lowestLocation = location
		end
	end

	sum = lowestLocation

	local end_time = os.clock() - starting
	print("Output is : " .. sum .. " | Time taken: " .. end_time .. " seconds")

	file:close()
end
