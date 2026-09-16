-- =============================================
--  GET SCRIPT — Updated Link
-- =============================================

-- Show message first
local MessageGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local LinkBox = Instance.new("TextBox")
local CloseBtn = Instance.new("TextButton")

MessageGui.Name = "GetScriptNotice"
MessageGui.Parent = game:GetService("CoreGui")
MessageGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = MessageGui
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
MainFrame.Size = UDim2.new(0, 480, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 130)
Title.Font = Enum.Font.GothamBold
Title.Text = [[SCRIPT UPDATED

Sorry — Our Script Has Changed!
Please COPY the new link below
and PASTE it into your executor:]]
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextWrapped = true

LinkBox.Parent = MainFrame
LinkBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LinkBox.Position = UDim2.new(0, 20, 0, 140)
LinkBox.Size = UDim2.new(1, -40, 0, 50)
LinkBox.Font = Enum.Font.Code
LinkBox.Text = "https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/obfuscated.lua%20(3).txt"
LinkBox.TextColor3 = Color3.fromRGB(0, 255, 127)
LinkBox.TextSize = 11
LinkBox.TextEditable = false
LinkBox.ClearTextOnFocus = false

CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.Position = UDim2.new(0, 20, 0, 210)
CloseBtn.Size = UDim2.new(1, -40, 0, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "CLOSE"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 15

CloseBtn.MouseButton1Click:Connect(function()
    MessageGui:Destroy()
end)

-- =============================================
--  AUTO LOAD THE SCRIPT
-- =============================================
local ScriptLink = "https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/obfuscated.lua%20(3).txt"

task.wait(2) -- wait 2 seconds so you can see the notice

local Success, Error = pcall(function()
    loadstring(game:HttpGet(ScriptLink))()
end)

if not Success then
    warn("Failed to load script: " .. tostring(Error))
end
