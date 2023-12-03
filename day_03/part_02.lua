local file = io.open("input_02", "r")
local single_checks = {
	{ -1, -1 },
	{ 0, -1 },
	{ 1, -1 },
	{ -1, 0 },
	{ 1, 0 },
	{ -1, 1 },
	{ 0, 1 },
	{ 1, 1 },
}

local double_checks = {
	{ -1, -1 },
	{ -1, 0 },
	{ -1, 1 },
	{ -1, 2 },

	{ 0, -1 },
	{ 0, 2 },

	{ 1, -1 },
	{ 1, 0 },
	{ 1, 1 },
	{ 1, 2 },
}

local triple_checks = {
	{ -1, -1 },
	{ -1, 0 },
	{ -1, 1 },
	{ -1, 2 },
	{ -1, 3 },

	{ 0, -1 },
	{ 0, 3 },

	{ 1, -1 },
	{ 1, 0 },
	{ 1, 1 },
	{ 1, 2 },
	{ 1, 3 },
}

if file then
	local content = file:read("*a")
	local width, height, sum = 0, 0, 0
	local grid = {}
	local gears = {}
	local num_gears = 0

	local test_x = 0
	local test_y = 0
	for line in content:gmatch("[^\r\n]+") do
		test_x = test_x + 1
		local row = {}
		for c in line:gmatch(".") do
			test_y = test_y + 1
			table.insert(row, c)

			if c == "*" then
				num_gears = num_gears + 1
				gears[tostring(test_x) .. "|" .. tostring(test_y)] = {
					connections = {},
				}
			end
		end
		if width == 0 then
			width = #row
		end
		test_y = 0
		table.insert(grid, row)
		height = height + 1
	end

	for x = 1, #grid do
		local y = 1

		while y < #grid[x] do
			local char = grid[x][y]
			if char:match("%d") then
				local i = 1
				local number = tostring(char)
				while grid[x] and grid[x][y + i] do
					if grid[x][y + i]:match("%d") then
						number = number .. grid[x][y + i]
						i = i + 1
					else
						break
					end
				end

				local size = #number
				if size == 1 then
					for i = 1, #single_checks do
						local check = single_checks[i]
						local check_x = check[1]
						local check_y = check[2]
						if grid[x + check_x] and grid[x + check_x][y + check_y] then
							if gears[tostring(x + check_x) .. "|" .. tostring(y + check_y)] then
								table.insert(
									gears[tostring(x + check_x) .. "|" .. tostring(y + check_y)].connections,
									number
								)
							end
						end
					end
				elseif size == 2 then
					for i = 1, #double_checks do
						local check = double_checks[i]
						local check_x = check[1]
						local check_y = check[2]
						if grid[x + check_x] and grid[x + check_x][y + check_y] then
							if gears[tostring(x + check_x) .. "|" .. tostring(y + check_y)] then
								table.insert(
									gears[tostring(x + check_x) .. "|" .. tostring(y + check_y)].connections,
									number
								)
							end
						end
					end
				elseif size == 3 then
					for i = 1, #triple_checks do
						local check = triple_checks[i]
						local check_x = check[1]
						local check_y = check[2]
						if grid[x + check_x] and grid[x + check_x][y + check_y] then
							if gears[tostring(x + check_x) .. "|" .. tostring(y + check_y)] then
								table.insert(
									gears[tostring(x + check_x) .. "|" .. tostring(y + check_y)].connections,
									number
								)
							end
						end
					end
				end
				y = y + i
			else
				y = y + 1
			end
		end
	end

	for key, value in pairs(gears) do
		if #value.connections == 2 then
			sum = sum + (tonumber(value.connections[1]) * tonumber(value.connections[2]))
		end
	end

	print(sum)

	file:close()
end
