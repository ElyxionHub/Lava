--[[
    elyxionHub | BEAUTIFUL LOADING SYSTEM + ALL REAL SCRIPTS
    Created by Lavatrapgaming1
    Updated Sep 16, 2026
--]]

-- ==============================================
-- BEAUTIFUL FULL SCREEN LOADING SYSTEM
-- ==============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clean up old loading UI
if PlayerGui:FindFirstChild("elyxionHub_Loading") then
    PlayerGui:FindFirstChild("elyxionHub_Loading"):Destroy()
end

-- Create Loading Screen
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "elyxionHub_Loading"
LoadingScreen.Parent = PlayerGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.DisplayOrder = 99999
LoadingScreen.IgnoreGuiInset = true

-- Background Gradient
local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundColor3 = Color3.fromHex("#0A0A0F")
Background.Parent = LoadingScreen

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromHex("#0A0A0F")),
    ColorSequenceKeypoint.new(0.5, Color3.fromHex("#1A0A1A")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#0A0A0F"))
})
Gradient.Rotation = 45
Gradient.Parent = Background

-- Animated Background Particles
local ParticleContainer = Instance.new("Frame")
ParticleContainer.Size = UDim2.fromScale(1, 1)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ClipsDescendants = true
ParticleContainer.Parent = Background

-- Create floating particles
for i = 1, 25 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.fromOffset(math.random(2, 6), math.random(2, 6))
    particle.Position = UDim2.fromScale(math.random(), math.random())
    particle.BackgroundColor3 = Color3.fromHex("#FF3355")
    particle.BackgroundTransparency = 0.7
    particle.BorderSizePixel = 0
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle
    particle.Parent = ParticleContainer
    
    -- Animate floating
    task.spawn(function()
        local tweenInfo = TweenInfo.new(math.random(8, 15), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
        local tween = TweenService:Create(particle, tweenInfo, {
            Position = UDim2.fromScale(
                math.clamp(particle.Position.X.Scale + (math.random() - 0.5) * 0.3, 0, 1),
                math.clamp(particle.Position.Y.Scale - 0.3, 0, 1)
            ),
            BackgroundTransparency = 0.9
        })
        tween:Play()
    end)
end

-- Glow effect behind logo
local LogoGlow = Instance.new("Frame")
LogoGlow.Size = UDim2.fromOffset(400, 400)
LogoGlow.Position = UDim2.fromScale(0.5, 0.42)
LogoGlow.AnchorPoint = Vector2.new(0.5, 0.5)
LogoGlow.BackgroundColor3 = Color3.fromHex("#FF3355")
LogoGlow.BackgroundTransparency = 0.85
LogoGlow.BorderSizePixel = 0
local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = LogoGlow
LogoGlow.Parent = Background

-- Pulsing glow animation
task.spawn(function()
    while true do
        local tween1 = TweenService:Create(LogoGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.75, Size = UDim2.fromOffset(420, 420)})
        tween1:Play()
        tween1.Completed:Wait()
        local tween2 = TweenService:Create(LogoGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.88, Size = UDim2.fromOffset(380, 380)})
        tween2:Play()
        tween2.Completed:Wait()
    end
end)

-- Main Container
local Container = Instance.new("Frame")
Container.Size = UDim2.fromOffset(450, 320)
Container.Position = UDim2.fromScale(0.5, 0.5)
Container.AnchorPoint = Vector2.new(0.5, 0.5)
Container.BackgroundTransparency = 1
Container.Parent = LoadingScreen

-- Logo / Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 70)
Title.Position = UDim2.fromScale(0, 0)
Title.BackgroundTransparency = 1
Title.Text = "elyxionHub"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Color3.fromHex("#FF3355")
Title.TextSize = 52
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.fromHex("#FF0033")
Title.Parent = Container

-- Subtitle
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 24)
SubTitle.Position = UDim2.new(0, 0, 0, 75)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Created by Lavatrapgaming1"
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextColor3 = Color3.fromHex("#AAAAAA")
SubTitle.TextSize = 16
SubTitle.Parent = Container

-- Version tag
local VersionTag = Instance.new("TextLabel")
VersionTag.Size = UDim2.new(0, 80, 0, 20)
VersionTag.Position = UDim2.new(1, -80, 0, 78)
VersionTag.BackgroundTransparency = 1
VersionTag.Text = "v2.0"
VersionTag.Font = Enum.Font.Gotham
VersionTag.TextColor3 = Color3.fromHex("#666666")
VersionTag.TextSize = 12
VersionTag.Parent = Container

-- Progress Bar Background
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(1, 0, 0, 14)
BarBg.Position = UDim2.new(0, 0, 0, 130)
BarBg.BackgroundColor3 = Color3.fromHex("#1A1A22")
BarBg.BorderSizePixel = 0
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = BarBg
BarBg.Parent = Container

-- Progress Bar Stroke
local BarStroke = Instance.new("UIStroke")
BarStroke.Color = Color3.fromHex("#333344")
BarStroke.Thickness = 1
BarStroke.Parent = BarBg

-- Progress Bar Fill
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromHex("#FF3355")
BarFill.BorderSizePixel = 0
local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = BarFill
BarFill.Parent = BarBg

-- Bar gradient
local BarGradient = Instance.new("UIGradient")
BarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromHex("#FF3355")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#FF6688"))
})
BarGradient.Parent = BarFill

-- Shine effect on bar
local BarShine = Instance.new("Frame")
BarShine.Size = UDim2.new(0.3, 0, 1, 0)
BarShine.Position = UDim2.new(-0.3, 0, 0, 0)
BarShine.BackgroundColor3 = Color3.fromHex("#FFFFFF")
BarShine.BackgroundTransparency = 0.85
BarShine.BorderSizePixel = 0
local shineCorner = Instance.new("UICorner")
shineCorner.CornerRadius = UDim.new(1, 0)
shineCorner.Parent = BarShine
BarShine.Parent = BarFill

-- Animate shine
task.spawn(function()
    while BarShine.Parent do
        BarShine.Position = UDim2.new(-0.3, 0, 0, 0)
        local tween = TweenService:Create(BarShine, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {Position = UDim2.new(1, 0, 0, 0)})
        tween:Play()
        tween.Completed:Wait()
        task.wait(0.3)
    end
end)

-- Percentage Text
local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(0, 50, 0, 20)
PercentText.Position = UDim2.new(1, 10, 0, -3)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.Font = Enum.Font.GothamBold
PercentText.TextColor3 = Color3.fromHex("#FF3355")
PercentText.TextSize = 14
PercentText.TextXAlignment = Enum.TextXAlignment.Left
PercentText.Parent = Container

-- Status Text
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 22)
StatusText.Position = UDim2.new(0, 0, 0, 155)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Initializing..."
StatusText.Font = Enum.Font.Gotham
StatusText.TextColor3 = Color3.fromHex("#888888")
StatusText.TextSize = 14
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = Container

-- Loading dots animation
task.spawn(function()
    local dots = {"", ".", "..", "..."}
    local i = 1
    while StatusText.Parent do
        local base = StatusText.Text:gsub("%.+$", "")
        StatusText.Text = base .. dots[i]
        i = i % 4 + 1
        task.wait(0.4)
    end
end)

-- Tip Text
local TipText = Instance.new("TextLabel")
TipText.Size = UDim2.new(1, 0, 0, 18)
TipText.Position = UDim2.new(0, 0, 0, 185)
TipText.BackgroundTransparency = 1
TipText.Text = "Tip: Press Right Shift to open/close the UI"
TipText.Font = Enum.Font.Gotham
TipText.TextColor3 = Color3.fromHex("#555555")
TipText.TextSize = 12
TipText.TextXAlignment = Enum.TextXAlignment.Center
TipText.Parent = Container

-- Fade in animation
Background.BackgroundTransparency = 1
Container.BackgroundTransparency = 1
Title.TextTransparency = 1
SubTitle.TextTransparency = 1
BarBg.BackgroundTransparency = 1
StatusText.TextTransparency = 1
TipText.TextTransparency = 1

local fadeIn = TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 0})
fadeIn:Play()
task.wait(0.2)
TweenService:Create(Title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(SubTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
task.wait(0.2)
TweenService:Create(BarBg, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
TweenService:Create(StatusText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(TipText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
task.wait(0.3)

-- Loading steps with smooth progress
local loadingSteps = {
    {percent = 0.10, text = "Initializing Core Systems"},
    {percent = 0.22, text = "Loading UI Library"},
    {percent = 0.35, text = "Setting up Themes & Styles"},
    {percent = 0.48, text = "Preparing Game Tabs"},
    {percent = 0.60, text = "Loading Script Database"},
    {percent = 0.72, text = "Configuring Animations"},
    {percent = 0.85, text = "Finalizing Components"},
    {percent = 0.95, text = "Almost Ready"},
    {percent = 1.00, text = "Welcome to elyxionHub"}
}

local currentPercent = 0

for _, step in ipairs(loadingSteps) do
    StatusText.Text = step.text
    
    -- Smooth tween to target percent
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local targetSize = UDim2.new(step.percent, 0, 1, 0)
    local tween = TweenService:Create(BarFill, tweenInfo, {Size = targetSize})
    tween:Play()
    
    -- Animate percentage number
    local startPct = currentPercent
    local endPct = step.percent
    local startTime = os.clock()
    local duration = 0.4
    
    while os.clock() - startTime < duration do
        local alpha = (os.clock() - startTime) / duration
        alpha = math.min(alpha, 1)
        local smooth = alpha * (2 - alpha) -- ease out quad
        local display = math.floor((startPct + (endPct - startPct) * smooth) * 100)
        PercentText.Text = display .. "%"
        task.wait()
    end
    
    currentPercent = step.percent
    PercentText.Text = math.floor(currentPercent * 100) .. "%"
    
    if step.percent < 1 then
        task.wait(0.15)
    end
end

-- Complete!
PercentText.Text = "100%"
StatusText.Text = "Ready!"
StatusText.TextColor3 = Color3.fromHex("#4CD964")

task.wait(0.5)

-- Fade out animation
local fadeOutTime = 0.6
TweenService:Create(Background, TweenInfo.new(fadeOutTime), {BackgroundTransparency = 1}):Play()
TweenService:Create(Title, TweenInfo.new(fadeOutTime), {TextTransparency = 1}):Play()
TweenService:Create(SubTitle, TweenInfo.new(fadeOutTime), {TextTransparency = 1}):Play()
TweenService:Create(BarBg, TweenInfo.new(fadeOutTime), {BackgroundTransparency = 1}):Play()
TweenService:Create(StatusText, TweenInfo.new(fadeOutTime), {TextTransparency = 1}):Play()
TweenService:Create(TipText, TweenInfo.new(fadeOutTime), {TextTransparency = 1}):Play()
TweenService:Create(PercentText, TweenInfo.new(fadeOutTime), {TextTransparency = 1}):Play()
TweenService:Create(LogoGlow, TweenInfo.new(fadeOutTime), {BackgroundTransparency = 1}):Play()

task.wait(fadeOutTime)
LoadingScreen:Destroy()

-- ==============================================
-- MAIN UI STARTS HERE
-- ==============================================
local ok_lib, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)
if not ok_lib or not WindUI then
    warn("[elyxionHub] Failed to load WindUI")
    return
end

local function try(fn, ...)
    local ok, res = pcall(fn, ...)
    if not ok then warn("[elyxionHub] " .. tostring(res)) end
    return ok, res
end

local function call(obj, method, ...)
    if type(obj) ~= "table" and type(obj) ~= "userdata" then return nil end
    if type(obj[method]) ~= "function" then return nil end
    local ok, res = pcall(obj[method], ...)
    if not ok then warn("[elyxionHub] " .. method .. ": " .. tostring(res)) end
    return res
end

local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")

local gameName = "Unknown"
pcall(function()
    local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    if info and info.Name then gameName = info.Name end
end)

local DISCORD_LINK = "https://discord.gg/vAHRXGdkG"
local BG_ID = "135481314155653"

-- Theme
local THEME_NAME = "Dark"
do
    local ok = select(1, try(function()
        WindUI:AddTheme({
            Name = "Discord",
            Accent = "#FF3355",
            Dialog = "#2B2D31",
            Outline = "#1E1F22",
            Text = "#F2F3F5",
            Placeholder = "#949BA4",
            Background = "#313338",
            Button = "#4E5058",
            Icon = "#DBDEE1",
        })
    end))
    if ok then THEME_NAME = "Discord" end
end

-- Window
local ok_win, Window = pcall(function()
    return WindUI:CreateWindow({
        Title = "elyxionHub",
        Author = "By Lavatrapgaming1",
        Folder = "elyxionHub",
        Size = UDim2.fromOffset(600, 520),
        Transparent = true,
        Theme = THEME_NAME,
        Resizable = true,
        SideBarWidth = 160,
        Background = "rbxassetid://" .. BG_ID,
        BackgroundImageTransparency = 0,
        HideSearchBar = false,
        ScrollBarEnabled = true,
        User = { Enabled = true, Anonymous = false },
    })
end)

if not ok_win or not Window then
    Window = WindUI:CreateWindow({
        Title = "elyxionHub",
        Author = "By Lavatrapgaming1",
        Size = UDim2.fromOffset(600, 520),
        Theme = "Dark",
    })
end
if not Window then warn("[elyxionHub] Window failed") return end

if THEME_NAME == "Discord" then try(function() WindUI:SetTheme("Discord") end) end
call(Window, "SetTransparent", false)
call(Window, "SetBackground", "rbxassetid://" .. BG_ID)

-- Blue Glow Border
task.spawn(function()
    local Gui = getgenv().WindUIRoot or nil
    if not Gui then repeat task.wait(0.1) Gui = getgenv().WindUIRoot until Gui or not task.wait(2) end
    if not Gui then return end
    local function addGlow(frame)
        local outline = Instance.new("UIStroke")
        outline.Color = Color3.fromHex("#5865F2")
        outline.Thickness = 3
        outline.Transparency = 0
        outline.Parent = frame
        while frame and task.wait(1) do
            for i = 1, 30 do outline.Transparency = i/30 task.wait(0.05) end
            for i = 30, 1, -1 do outline.Transparency = i/30 task.wait(0.05) end
        end
    end
    for _, child in ipairs(Gui:GetDescendants()) do
        if child:IsA("Frame") and (child.Name == "Container" or child.Name == "MainContainer") then
            task.spawn(addGlow, child)
        end
    end
end)

-- Tag Animation Helper
local function AnimateTag(tag, colorBright, colorDim)
    task.spawn(function()
        while task.wait(1) do
            tag:SetColor(colorBright)
            task.wait(0.8)
            tag:SetColor(colorDim)
            task.wait(0.8)
        end
    end)
end

-- All Animated Tags
try(function()
    local PinoyTag = Window:Tag({ Title = "Pinoy", Color = Color3.fromHex("#00CCFF") })
    AnimateTag(PinoyTag, Color3.fromHex("#00CCFF"), Color3.fromHex("#0066CC"))

    local days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
    local DayTag = Window:Tag({ Title = days[os.date("%w")+1], Color = Color3.fromHex("#4CD964") })
    AnimateTag(DayTag, Color3.fromHex("#4CD964"), Color3.fromHex("#23A55A"))

    local hour = tonumber(os.date("%H"))
    local period = "Evening"
    if hour >= 5 and hour < 12 then period = "Morning"
    elseif hour >= 12 and hour < 18 then period = "Afternoon" end
    local TimeTag = Window:Tag({ Title = period, Color = Color3.fromHex("#FFCC00") })
    AnimateTag(TimeTag, Color3.fromHex("#FFCC00"), Color3.fromHex("#F0B232"))

    local PingTag = Window:Tag({ Title = "Ping: --ms", Color = Color3.fromHex("#4CD964") })
    task.spawn(function()
        while task.wait(1) do
            if not PingTag then break end
            local ms = 0
            pcall(function() ms = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
            local bright = (ms < 100 and "4CD964") or (ms < 200 and "FFCC00") or "FF3B30"
            local dimmed = (ms < 100 and "23A55A") or (ms < 200 and "F0B232") or "F23F43"
            PingTag:SetTitle("Ping: "..ms.."ms")
            PingTag:SetColor(Color3.fromHex(bright))
            task.wait(0.8)
            PingTag:SetColor(Color3.fromHex(dimmed))
            task.wait(0.8)
        end
    end)
end)

-- RED GLOW ANIMATION FOR OPEN BUTTON
try(function()
    Window:EditOpenButton({
        Title = "Open elyxionHub",
        CornerRadius = UDim.new(0, 16),
        StrokeThickness = 2,
        Color = ColorSequence.new(Color3.fromHex("#FF3355"), Color3.fromHex("#AA1133")),
        Draggable = true,
    })
end)

-- Load Helper
local function Load(name, url)
    WindUI:Notify({ Title = name, Content = "Loading...", Duration = 2 })
    local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
    if ok then
        WindUI:Notify({ Title = name, Content = "Loaded", Duration = 3 })
    else
        WindUI:Notify({ Title = name, Content = "Failed", Duration = 4 })
        warn(name, err)
    end
end

-- Server Hop Function
local function AddServerHop(tab)
    tab:Button({
        Title = "Server Hop - Small Server",
        Desc = "Hop to server with least players",
        Callback = function()
            local pid = game.PlaceId
            local s, data = pcall(function()
                local res = HttpService:GetAsync("https://games.roblox.com/v1/games/"..pid.."/servers/Public?sortOrder=Asc&limit=100")
                return HttpService:JSONDecode(res).data
            end)
            if not s or not data or #data == 0 then
                WindUI:Notify({ Title = "Server Hop", Content = "No servers found", Duration = 3 })
                return
            end
            table.sort(data, function(a,b) return a.players < b.players end)
            local t = data[1]
            WindUI:Notify({ Title = "Server Hop", Content = "Hopping to "..t.players.." players", Duration = 3 })
            pcall(function() LocalPlayer:LoadServer(t.id) end)
        end
    })
end

-- Helper to build tabs easily
local function MakeTab(tabName, scripts)
    local tab = Window:Tab({ Title = tabName })
    tab:Section({ Title = tabName .. " Scripts", Desc = "Scripts for "..tabName, Box = true, BoxBorder = true })
    local names = {}
    for n in pairs(scripts) do table.insert(names, n) end
    table.sort(names)
    local selected = names[1]
    tab:Dropdown({ Title = "Select Script", Values = names, Value = selected, Callback = function(c) selected = c end })
    tab:Button({ Title = "Execute Script", Callback = function() if selected then Load(selected, scripts[selected]) end end })
    AddServerHop(tab)
end

-- ==============================
-- HOME TAB
-- ==============================
local HomeTab = Window:Tab({ Title = "Home" })
HomeTab:Section({ Title = "Welcome to elyxionHub", Desc = "Select a tab from the sidebar", Box = true, BoxBorder = true })
HomeTab:Section({ Title = "Owner", Desc = "Lavatrapgaming1", Box = true, BoxBorder = true })
HomeTab:Section({ Title = "Code", Desc = "Lavatrapgaming1", Box = true, BoxBorder = true })
HomeTab:Section({ Title = "Credit To Owner of UI", Desc = "Footagesus • WindUI", Box = true, BoxBorder = true })
HomeTab:Button({
    Title = "Copy Discord Link",
    Desc = DISCORD_LINK,
    Callback = function()
        pcall(setclipboard, DISCORD_LINK)
        WindUI:Notify({ Title = "Copied", Content = "Discord link copied", Duration = 3 })
    end
})

-- ==============================
-- TUTORIAL TAB
-- ==============================
local TutorialTab = Window:Tab({ Title = "Tutorial" })
TutorialTab:Section({ Title = "How To Use elyxionHub", Desc = "Step by step guide", Box = true, BoxBorder = true })
TutorialTab:Section({ Title = "Step 1 - Open or Close UI", Desc = "Press Right Shift on your keyboard to open or close the elyxionHub window. You can also click the red Open elyxionHub button.", Box = true, BoxBorder = true })
TutorialTab:Section({ Title = "Step 2 - Select Your Game", Desc = "Click any game tab on the left sidebar. Each tab has scripts made specifically for that game.", Box = true, BoxBorder = true })
TutorialTab:Section({ Title = "Step 3 - Choose A Script", Desc = "Click the dropdown menu that says Select Script. Scroll through the list and click the script name you want.", Box = true, BoxBorder = true })
TutorialTab:Section({ Title = "Step 4 - Execute The Script", Desc = "Click the Execute Script button. A notification will appear saying Loading, then Loaded if successful.", Box = true, BoxBorder = true })
TutorialTab:Section({ Title = "Step 5 - Server Hop", Desc = "Click Server Hop to automatically find and join a server with the least players.", Box = true, BoxBorder = true })
TutorialTab:Section({ Title = "Step 6 - Your Own Scripts", Desc = "Go to the Own Script tab to run your personal scripts instantly.", Box = true, BoxBorder = true })
TutorialTab:Button({
    Title = "Copy Discord Link",
    Desc = DISCORD_LINK,
    Callback = function()
        pcall(setclipboard, DISCORD_LINK)
        WindUI:Notify({ Title = "Copied", Content = "Discord link copied", Duration = 3 })
    end
})

-- ==============================
-- OWNER TAB
-- ==============================
local OwnerTab = Window:Tab({ Title = "Owner" })
OwnerTab:Section({ Title = "Owner", Desc = "Lavatrapgaming1", Box = true, BoxBorder = true })
OwnerTab:Section({ Title = "Code", Desc = "Lavatrapgaming1", Box = true, BoxBorder = true })

-- ==============================
-- BLOX FRUITS TAB
-- ==============================
MakeTab("Blox Fruits", {
    ["Hoho Hub"] = "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI",
    ["Redz Hub"] = "https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau",
    ["Blue X Hub"] = "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua",
    ["Gravity Hub"] = "https://raw.githubusercontent.com/Dev-GravityHub/BluxFruit/refs/heads/main/Main.lua",
    ["Nova Hub"] = "https://raw.githubusercontent.com/NovaHubRBLX/NovaHub/refs/heads/main/novahub.lua",
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Astral Hub"] = "https://raw.githubusercontent.com/Vcsk/AstralHub/main/Main.lua",
    ["Night Hub"] = "https://raw.githubusercontent.com/NIGHTHUBONTOP/Main/main/NightHub.lua",
    ["Maru Hub"] = "https://raw.githubusercontent.com/LuaCrack/KimP/refs/heads/main/MaruHub",
    ["Bacon Hub"] = "https://raw.githubusercontent.com/BaconScriptHub/BaconHub/main/New-BaconHub.lua.txt"
})

-- ==============================
-- STEAL AN EGG TAB
-- ==============================
MakeTab("Steal An Egg", {
    ["Pig Hub"] = "https://raw.githubusercontent.com/mopsscript7-gif/steal-an-egg/refs/heads/main/script.lua",
    ["Solix Hub"] = "https://raw.githubusercontent.com/porqueijjmzm1/cool/main/StealAEgg",
    ["Foxname"] = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua",
    ["Ouroboros Hub"] = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua",
    ["Sena Hub"] = "https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/loader",
    ["Miranda Hub"] = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaegg",
    ["BigFroot Hub"] = "https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua",
    ["CloverHub"] = "https://raw.githubusercontent.com/Ryuun0x/Clover/main/main.lua",
    ["BK Hub"] = "https://api.luarmor.net/files/v4/loaders/9ee4edde227ac85f50872bf9e4226508.lua",
    ["ONhub"] = "https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua",
    ["Night Hub"] = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealAnEggs.luau"
})

-- ==============================
-- MUSCLE LEGEND TAB
-- ==============================
MakeTab("Muscle Legend", {
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Nova Hub"] = "https://raw.githubusercontent.com/EncryptedV10/Nova-Hub/refs/heads/main/loader.lua",
    ["KTM Hub"] = "https://raw.githubusercontent.com/zapstreams123/KTMHUB/refs/heads/main/PublicVersion",
    ["OMG Hub"] = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua",
    ["Zeroin Hub"] = "https://zeroinhub.com/api/script",
    ["Rebirth Auto"] = "https://raw.githubusercontent.com/RealRblxScripts/Muscle-Legends/main/Script"
})

-- ==============================
-- BROOKHAVEN RP TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Brookhaven RP", {
    ["Qwakk Hub"] = "https://pastebin.com/raw/FVLTqa3x",
    ["Drip Client"] = "https://raw.githubusercontent.com/realgengar/Main/refs/heads/main/base.lua",
    ["Poderoso Hub"] = "https://raw.githubusercontent.com/scriptsomega/brookhaven/refs/heads/main/Poderoso",
    ["Avatar Cloner"] = "https://raw.githubusercontent.com/Goku55050/Ares-roblox/refs/heads/main/aresxcloner.lua",
    ["Hexagon Hub"] = "https://raw.githubusercontent.com/nxvap/Hexagon/refs/heads/main/brookhaven",
    ["Cartola Hub"] = "https://raw.githubusercontent.com/Davi999z/Cartola-Hub/refs/heads/main/Brookhaven",
    ["SP Hub"] = "https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/Brookhaven",
    ["Dragon Hub"] = "https://raw.githubusercontent.com/paoplays958-coder/update/refs/heads/main/update",
    ["SanderXHub"] = "https://raw.githubusercontent.com/kigredns/testUIDK/refs/heads/main/panel.lua",
    ["Soluna Hub"] = "https://raw.githubusercontent.com/Patheticcs/Soluna-API/refs/heads/main/brookhaven.lua"
})

-- ==============================
-- MURDER MYSTERY TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Murder Mystery", {
    ["Script MM2"] = "https://raw.githubusercontent.com/gumanba/Scripts/main/mm2",
    ["Rufu MM2"] = "https://raw.githubusercontent.com/lechayy/RufuMM2/refs/heads/main/MM2.lua",
    ["Vertex"] = "https://raw.smokingscripts.org/vertex.lua",
    ["MR HUB"] = "https://raw.githubusercontent.com/MineRoma/MRHUBNEW_UNI/refs/heads/main/mm2",
    ["RAGE HUB"] = "https://pastebin.com/raw/rGHBMagb",
    ["Delta Script"] = "https://api.jnkie.com/api/v1/luascripts/public/8bc8ff54fc50fdd015c4c74509e41dd981e6a4e41062cd2d6bd50d817ccf6182/download",
    ["AYZEN HUB"] = "https://raw.githubusercontent.com/ayzen-mm2/Loader/refs/heads/main/MM2.LUA",
    ["SP HUB"] = "https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/Loader",
    ["AvoEZ Hub"] = "https://raw.githubusercontent.com/AvoEZScripts/Murder-Mystery-2/refs/heads/main/AvoEZ%20Hub",
    ["HARUNZ Hub"] = "https://gist.githubusercontent.com/harunzyofficial-a11y/70f3b89497c2aca7bc096e00f3a0c551/raw/22b67aa4b96a05eaa32102574d1ea1eff577c0b6/gistfile1.txt"
})

-- ==============================
-- RIVALS TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Rivals", {
    ["Averlik Hub"] = "https://raw.githubusercontent.com/Tarmaster/AverlikHub/refs/heads/main/Loader",
    ["Sportsclub"] = "https://scripts.getv3.lol/sportsclub.luau",
    ["Elite Zone Hub"] = "https://ez-ez.vercel.app/loader.lua",
    ["Flow Hub"] = "https://api.luarmor.net/files/v4/loaders/5946add9ab91f1e04cb005346a8b1968.lua",
    ["Ather Hub"] = "https://api.luarmor.net/files/v3/loaders/2529a5f9dfddd5523ca4e22f21cceffa.lua",
    ["JN HH Gaming"] = "https://raw.githubusercontent.com/JNHHGaming/Rivals-Script/refs/heads/main/JN%20HH%20Gaming",
    ["Saint Hub"] = "https://raw.githubusercontent.com/tokyotokyo-dev/rivals/refs/heads/main/rivalsaimwh.lua",
    ["Kovari Hub"] = "https://scawshub.vercel.app/kovari",
    ["Lumin Hub"] = "http://luminon.top/loader.lua",
    ["Vylera Hub"] = "https://raw.githubusercontent.com/vylerascripts/vylera-scripts/main/vylerarivals.lua"
})

-- ==============================
-- FISH IT TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Fish It", {
    ["Arvyn Hub"] = "https://api.arvynscripts.cloud/api/files/loader.lua",
    ["NiCH Hub"] = "https://lua.cloudlabx.online/scripts/103.NiCH",
    ["Meng Hub"] = "https://menghub.dannnnbiasalah.workers.dev/",
    ["Aether Hub"] = "https://raw.githubusercontent.com/DuxiiT/Aether/refs/heads/main/loader.lua",
    ["Moon Hub"] = "https://api.luarmor.net/files/v3/loaders/d6eded51e52af6e97e3ee10fd4843043.lua",
    ["Nine Hub"] = "https://api.luarmor.net/files/v3/loaders/fab50a9d841123a1891cd0f05fd0e698.lua",
    ["LS Hub"] = "https://raw.githubusercontent.com/Louissyahpt/FishIt/refs/heads/main/LSxMyowHub",
    ["Trash Hub"] = "https://trashloader.pages.dev/update.lua",
    ["PepeHook Hub"] = "https://raw.githubusercontent.com/GiftStein1/pepehook-loader/refs/heads/main/loader.lua",
    ["SolvexGUI"] = "https://raw.githubusercontent.com/Solvexxxx/Scripts/refs/heads/main/SolvexGUI_FishIt.lua"
})

-- ==============================
-- 99 NIGHTS IN THE FOREST TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("99 In The Forest", {
    ["Rift Hub"] = "https://rifton.top/loader.lua",
    ["Cobra Hub"] = "https://api.luarmor.net/files/v3/loaders/705e9a93cc18214fb77ab95686a8dba9.lua",
    ["StreeHub"] = "https://raw.githubusercontent.com/create-stree/STREE-HUB/refs/heads/main/Loader/Main.lua",
    ["BronxWare"] = "https://raw.githubusercontent.com/scriptsomega/99nightforforest/refs/heads/main/BronxWare",
    ["Gec Hub"] = "https://raw.githubusercontent.com/GEC0/gec/refs/heads/main/Gec.Loader",
    ["Nova Hub"] = "https://raw.githubusercontent.com/M4rshmall0ow-dev/Nova/refs/heads/main/Script%20Loader%20Main",
    ["H4x Scripts"] = "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader2.lua",
    ["Cps Natural"] = "https://raw.githubusercontent.com/Rx1m/CpsHub/refs/heads/main/Hub",
    ["VoidWare"] = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua",
    ["Foxname Hub"] = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"
})

-- ==============================
-- STEAL A BRAINROT TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Steal A Brainrot", {
    ["Fire Hub"] = "https://api.luarmor.net/files/v4/loaders/d57c849fd53c7b874a9b48c5ed238fb9.lua",
    ["Raiden Hub"] = "https://pastebin.com/raw/vkvzPBgi",
    ["SAB Collection"] = "https://raw.githubusercontent.com/UniversalScriptHub/SAB-Keyless-OP-Script/refs/heads/main/All-SAB-Script.Loader",
    ["Ajjans Hub"] = "https://api.luarmor.net/files/v3/loaders/469095d9d52d9e123298c64aeb62005f.lua",
    ["Hulk Hub"] = "https://raw.githubusercontent.com/panelhenil-oss/HULK/refs/heads/main/HULK.txt",
    ["Ajjans Duels"] = "https://api.luarmor.net/files/v4/loaders/e8c2b7bdfd494b913839f58581a203f9.lua",
    ["Kurd Hub"] = "https://raw.githubusercontent.com/dontasklol/Stealingurbrainrots/refs/heads/main/Kurd%20hub",
    ["Chilli Hub"] = "https://pastefy.app/3P0o3D66/raw",
    ["Moon Hub"] = "https://pastebin.com/raw/JPQa3tza",
    ["ReyHub"] = "https://raw.githubusercontent.com/javi-esp/Rey/main/sab.lua"
})

-- ==============================
-- FICH PET SIMULATOR TAB
-- ==============================
MakeTab("Fich Pet Simulator", {
    ["Ouroboros Hub"] = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua",
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Nova Hub"] = "https://raw.githubusercontent.com/NovaHubRBLX/NovaHub/refs/heads/main/novahub.lua",
    ["Zeroin Hub"] = "https://zeroinhub.com/api/script",
    ["OMG Hub"] = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua",
    ["NEOX Hub"] = "https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader",
    ["BlyxoHub"] = "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua",
    ["Axon Hub"] = "https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"
})

-- ==============================
-- RIDE A PET TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Ride A Pet", {
    ["Ouroboros Hub"] = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua",
    ["Larp Hub"] = "https://pastebin.com/raw/aV60R9Vz",
    ["Vora Hub"] = "https://vora-hub-platform.vercel.app/loader.lua",
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Nova Hub"] = "https://raw.githubusercontent.com/NovaHubRBLX/NovaHub/refs/heads/main/novahub.lua",
    ["Zeroin Hub"] = "https://zeroinhub.com/api/script",
    ["OMG Hub"] = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"
})

-- ==============================
-- THE STRONGEST BATTLEGROUNDS TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("The Strongest Battlegrounds", {
    ["AutoBlock"] = "https://raw.githubusercontent.com/alanbeikers9/Script-ofuzcado/refs/heads/main/AutoBlock_v16_16%20ofuscado.lua",
    ["KittyWare"] = "https://raw.githubusercontent.com/0mam0ri/KittyWare/refs/heads/main/obf.lua",
    ["Terminator1"] = "https://api.jnkie.com/api/v1/luascripts/public/52276846a0d8e73f3208d9206b7be7c8ea031f62e5707d45d0ec9abfdca35467/download",
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Merebennie Hub"] = "https://api.getpolsec.com/scripts/hosted/2753546c83053761e44664d36ffe5035d6e20fc8aee1d19f0eb7b933974ae537.lua",
    ["Express Hub"] = "https://api.luarmor.net/files/v3/loaders/d8824b23a4d9f2e0d62b4e69397d206b.lua",
    ["JNHH Gaming"] = "https://raw.githubusercontent.com/JNHHGaming/The-strong-battlegrounds/refs/heads/main/Tsb",
    ["Forge Hub"] = "https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua",
    ["Star Hub"] = "https://api.luarmor.net/files/v3/loaders/bc25e1f8ef8aa59092de8f8f4c4fb95c.lua",
    ["Phantasm"] = "https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua"
})

-- ==============================
-- KARINDERYA TAB — REAL SCRIPTS ✅
-- ==============================
MakeTab("Karinderya", {
    ["Ouroboros Hub"] = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua",
    ["Nyxen Hub"] = "https://raw.githubusercontent.com/jsnyxen/nyxen-hub/main/loader.lua",
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Nova Hub"] = "https://raw.githubusercontent.com/NovaHubRBLX/NovaHub/refs/heads/main/novahub.lua",
    ["Zeroin Hub"] = "https://zeroinhub.com/api/script",
    ["OMG Hub"] = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua",
    ["BlyxoHub"] = "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua"
})

-- ==============================
-- OWN SCRIPT TAB — YOUR PERSONAL SCRIPTS
-- ==============================
local OwnTab = Window:Tab({ Title = "Own Script" })
OwnTab:Section({ Title = "My Own Scripts", Desc = "Your personal scripts", Box = true, BoxBorder = true })

OwnTab:Button({
    Title = "Roll Cases For Brainrot",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/-"))()
    end
})

OwnTab:Button({
    Title = "1+ Power Per Click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/%2C"))()
    end
})

OwnTab:Button({
    Title = "1+ Muscle Evolution",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/Lua"))()
    end
})

OwnTab:Button({
    Title = "1+ Sharp Per Click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHub/Elyxionhub/refs/heads/main/Loader."))()
    end
})

AddServerHop(OwnTab)

-- ======================================
-- FINISH
-- ======================================
call(Window, "SetToggleKey", Enum.KeyCode.RightShift)

WindUI:Notify({ Title = "elyxionHub", Content = "Loaded — Welcome "..LocalPlayer.Name, Duration = 4 })
print("elyxionHub Loaded Successfully — All Game Tabs Ready")
