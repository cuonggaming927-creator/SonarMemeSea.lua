--// SONAR HUB - MEME SEA AUTO FARM (FIX PLAYER)
repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- PLAYER
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- RESPAWN FIX
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- SETTINGS
local AutoFarm = false
local FarmDistance = 6
local FarmSpeed = 120

-- =========================
-- UTILS
-- =========================
local function EquipWeapon()
    for _, tool in pairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = Character
            return tool
        end
    end
end

local function Attack()
    local tool = Character:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function()
            tool:Activate()
        end)
    end
end

local function TweenTo(cf)
    local dist = (HRP.Position - cf.Position).Magnitude
    local tween = TweenService:Create(
        HRP,
        TweenInfo.new(dist / FarmSpeed, Enum.EasingStyle.Linear),
        {CFrame = cf}
    )
    tween:Play()
    tween.Completed:Wait()
end

-- =========================
-- ENEMY DETECTION (FIX)
-- =========================

-- ƯU TIÊN FOLDER ENEMY (AN TOÀN NHẤT)
local EnemyFolder =
    workspace:FindFirstChild("Enemies")
    or workspace:FindFirstChild("Mobs")
    or workspace:FindFirstChild("NPCs")

-- Check model có phải player không
local function IsPlayer(model)
    return Players:GetPlayerFromCharacter(model) ~= nil
end
--GETNEARESTENEMY
local function GetNearestEnemy()
    local closest = nil
    local shortest = math.huge

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model")
        and v:FindFirstChild("Humanoid")
        and v:FindFirstChild("HumanoidRootPart")
        and v.Humanoid.Health > 0
        and not Players:GetPlayerFromCharacter(v) -- LOẠI PLAYER
        and v.Name ~= Character.Name then

            local dist = (HRP.Position - v.HumanoidRootPart.Position).Magnitude
            if dist < shortest and dist < 500 then
                shortest = dist
                closest = v
            end
        end
    end

    return closest
end


-- =========================
-- AUTO FARM LOOP
-- =========================
if not Character:FindFirstChildOfClass("Tool") then
    EquipWeapon()
    task.wait(0.5)
end
task.spawn(function()
    while task.wait(0.1) do
        if AutoFarm and Character and Humanoid.Health > 0 then
            local enemy = GetNearestEnemy()
            if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                EquipWeapon()
                local erp = enemy.HumanoidRootPart

                TweenTo(erp.CFrame * CFrame.new(0, 0, FarmDistance))

                repeat
                    task.wait()
                    Attack()
                until not AutoFarm
                    or enemy.Humanoid.Health <= 0
                    or (HRP.Position - erp.Position).Magnitude > 20
            end
        end
    end
end)
Humanoid:ChangeState(Enum.HumanoidStateType.Running)
-- =========================
-- GUI
-- =========================
pcall(function()
    game.CoreGui.SonarMemeSea:Destroy()
end)

local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "SonarMemeSea"
Gui.ResetOnSpawn = false

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromScale(0.3, 0.25)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.fromScale(1,0.3)
Title.BackgroundTransparency = 1
Title.Text = "SONAR 🌙 HUB - MEME SEA"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextColor3 = Color3.new(1,1,1)

local FarmBtn = Instance.new("TextButton", Main)
FarmBtn.Size = UDim2.fromScale(0.8,0.35)
FarmBtn.Position = UDim2.fromScale(0.1,0.5)
FarmBtn.Text = "Auto Farm : OFF"
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.TextSize = 15
FarmBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
FarmBtn.TextColor3 = Color3.new(1,1,1)
FarmBtn.BorderSizePixel = 0
Instance.new("UICorner", FarmBtn).CornerRadius = UDim.new(0,12)

FarmBtn.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    FarmBtn.Text = "Auto Farm : "..(AutoFarm and "ON" or "OFF")
    FarmBtn.BackgroundColor3 = AutoFarm
        and Color3.fromRGB(90,50,160)
        or Color3.fromRGB(40,40,50)
end)
