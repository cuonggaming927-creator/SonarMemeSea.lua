local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Tạo Window chính
local Window = WindUI:CreateWindow({
    Title = "Escape Tsunami",
    Icon = "rbxassetid://10734951102",
    Author = "By tiktok:toibitretrau11222",
    Folder = "MyscriptEscapeTsunami"
})

-- Tạo các tabs
local MainTab = Window:CreateTab({
    Title = "Main", -- Tên tab
    Icon = "home", -- Icon từ Lucide icons
    Description = "Main features", -- Mô tả (tùy chọn)
})

local PlayerTab = Window:CreateTab({
    Title = "Player",
    Icon = "user",
    Description = "Player settings",
})

local SettingsTab = Window:CreateTab({
    Title = "Settings",
    Icon = "settings",
    Description = "Script settings",
})

local CreditTab = Window:CreateTab({
    Title = "Credits",
    Icon = "heart",
    Description = "Information",
    Locked = false, -- false = không khóa, true = khóa tab
})

-- Thêm các section và element vào tab
-- Tab Main
local MainSection = MainTab:CreateSection({
    Title = "Main Features",
    Side = "Left", -- Left hoặc Right
})

-- Thêm toggle
MainSection:AddToggle({
    Title = "Auto Farm",
    Description = "Auto collect items",
    Callback = function(Value)
        print("Auto Farm:", Value)
    end
})

-- Tab Player
local PlayerSection = PlayerTab:CreateSection({
    Title = "Player Settings",
    Side = "Left",
})

-- Thêm slider
PlayerSection:AddSlider({
    Title = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

-- Tab Settings
local SettingsSection = SettingsTab:CreateSection({
    Title = "Script Settings",
    Side = "Left",
})

-- Thêm dropdown
SettingsSection:AddDropdown({
    Title = "Theme",
    Values = {"Dark", "Light", "Blue", "Purple"},
    Default = 1,
    Callback = function(Value)
        print("Selected theme:", Value)
    end
})

-- Tab Credits
local CreditSection = CreditTab:CreateSection({
    Title = "Information",
    Side = "Left",
})

-- Thêm label
CreditSection:AddLabel({
    Title = "Script by: toibitretrau11222",
})

CreditSection:AddLabel({
    Title = "Version: 1.0.0",
})

-- Khởi tạo window
Window:Init()
