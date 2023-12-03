local file = io.open("input_01", "r")
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

	for line in content:gmatch("[^\r\n]+") do
		local row = {}
		for c in line:gmatch(".") do
			table.insert(row, c)
		end
		if width == 0 then
			width = #row
		end
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
							if
								grid[x + check_x][y + check_y] ~= "." and not grid[x + check_x][y + check_y]:match("%d")
							then
								sum = sum + tonumber(number)
								break
							end
						end
					end
				elseif size == 2 then
					for i = 1, #double_checks do
						local check = double_checks[i]
						local check_x = check[1]
						local check_y = check[2]
						if grid[x + check_x] and grid[x + check_x][y + check_y] then
							if
								grid[x + check_x][y + check_y] ~= "." and not grid[x + check_x][y + check_y]:match("%d")
							then
								sum = sum + tonumber(number)
								break
							end
						end
					end
				elseif size == 3 then
					for i = 1, #triple_checks do
						local check = triple_checks[i]
						local check_x = check[1]
						local check_y = check[2]
						if grid[x + check_x] and grid[x + check_x][y + check_y] then
							if
								grid[x + check_x][y + check_y] ~= "." and not grid[x + check_x][y + check_y]:match("%d")
							then
								sum = sum + tonumber(number)
								break
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

	print(sum)

	file:close()
end
