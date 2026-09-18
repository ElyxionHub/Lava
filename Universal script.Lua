-- ⭐ Script Selector — UPDATED ⭐
-- Black Screen → Star Animation → Choose Version
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Cleanup
if PlayerGui:FindFirstChild("RayfieldScriptSelect") then
    PlayerGui.RayfieldScriptSelect:Destroy()
end

-- ─── CREATE UI ───
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RayfieldScriptSelect"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 9999
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Full Black Screen
local BlackBg = Instance.new("Frame")
BlackBg.Name = "BlackBg"
BlackBg.Size = UDim2.fromScale(1, 1)
BlackBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackBg.BorderSizePixel = 0
BlackBg.Parent = ScreenGui

-- Star Container
local StarContainer = Instance.new("Frame")
StarContainer.Size = UDim2.fromScale(1, 1)
StarContainer.BackgroundTransparency = 1
StarContainer.Parent = BlackBg

-- Content Holder
local Content = Instance.new("Frame")
Content.Size = UDim2.fromScale(1, 1)
Content.BackgroundTransparency = 1
Content.Visible = false
Content.Parent = BlackBg

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 0, 0, 70)
Title.Position = UDim2.new(0.5, 0, 0.18, 0)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundTransparency = 1
Title.Text = "✨ SCRIPT SELECTION ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 36
Title.TextTransparency = 1
Title.Parent = Content

-- Button Creator
local function MakeButton(yPos, label, desc, link)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 420, 0, 110)
    Btn.Position = UDim2.new(0.5, 0, yPos, 0)
    Btn.AnchorPoint = Vector2.new(0.5, 0.5)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
    Btn.BorderSizePixel = 0
    Btn.CornerRadius = UDim.new(0, 14)
    Btn.Text = ""
    Btn.BackgroundTransparency = 1
    Btn.AutoLocalize = false
    Btn.Parent = Content

    local BtnTitle = Instance.new("TextLabel")
    BtnTitle.Size = UDim2.new(1, -30, 0.5, -5)
    BtnTitle.Position = UDim2.new(0, 30, 0, 10)
    BtnTitle.BackgroundTransparency = 1
    BtnTitle.Text = label
    BtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnTitle.Font = Enum.Font.GothamBold
    BtnTitle.TextSize = 26
    BtnTitle.TextTransparency = 1
    BtnTitle.Parent = Btn

    local BtnSub = Instance.new("TextLabel")
    BtnSub.Size = UDim2.new(1, -30, 0.5, -5)
    BtnSub.Position = UDim2.new(0, 30, 0.5, 0)
    BtnSub.BackgroundTransparency = 1
    BtnSub.Text = desc
    BtnSub.TextColor3 = Color3.fromRGB(170, 170, 170)
    BtnSub.Font = Enum.Font.Gotham
    BtnSub.TextSize = 17
    BtnSub.TextTransparency = 1
    BtnSub.Parent = Btn

    -- Hover
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 70)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 35)}):Play()
    end)

    -- Click
    Btn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        task.wait(0.05)
        loadstring(game:HttpGet(link))()
    end)

    return Btn, BtnTitle, BtnSub
end

-- ─── YOUR BUTTONS ───
-- Button 1: Updated label & link
local BtnOld, T1, S1 = MakeButton(0.42, "[ 1 ]  Good UI (Didn't update)", "Legacy version — No longer updated",
    "https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/obfuscated.lua%20(4).txt")

-- Button 2: New Updated
local BtnNew, T2, S2 = MakeButton(0.62, "[ 2 ]  NEW — GoodUi Updated ✅", "Universal Script • Recommended",
    "https://raw.githubusercontent.com/ElyxionHubScript/UniversalScript/refs/heads/main/obfuscated_script-1789699361831.lua.txt")

-- ─── STAR PARTICLES ───
local function SpawnStar()
    local Star = Instance.new("Frame")
    local sz = math.random(2, 6)
    Star.Size = UDim2.fromOffset(sz, sz)
    Star.Position = UDim2.new(math.random(), -sz/2, 1.05, 0)
    Star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Star.BorderSizePixel = 0
    Star.CornerRadius = UDim.new(1, 0)
    Star.Transparency = 1
    Star.Parent = StarContainer

    TweenService:Create(Star, TweenInfo.new(math.random(1.5, 3), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
        Transparency = 0.2 + math.random() * 0.5
    }):Play()

    TweenService:Create(Star, TweenInfo.new(math.random(4, 8), Enum.EasingStyle.Linear), {
        Position = UDim2.new(Star.Position.X.Scale + (math.random() - 0.5) * 0.08, 0, -0.1, 0)
    }):Play()

    game.Debris:AddItem(Star, math.random(6, 12))
end

-- Spawn stars
task.spawn(function()
    for _ = 1, 100 do task.wait(0.02) SpawnStar() end
    while task.wait(0.06) do SpawnStar() end
end)

-- ─── APPEAR ANIMATION ───
task.wait(1.5)

Content.Visible = true
TweenService:Create(Title, TweenInfo.new(1.0), {TextTransparency = 0}):Play()

task.wait(0.35)
TweenService:Create(BtnOld, TweenInfo.new(0.9), {BackgroundTransparency = 0}):Play()
TweenService:Create(T1, TweenInfo.new(0.9), {TextTransparency = 0}):Play()
TweenService:Create(S1, TweenInfo.new(0.9), {TextTransparency = 0}):Play()

task.wait(0.3)
TweenService:Create(BtnNew, TweenInfo.new(0.9), {BackgroundTransparency = 0}):Play()
TweenService:Create(T2, TweenInfo.new(0.9), {TextTransparency = 0}):Play()
TweenService:Create(S2, TweenInfo.new(0.9), {TextTransparency = 0}):Play()
