local file = io.open("real_input", "r")
local unpack = table.unpack

if file then
	local output = 0
	local content = file:read("*a")
	local starting = os.clock()
	local lines = {}
	local ranges = {}

	for line in content:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	local seed_ranges = {}
	for seed, range in lines[1]:gmatch("(%d+)%s+(%d+)") do
		local max = seed + range
		table.insert(seed_ranges, { seed, math.floor(max) })
	end

	for header, block in content:gmatch("(.-:)\n(.-)\n\n") do
		local ranges = {}

		for line in block:gmatch("(%d+%s+%d+%s+%d+)") do
			local values = {}
			for value in line:gmatch("%d+") do
				table.insert(values, tonumber(value))
			end
			table.insert(ranges, values)
		end

		local new_ranges = {}

		while #seed_ranges > 0 do
			local seed, end_seed = unpack(table.remove(seed_ranges))
			seed = tonumber(seed)
			end_seed = tonumber(end_seed)
			local index = 1

			while ranges[index] do
				local dest, src, range = unpack(ranges[index])
				local overlap_start = math.max(seed, src)
				local overlap_end = math.min(end_seed, src + range)

				if overlap_start < overlap_end then
					table.insert(new_ranges, { overlap_start - src + dest, overlap_end - src + dest })

					if overlap_start > seed then
						table.insert(seed_ranges, { seed, overlap_start })
					end

					if end_seed > overlap_end then
						table.insert(seed_ranges, { overlap_end, end_seed })
					end

					break
				end

				index = index + 1
			end

			if not ranges[index] then
				table.insert(new_ranges, { seed, end_seed })
			end
		end

		seed_ranges = new_ranges
	end

	local min = math.huge
	for _, range in ipairs(seed_ranges) do
		local dest, src = unpack(range)
		if dest < min then
			min = dest
		end
	end
	output = min

	local end_time = os.clock() - starting
	print("Output is : " .. output .. " | Time taken: " .. end_time .. " seconds")
	file:close()
end
