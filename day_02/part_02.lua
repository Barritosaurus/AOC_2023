local file = io.open("input_02", "r") 

if file then
    local sum = 0
    local content = file:read("*a")
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
                    if tonumber(num) > colors[key] then
                        colors[key] = tonumber(num)
                    end
                end
            end
        end

        sum = sum + colors.red * colors.blue * colors.green

        colors.red = 0
        colors.blue = 0
        colors.green = 0
    end

    print(sum)

    file:close() 
end