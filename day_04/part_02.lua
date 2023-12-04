local file = io.open("input_02", "r")

function extract_numbers(number_string)
	local numbers = {}
	for number in number_string:gmatch("%d+") do
		table.insert(numbers, tonumber(number))
	end
	return numbers
end

if file then
	local content = file:read("*a")
	local starting = os.clock()

	local sum = 0
	local details = {}
	local precompute = {}

	for line in content:gmatch("[^\r\n]+") do
		local card_num, winning, given = line:match("Card%s+(%d+):%s+([%d%s]+)%s*|%s*([%d%s]+)")
		if card_num and winning and given then
			local detail = {
				card_number = tonumber(card_num),
				winning_numbers = extract_numbers(winning),
				given_numbers = extract_numbers(given),
				num_instances = 1,
			}

			local winning_number_set = {}
			for _, number in ipairs(detail.winning_numbers) do
				winning_number_set[number] = true
			end

			local matches = 0
			for _, given_number in ipairs(detail.given_numbers) do
				if winning_number_set[given_number] then
					matches = matches + 1
				end
			end

			precompute[tonumber(card_num)] = matches
			table.insert(details, detail)
		end
	end

	for index, detail in ipairs(details) do
		local matches = precompute[detail.card_number]

		for i = 1, matches do
			local next_index = index + i
			if next_index > #details then
				break
			end

			details[next_index].num_instances = details[next_index].num_instances + detail.num_instances
		end

		sum = sum + detail.num_instances
	end

	local end_time = os.clock() - starting
	print("Output is : " .. sum .. " | Time taken: " .. end_time .. " seconds")

	file:close()
end
