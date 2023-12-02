local file = io.open("input", "r") 

if file then
    local sum = 0
    local content = file:read("*a")
    for line in content:gmatch("[^\r\n]+") do
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