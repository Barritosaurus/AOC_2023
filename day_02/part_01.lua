local file = io.open("input_01", "r") 

if file then
    local sum = 0
    local content = file:read("*a")

    local limits = {
        red = 12,
        green = 13,
        blue = 14
    }
    local validLines = {}

    local number_of_lines = 0
    for line in content:gmatch("[^\r\n]+") do
        number_of_lines = number_of_lines + 1
        local colors = {
            red = 0,
            blue = 0,
            green = 0
        }
        local lineIsValid = true
        
        if line:sub(#line) ~= ';' then
            line = line .. ';'
        end

        for key, value in pairs(colors) do
            local instances = {}
            for match in line:gmatch("(.-);") do
                table.insert(instances, match)
            end

            for i = 1, #instances do
                local instance = instances[i]
                local location = string.find(instance, key, pos)

                if location then
                    local num = instance:sub(location - 4, location)
                    num = num:gsub("%D", "")
                    colors[key] = tonumber(num)
                end

                
                if colors[key] > limits[key] then
                    lineIsValid = false
                    break
                end

                colors.red = 0
                colors.blue = 0
                colors.green = 0
            end

            colors.red = 0
            colors.blue = 0
            colors.green = 0
        end

        if lineIsValid then
            table.insert(validLines, line)
        end
    end

    for _, line in pairs(validLines) do
        sum = sum + tonumber(string.match(line, "Game (%d+):"))
    end

    print(sum)

    file:close() 
end