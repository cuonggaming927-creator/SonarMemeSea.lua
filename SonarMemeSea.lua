local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Escape Tsunami",
    Icon = "rbxassetid://10734951102",
    Author = "Your Name",
    Folder = "EscapeTsunami"
})

-- Cách tạo tab ĐÚNG
local Tab = Window:CreateTab({
    Name = "Main",  -- Dùng "Name" thay vì "Title" trong phiên bản mới
    Icon = "home",
    Description = "Main Tab"
})

-- Tạo page (thay vì section)
local Page = Tab:CreatePage({
    Name = "Main Page",
    Icon = "settings"
})

-- Tạo section trong page
local Section = Page:CreateSection({
    Name = "Main Features"
})

-- Thêm element
Section:AddToggle({
    Name = "Auto Farm",
    Description = "Auto farm money",
    Callback = function(v)
        print("Toggle:", v)
    end
})

Window:Init()
