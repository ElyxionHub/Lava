-- ==========================================
--  SIMPLE & GUARANTEED TO SHOW
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Button1 = Instance.new("TextButton")
local Button2 = Instance.new("TextButton")

-- Properties
ScreenGui.Name = "ScriptSelector"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 65)
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Script Selector"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

Button1.Name = "Button1"
Button1.Parent = MainFrame
Button1.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
Button1.Position = UDim2.new(0.1, 0, 0.3, 0)
Button1.Size = UDim2.new(0.8, 0, 0, 45)
Button1.Font = Enum.Font.Gotham
Button1.Text = "🟢 Good UI (New)"
Button1.TextColor3 = Color3.fromRGB(255, 255, 255)
Button1.TextSize = 14

Button2.Name = "Button2"
Button2.Parent = MainFrame
Button2.BackgroundColor3 = Color3.fromRGB(50, 90, 160)
Button2.Position = UDim2.new(0.1, 0, 0.65, 0)
Button2.Size = UDim2.new(0.8, 0, 0, 45)
Button2.Font = Enum.Font.Gotham
Button2.Text = "🔵 Good UI (Old)"
Button2.TextColor3 = Color3.fromRGB(255, 255, 255)
Button2.TextSize = 14

-- BUTTON CLICKS
Button1.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHubScript/UniversalScript/refs/heads/main/obfuscated_script-1789699361831.lua.txt"))()
end)

Button2.MouseButton1Click:Connect(function()
    https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/obfuscated.lua%20(4).txt"))()
end)
