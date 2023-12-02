local file = io.open("input_02", "r") 

if file then
    local numberMap = {
        one = 1, two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9
    }
    local sum = 0
    local content = file:read("*a")

    for line in content:gmatch("[^\r\n]+") do
        for i = 1, #line do
            for key, value in pairs(numberMap) do
               local location = string.find(line, key)
               if location then
                    line = line:sub(1, location)..value..line:sub(location+1)
               end
            end
        end

        local num = line:gsub("%D", "")
        if #num > 2 then
            num = num:sub(1, 1) .. num:sub(#num, #num)
        elseif #num < 2 then
            num = num .. num
        end
        sum = sum + tonumber(num)
    end

    file:close() 
end