local file = io.open("input_01", "r")

function extract_numbers(number_string)
	local numbers = {}
	for number in number_string:gmatch("%d+") do
		table.insert(numbers, tonumber(number))
	end
	return numbers
end

if file then
	local sum = 0
	local content = file:read("*a")
	local starting = os.clock()

	local details = {}

	for line in content:gmatch("[^\r\n]+") do
		local card_num, winning, given = line:match("Card%s+(%d+):%s+([%d%s]+)%s*|%s*([%d%s]+)")
		if card_num and winning and given then
			table.insert(details, {
				card_number = tonumber(card_num),
				winning_numbers = extract_numbers(winning),
				given_numbers = extract_numbers(given),
			})
		end
	end

	for _, detail in ipairs(details) do
		local card_number = detail.card_number
		local winning_numbers = detail.winning_numbers
		local given_numbers = detail.given_numbers

		local matches = 0
		local card_value = 1
		for _, given_number in ipairs(given_numbers) do
			for _, winning_number in ipairs(winning_numbers) do
				if given_number == winning_number then
					matches = matches + 1
				end
			end
		end

		if matches > 0 then
			sum = sum + math.floor(2 ^ (matches - 1))
		end
	end

	local end_time = os.clock() - starting
	print("Output is : " .. sum .. " | Time taken: " .. end_time .. " seconds")

	file:close()
end
