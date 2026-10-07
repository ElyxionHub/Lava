_G.STARHUB_LIBRARY_ONLY = true
local StarHubUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/STARLARP/StarHub-UI/main/StarHubUI.lua"))()
_G.STARHUB_LIBRARY_ONLY = nil

local Window = StarHubUI:CreateWindow({
    Title = "Nyxus Hub",
    SubTitle = "Universal Script",
    Size = UDim2.new(0, 720, 0, 485),
    ToggleKey = Enum.KeyCode.RightControl,
    Logo = "rbxassetid://128334992222302"
})

-- Shared script loader (used by Blox Fruits + Steal an Egg tabs)
local function LoadScript(data)
    if data.Pre then pcall(loadstring(data.Pre)) end
    pcall(function() loadstring(game:HttpGet(data.Url))() end)
    StarHubUI:Notify({Title = "SCRIPT LOADED", Content = data.Name .. " is now running!", Duration = 3})
end

-- ============================================
-- HOME SECTION
-- ============================================
Window:AddNavHeader("HOME", 1)

local DashTab = Window:CreateTab({
    Title = "Dashboard",
    IconId = StarHubUI.Icons.Dashboard,
    BadgeText = "LIVE",
    LayoutOrder = 1
})

-- ---- Current Game Detection + Roblox Game Image (from old dashboard) ----
local placeName = "Roblox Experience"
local creatorName = "Roblox Studio"
local resolvedGameIcon = ""
pcall(function()
    local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    if info then
        if info.Name and info.Name ~= "" then placeName = info.Name end
        if info.Creator and info.Creator.Name and info.Creator.Name ~= "" then creatorName = info.Creator.Name end
        if info.IconImageAssetId and tonumber(info.IconImageAssetId) and tonumber(info.IconImageAssetId) > 0 then
            resolvedGameIcon = "rbxassetid://" .. tostring(info.IconImageAssetId)
        end
    end
end)
if resolvedGameIcon == "" then
    local universeId = (game.GameId and tonumber(game.GameId) and tonumber(game.GameId) > 0) and game.GameId or nil
    if universeId then
        resolvedGameIcon = "rbxthumb://type=GameIcon&id=" .. tostring(universeId) .. "&w=150&h=150"
    else
        resolvedGameIcon = "rbxthumb://type=Asset&id=" .. tostring(game.PlaceId) .. "&w=150&h=150"
    end
end

local GameCard = Instance.new("TextButton")
GameCard.Name = "CurrentGameCard"
GameCard.Parent = DashTab.TopContainer or DashTab.Page
GameCard.Size = UDim2.new(1, 0, 0, 92)
GameCard.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
GameCard.BackgroundTransparency = 0.15
GameCard.BorderSizePixel = 0
GameCard.AutoButtonColor = false
GameCard.Text = ""
GameCard.LayoutOrder = 1
local gcCorner = Instance.new("UICorner", GameCard); gcCorner.CornerRadius = UDim.new(0, 14)
local gcStroke = Instance.new("UIStroke", GameCard)
gcStroke.Color = Color3.fromRGB(65, 65, 78)
gcStroke.Thickness = 1
gcStroke.Transparency = 0.5

local GameThumb = Instance.new("ImageLabel", GameCard)
GameThumb.Size = UDim2.new(0, 64, 0, 64)
GameThumb.Position = UDim2.new(0, 14, 0.5, -32)
GameThumb.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
GameThumb.BackgroundTransparency = 0.2
GameThumb.ScaleType = Enum.ScaleType.Fit
GameThumb.Image = resolvedGameIcon
local gtCorner = Instance.new("UICorner", GameThumb); gtCorner.CornerRadius = UDim.new(0, 14)
local gtStroke = Instance.new("UIStroke", GameThumb)
gtStroke.Color = Color3.fromRGB(80, 80, 95)
gtStroke.Thickness = 1

task.spawn(function()
    pcall(function() game:GetService("ContentProvider"):PreloadAsync({GameThumb}) end)
end)

local GameTitle = Instance.new("TextLabel", GameCard)
GameTitle.Size = UDim2.new(1, -100, 0, 20)
GameTitle.Position = UDim2.new(0, 92, 0, 16)
GameTitle.BackgroundTransparency = 1
GameTitle.Font = Enum.Font.GothamBold
GameTitle.TextSize = 15
GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
GameTitle.TextXAlignment = Enum.TextXAlignment.Left
GameTitle.TextTruncate = Enum.TextTruncate.AtEnd
GameTitle.Text = placeName

local GameCreator = Instance.new("TextLabel", GameCard)
GameCreator.Size = UDim2.new(1, -100, 0, 16)
GameCreator.Position = UDim2.new(0, 92, 0, 40)
GameCreator.BackgroundTransparency = 1
GameCreator.Font = Enum.Font.GothamMedium
GameCreator.TextSize = 11
GameCreator.TextColor3 = Color3.fromRGB(180, 180, 195)
GameCreator.TextXAlignment = Enum.TextXAlignment.Left
GameCreator.TextTruncate = Enum.TextTruncate.AtEnd
GameCreator.Text = "by " .. creatorName

local GamePlace = Instance.new("TextLabel", GameCard)
GamePlace.Size = UDim2.new(1, -100, 0, 14)
GamePlace.Position = UDim2.new(0, 92, 0, 60)
GamePlace.BackgroundTransparency = 1
GamePlace.Font = Enum.Font.GothamMedium
GamePlace.TextSize = 10
GamePlace.TextColor3 = Color3.fromRGB(140, 140, 155)
GamePlace.TextXAlignment = Enum.TextXAlignment.Left
GamePlace.Text = "Place ID: " .. game.PlaceId .. "  |  Click card to copy game link"

GameCard.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://www.roblox.com/games/" .. game.PlaceId) end)
    StarHubUI:Notify({Title = "COPIED", Content = "Game link copied!", Duration = 3})
end)

-- Dashboard: ONLY Profile + Welcome (everything else removed)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ---- Live date / time / greetings ----
local NowTbl = os.date("*t")
local DayNames = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
local TodayName = DayNames[NowTbl.wday]
local TimeStr = os.date("%I:%M:%S %p")
local DateStr = os.date("%B %d, %Y")

local WeekendGreeting
if NowTbl.wday == 7 then
    WeekendGreeting = "Happy Saturday!"
elseif NowTbl.wday == 1 then
    WeekendGreeting = "Happy Sunday!"
else
    WeekendGreeting = "Happy " .. TodayName .. "!"
end

local function DaysUntilXmas()
    local cur = os.time()
    local yr = NowTbl.year
    local xmas = os.time({year = yr, month = 12, day = 25, hour = 0, min = 0, sec = 0})
    if cur > xmas then xmas = os.time({year = yr + 1, month = 12, day = 25, hour = 0, min = 0, sec = 0}) end
    return math.ceil((xmas - cur) / 86400)
end
local XmasDays = DaysUntilXmas()
local XmasGreeting = (XmasDays <= 0) and "Merry Christmas!" or string.format("Happy Advance Christmas! (%d days left)", XmasDays)

-- ---- Profile details ----
local IsPremium = LocalPlayer.MembershipType ~= Enum.MembershipType.None
local JoinDate = os.date("%B %d, %Y", os.time() - (LocalPlayer.AccountAge * 86400))

local ProfileBox = DashTab:CreateGroupBox("Left", "PROFILE", "USER", StarHubUI.Icons.Dashboard)
ProfileBox:AddActionRow("Display Name: " .. LocalPlayer.DisplayName, "Click to copy display name", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard(LocalPlayer.DisplayName) end)
    StarHubUI:Notify({Title = "COPIED", Content = "Display name copied!", Duration = 3})
end)
ProfileBox:AddActionRow("Username: @" .. LocalPlayer.Name, "Click to copy username", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard(LocalPlayer.Name) end)
    StarHubUI:Notify({Title = "COPIED", Content = "Username copied!", Duration = 3})
end)
ProfileBox:AddActionRow("User ID: " .. LocalPlayer.UserId, "Click to copy User ID", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard(tostring(LocalPlayer.UserId)) end)
    StarHubUI:Notify({Title = "COPIED", Content = "User ID copied!", Duration = 3})
end)
ProfileBox:AddActionRow("Premium: " .. (IsPremium and "Yes" or "No"), "Roblox Premium membership status", StarHubUI.Icons.Dashboard, function() end)
ProfileBox:AddActionRow("Join Date: " .. JoinDate, "Approximate date account was created", StarHubUI.Icons.Dashboard, function() end)
ProfileBox:AddActionRow("Copy Profile Link", "Copy Roblox profile URL to clipboard", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard("https://www.roblox.com/users/" .. LocalPlayer.UserId .. "/profile") end)
    StarHubUI:Notify({Title = "COPIED", Content = "Profile link copied!", Duration = 3})
end)

local WelcomeBox = DashTab:CreateGroupBox("Right", "WELCOME", "NYXUS", StarHubUI.Icons.Dashboard)
WelcomeBox:AddActionRow("Welcome to Nyxus Hub!", "Universal Script Hub", StarHubUI.Icons.Dashboard, function() end)
WelcomeBox:AddActionRow("100+ Scripts Loaded", "Blox Fruits | Steal an Egg | Misc", StarHubUI.Icons.Dashboard, function() end)
WelcomeBox:AddActionRow("Toggle Key: RightControl", "Press to show / hide the UI", StarHubUI.Icons.Dashboard, function() end)
WelcomeBox:AddActionRow("Current Time: " .. TimeStr, "Click to refresh & copy current time", StarHubUI.Icons.Copy, function()
    local t = os.date("%I:%M:%S %p")
    pcall(function() setclipboard(t) end)
    StarHubUI:Notify({Title = "TIME", Content = "Current time: " .. t, Duration = 3})
end)
WelcomeBox:AddActionRow("Today: " .. TodayName .. ", " .. DateStr, "Current day and date", StarHubUI.Icons.Dashboard, function() end)
WelcomeBox:AddActionRow(WeekendGreeting, "Enjoy your day!", StarHubUI.Icons.Dashboard, function() end)
WelcomeBox:AddActionRow(XmasGreeting, "Season's greetings from Nyxus Hub", StarHubUI.Icons.Dashboard, function() end)
WelcomeBox:AddActionRow("Copy Discord Invite", "Click to copy our Discord link", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard("https://discord.gg/sXCqCgXWX") end)
    StarHubUI:Notify({Title = "COPIED", Content = "Discord invite copied!", Duration = 3})
end)

-- ============================================
-- MODULES SECTION
-- ============================================
Window:AddNavHeader("MODULES", 2)

-- Blox Fruits
local BloxFruitsTab = Window:CreateTab({
    Title = "Blox Fruits",
    IconId = StarHubUI.Icons.Combat,
    LayoutOrder = 2
})

-- Blox Fruits scripts sourced from deltaexecutors.net & blox-fruitscripts.com
local BloxScripts = {
    {Name = "Redz Hub (New)",       Url = "https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau", Desc = "Anti Ban | Auto Raid | Auto Farm", Key = false, Pre = 'getgenv().BETA_VERSION = true'},
    {Name = "HoHo Hub",             Url = "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI", Desc = "Auto Quest | Auto Fly | Zero Lag", Key = false},
    {Name = "Blue X Hub",           Url = "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua", Desc = "Auto Farm to Level 2800 | EXP Grind", Key = false},
    {Name = "Gravity Hub",          Url = "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua", Desc = "Sea 3 Optimized | Boss Kill | Auto Farm", Key = false},
    {Name = "Neru Hub",             Url = "https://raw.githubusercontent.com/NeroHubClub/AutoMythicFruitFinder/refs/heads/main/NeroHubFruitFinder", Desc = "Mythic Fruit Finder | Fruit Sniper", Key = false},
    {Name = "Leaf Hub",             Url = "https://leaf-zeta.onrender.com/api/script", Desc = "Mobile Optimized | Auto Farm | Lightweight", Key = false},
    {Name = "Maru Hub",             Url = "https://raw.githubusercontent.com/LuaCrack/KimP/refs/heads/main/MaruHub", Desc = "Marines Team Auto Farm", Key = false, Pre = 'getgenv().Team = "Marines"'},
    {Name = "Astral Hub",           Url = "https://raw.githubusercontent.com/Vcsk/AstralHub/main/Main.lua", Desc = "Freeze Trade | Auto Accept Trade | Anti Scam", Key = false},
    {Name = "Speed Hub X",          Url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", Desc = "ESP | Speed Hack | PvP Focused", Key = true},
    {Name = "Solara / Cokka Hub",   Url = "https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua", Desc = "Kill Aura | Boss Farm | Auto Collect", Key = false},
    {Name = "Night Hub",            Url = "https://raw.githubusercontent.com/NIGHTHUBONTOP/Main/main/NightHub.lua", Desc = "Fruit Rain Event | Auto Collect", Key = false},
    {Name = "Quantum Onyx Hub",     Url = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Desc = "Universal | All Servers | Auto Update", Key = false},
    {Name = "Than Hub",             Url = "https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1", Desc = "jjSploit Compatible | Free Executor", Key = false},
    {Name = "Bacon Hub",            Url = "https://raw.githubusercontent.com/BaconScriptHub/BaconHub/main/New-BaconHub.lua.txt", Desc = "Max Level Grind | Fruit Sniper | Auto Collect", Key = false},
    {Name = "Teddy Hub",            Url = "https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua", Desc = "Auto Kill | Instant Teleport | Auto Trade", Key = false},
    {Name = "Vxeze Hub",            Url = "https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain", Desc = "Auto Collect Fruits | Auto Accept Trade", Key = false},
    {Name = "Min Gaming Hub",       Url = "https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinXt2Eng", Desc = "Auto Farm | Full Feature Hub", Key = false},
    {Name = "BF New Version",       Url = "https://raw.githubusercontent.com/indexeduu/BF-NewVer/refs/heads/main/V3New.lua", Desc = "Latest Version | Auto Farm", Key = false},
    {Name = "Banana Cat Hub",       Url = "https://raw.githubusercontent.com/Nghia11n/Banana-Hub/main/bananahub.lua", Desc = "Auto Farm | Fast Attack | ESP | Quest", Key = false},
    {Name = "Neva Hub",             Url = "https://raw.githubusercontent.com/VEZ2/NEVAHUB/main/2", Desc = "Keyless Automation | Stable", Key = false},
    {Name = "Raito Hub",            Url = "https://raw.githubusercontent.com/Efe0626/RaitoHub/main/Script", Desc = "Delta Executor | PC + Android + iOS", Key = false},
    {Name = "Redz Hub (Legacy)",    Url = "https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua", Desc = "Auto Farm | Teleport | Boss Farm | ESP", Key = false},
    {Name = "KNCRYPT HUB V3",       Url = "https://raw.githubusercontent.com/3345-catsus/Kncrypt/refs/heads/main/sources/BloxFruit.lua", Desc = "Encrypted Hub | Auto Farm", Key = false},
    {Name = "Basement Hub",         Url = "https://raw.githubusercontent.com/Cazzanos/The-basement/main/Basement%20hub", Desc = "Auto Farm Script", Key = false},
    {Name = "Shadow Hub",           Url = "https://raw.githubusercontent.com/xPeachy/Shadow-Hub/main/Blox-Fruits", Desc = "Auto Farm | ESP | Teleport", Key = false},
    {Name = "Cat Core Hub",         Url = "https://raw.githubusercontent.com/KISOOUF/Cat-Core/main/Blox%20Fruits", Desc = "Full Automation Hub", Key = false},
    {Name = "Amanize Hub",          Url = "https://raw.githubusercontent.com/Kiriko-Protection/Scripts/main/Blox-Fruit-Bypass", Desc = "Bypass | Auto Farm", Key = false},
    {Name = "Void Hub",             Url = "https://raw.githubusercontent.com/VoidDeveloper67/Void-Hub/refs/heads/main/VoidHub.lua", Desc = "Auto Farm | Full Feature", Key = false},
    {Name = "NightMystic Hub",      Url = "https://raw.githubusercontent.com/Dev-NightMystic/Bloxfruits/refs/heads/main/Script.lua", Desc = "Marines Team | Auto Farm", Key = false, Pre = 'getgenv().team = "Marines"'},
    {Name = "KITE Hub",             Url = "https://raw.githubusercontent.com/GoblinKun009/Script/refs/heads/main/KiteLoader", Desc = "Auto Farm Hub", Key = false},
    {Name = "Xynapse Hub",          Url = "https://pastebin.com/raw/uECLqG3j", Desc = "Auto Farm | Pastebin Loader", Key = false},
    {Name = "TurboLite Hub",        Url = "https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/MainV2.lua", Desc = "Lightweight | Auto Farm", Key = false},
    {Name = "Solix Hub",            Url = "https://raw.githubusercontent.com/meobeo8/a/a/a", Desc = "Auto Farm Hub", Key = false},
    {Name = "Midnight Hub",         Url = "https://raw.githubusercontent.com/Ohofo2279/Midnight/refs/heads/main/MidnightX-BloxFruits.lua", Desc = "Pirates Team | Auto Everything", Key = false, Pre = 'getgenv().Team = "Pirates"'},
    {Name = "Monster Hub",          Url = "https://raw.githubusercontent.com/giahuy2511-coder/MonsterHub/refs/heads/main/MonsterHubEN", Desc = "Full Automation | English", Key = false},
    {Name = "Annie Hub",            Url = "https://raw.githubusercontent.com/Anniecreate86/BloxFruits/refs/heads/main/BetaHub-BF", Desc = "Beta Hub | Auto Farm", Key = false},
    {Name = "Dragon Hub",           Url = "https://raw.githubusercontent.com/dragonhubdev/dragonwitheveryone/refs/heads/main/Main-BF.lua", Desc = "Pirates Team | Full Hub", Key = false, Pre = 'getgenv().team = "Pirates"'},
    {Name = "MeoX Hub",             Url = "https://raw.githubusercontent.com/VanHoangIOS/MeoXHub/refs/heads/main/Main.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Zynex Hub",            Url = "https://raw.githubusercontent.com/Hirokai-Script-make/Zynexhubbloxfruit/refs/heads/main/ZynexHub-BloxFruit-redz.lua", Desc = "Redz-Based | Auto Farm", Key = false},
    {Name = "King Rua Hub",         Url = "https://raw.githubusercontent.com/shinichi-dz/phucshinyeuem/refs/heads/main/KingRuaHub.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Xeter Hub",            Url = "https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Apple Hub",            Url = "https://raw.githubusercontent.com/SuperIkka/Main/refs/heads/main/AppleHub", Desc = "Auto Farm Hub", Key = false},
    {Name = "Cookie Hub",           Url = "https://raw.githubusercontent.com/Jadelly261/BloxFruits/refs/heads/main/Cookie", Desc = "Auto Farm Hub", Key = false},
    {Name = "Zyn Hub",              Url = "https://raw.githubusercontent.com/GoblinKun009/Script/refs/heads/main/ZynHub", Desc = "Auto Farm Hub", Key = false},
    {Name = "Vector Hub",           Url = "https://raw.githubusercontent.com/AAwful/Vector_Hub/0/v2", Desc = "Auto Farm Hub", Key = false},
    {Name = "Foggy Hub",            Url = "https://raw.githubusercontent.com/FOGOTY/foggy-bloxfruit/refs/heads/main/script", Desc = "Auto Farm Hub", Key = false},
    {Name = "DatThg Hub",           Url = "https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV2", Desc = "Auto Farm Hub", Key = false},
    {Name = "Aurora Hub",           Url = "https://raw.githubusercontent.com/Jadelly261/BloxFruits/main/Aurora", Desc = "Auto Farm Hub", Key = false},
    {Name = "NatHub",               Url = "https://raw.githubusercontent.com/ArdyBotzz/NatHub/refs/heads/master/bf.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "RoHub",                Url = "https://raw.githubusercontent.com/RO-HUB-CODEX/RO-HUB/refs/heads/main/bloxfruits.lua", Desc = "Pirates Team | Configurable", Key = false, Pre = '_G.settings = {autoLoadConfig = false, joinTeam = "Pirates"}'},
    {Name = "Quartyz Hub",          Url = "https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua", Desc = "OneClick Mode | Auto Farm", Key = false, Pre = 'getgenv().Mode = "OneClick"'},
    {Name = "Zinner Hub",           Url = "https://raw.githubusercontent.com/HoangNguyenk8/Scripts/refs/heads/main/Loader.lua", Desc = "Pirates Team | Auto Farm", Key = false, Pre = 'getgenv().Team = "Pirates"'},
    {Name = "Forge Hub",            Url = "https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Onyx F",               Url = "https://raw.githubusercontent.com/zenzon23/new-bf/refs/heads/main/onyx%20f", Desc = "Auto Farm Hub", Key = false},
    {Name = "Lap Hub",              Url = "https://raw.githubusercontent.com/Jadelly261/BloxFruits/refs/heads/main/LapHub", Desc = "Auto Farm Hub", Key = false},
    {Name = "Master Hub",           Url = "https://raw.githubusercontent.com/onepicesenpai/onepicesenpai/main/onichanokaka", Desc = "Auto Farm Hub", Key = false},
    {Name = "Strawberry Hub",       Url = "https://raw.githubusercontent.com/CheemsNhuChiAl/Sotringhuhu/main/StrawberryHubBeta1.35", Desc = "Beta Hub | Auto Farm", Key = false},
    {Name = "Rise Hub",             Url = "https://raw.githubusercontent.com/TrashLua/BloxFruits/main/FreeScripts.lua", Desc = "Free Scripts Pack", Key = false},
    {Name = "Experience Hub",       Url = "https://raw.githubusercontent.com/Memories0912/Experience-Script/main/Gen2Beta.lua", Desc = "Gen2 Beta | Auto Farm", Key = false},
    {Name = "Kaitun Script",        Url = "https://raw.githubusercontent.com/memaybeohub/NewPage/main/Kaitun.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Xero Hub",             Url = "https://raw.githubusercontent.com/verudous/Xero-Hub/main/main.lua", Desc = "Marines Team | Fix Lag | Auto Farm", Key = false, Pre = 'getgenv().Team = "Marines" getgenv().Fix_Lag = true getgenv().Auto_Execute = false'},
    {Name = "Infinite Hub",         Url = "https://raw.githubusercontent.com/Baokhanh208/Infinite/main/filesrc.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Spectrum Hub",         Url = "https://raw.githubusercontent.com/xZPUHigh/Project-Spectrum/main/SpectrumX.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Dominance Hub",        Url = "https://raw.githubusercontent.com/Script-Blox/Script/main/Dominance", Desc = "Auto Farm Hub", Key = false},
    {Name = "MTriet Hub",           Url = "https://raw.githubusercontent.com/Minhtriettt/Free-Script/main/MTriet-Hub.lua", Desc = "Free Script | Auto Farm", Key = false},
    {Name = "Chest Farm Script",    Url = "https://raw.githubusercontent.com/Unknownproootest/Bloxfruit-speedboat/main/ChestFarm", Desc = "Auto Chest Farm | Speedboat", Key = false},
    {Name = "Azure WScript",        Url = "https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua", Desc = "Premium | Farming + Combat + Teleport", Key = true},
    {Name = "Flow Hub",             Url = "https://api.luarmor.net/files/v4/loaders/5946add9ab91f1e04cb005346a8b1968.lua", Desc = "Premium | Auto Hatch | Fly", Key = true},
    {Name = "Novus Hub",            Url = "https://api.luarmor.net/files/v3/loaders/14f9e9054b916dc305c310f9549a5272.lua", Desc = "Premium Hub", Key = true},
    {Name = "Ather Hub",            Url = "https://api.luarmor.net/files/v4/loaders/2529a5f9dfddd5523ca4e22f21cceffa.lua", Desc = "Premium Hub", Key = true},
    {Name = "Ronix Hub",            Url = "https://api.luarmor.net/files/v3/loaders/b5f968ca22436160479678e830766cc4.lua", Desc = "Premium | Stable Long Sessions", Key = true},
    {Name = "Zee Hub (VIP)",        Url = "https://link.trwxz.com/LS-Zee-Hub-VIP", Desc = "VIP Hub", Key = true},
    {Name = "NazuX Hub",            Url = "https://raw.githubusercontent.com/NguyenAnhKhoaX/Anhkhoa2279/refs/heads/main/BloxFruits.lua", Desc = "Requires Key | Auto Farm", Key = true, Pre = 'script_key = "PUT YOUR KEY HERE"'},
    {Name = "VEX Hub",              Url = "https://raw.githubusercontent.com/yoursvexyyy/VEX/refs/heads/main/bloxfruits%20cash%20farm%20premium", Desc = "Premium | Cash Farm", Key = true},
    {Name = "Mukuro Hub",           Url = "https://auth.quartyz.com/scripts/Loader.lua", Desc = "Premium | Quests + Bosses + Fruits", Key = true},
    {Name = "Lumin Hub",            Url = "http://lumin-hub.lol/BloxFruits.lua", Desc = "Premium | Full Feature Hub", Key = true},
    {Name = "OMG Hub",              Url = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua", Desc = "Premium | Instant Steal | God Mode", Key = true},
    {Name = "Infinite Yield",       Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", Desc = "Admin Commands | Server Hop", Key = false},
}

local BloxPerBox = 8
local BloxGroupNames = {"TOP HUBS", "KEYLESS HUBS", "POPULAR HUBS", "MORE HUBS", "ALL SCRIPTS", "EXTRA SCRIPTS", "BONUS", "PREMIUM HUBS", "FINAL"}
for i = 1, #BloxScripts, BloxPerBox do
    local side = (math.floor((i-1)/BloxPerBox) % 2 == 0) and "Left" or "Right"
    local gName = BloxGroupNames[math.floor((i-1)/BloxPerBox) + 1] or "SCRIPTS"
    local badge = (i == 1) and "HOT" or nil
    local box = BloxFruitsTab:CreateGroupBox(side, gName, badge, StarHubUI.Icons.Combat)
    for j = i, math.min(i + BloxPerBox - 1, #BloxScripts) do
        local s = BloxScripts[j]
        box:AddActionRow(s.Name .. (s.Key and "  [KEY]" or "  [NO KEY]"), s.Desc, StarHubUI.Icons.Combat, function() LoadScript(s) end)
    end
end

-- Steal an Egg
local EggTab = Window:CreateTab({
    Title = "Steal an Egg",
    IconId = StarHubUI.Icons.Zap,
    BadgeText = "50+",
    LayoutOrder = 3
})

local Scripts = {
    {Name = "Ouroboros Hub",       Url = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua", Desc = "Auto Steal | Server Hop | Rarity Filter", Key = false},
    {Name = "Zeroin Hub",          Url = "https://zeroinhub.com/api/script", Desc = "Auto Steal | Steal By Value | Auto Treadmill", Key = false},
    {Name = "Foxname Hub",         Url = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua", Desc = "Auto Steal | God Mode | Auto Upgrade Base", Key = false},
    {Name = "Oxide Hub",           Url = "https://pastefy.app/aIzaPmW9/raw", Desc = "Auto Farm | Instant Steal | Godmode", Key = false},
    {Name = "Valinc Hub",          Url = "https://api.valincsyndicate.com/v1/releases/5502cba03703f4a3628d522d396b80d8.lua", Desc = "Full Automation Hub", Key = false},
    {Name = "UB Hub",              Url = "https://raw.githubusercontent.com/TeamUBHub/UBLoader/refs/heads/main/Loader.lua", Desc = "Auto Steal | Pet Predictor | Auto Hatch", Key = false},
    {Name = "Zero Point Hub",      Url = "https://raw.githubusercontent.com/JaxRol/ZeroPoint/refs/heads/main/KeySystem", Desc = "Auto Steal | Instant Steal | Anti Hit", Key = false},
    {Name = "Blyxo Hub",           Url = "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua", Desc = "Instant Steal | Steal Everything | Auto Event", Key = false},
    {Name = "BK Hub",              Url = "https://api.luarmor.net/files/v4/loaders/9ee4edde227ac85f50872bf9e4226508.lua", Desc = "Auto Farm Hub", Key = false},
    {Name = "Neva Hub",            Url = "https://raw.githubusercontent.com/VEZ2/NEVAHUB/main/2", Desc = "Keyless Automation", Key = false},
    {Name = "Clout Hub",           Url = "https://raw.githubusercontent.com/ClouthubOnTop/Loader/main/main.lua", Desc = "Keyless | Auto Steal", Key = false},
    {Name = "Limbo Hub (Kaitun)",  Url = "https://limbohub.my.id/hub/kaitunsae.lua", Desc = "Full Config | Auto Everything", Key = false},
    {Name = "Cyrus Hub",           Url = "https://raw.githubusercontent.com/CyrusOffc/scriptcyrus/refs/heads/main/loader", Desc = "Keyless Hub", Key = false},
    {Name = "Sena Hub",            Url = "https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/loader", Desc = "Egg Filter | Botting Mode | Rift Auto Reroll", Key = false},
    {Name = "BigFroot Hub",        Url = "https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua", Desc = "Auto Hatch | Auto Return | Anti-Ban", Key = true},
    {Name = "Speed Hub X",         Url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", Desc = "Auto Farming | High Speed", Key = true},
    {Name = "Nasi Rendang Hub",    Url = "https://raw.githubusercontent.com/JualNasiRendang/loader/refs/heads/main/main.lua", Desc = "Auto Upgrade Base", Key = true},
    {Name = "Lumin Hub",           Url = "http://luminon.top/loader.lua", Desc = "Full Feature Hub", Key = true},
    {Name = "Airflow Hub",         Url = "https://airflowscript.com/loader", Desc = "Mobile/PC | Auto Steal", Key = true},
    {Name = "Yuri Hub",            Url = "https://raw.githubusercontent.com/iLove-yuri/leeeeesbian/refs/heads/main/homumado.lua", Desc = "Auto Farm Hub", Key = true, Pre = "_G.autoExec = false"},
    {Name = "Saiops Hub",          Url = "https://api.saiops.cc/scripts/Steal-An-Egg-Script.lua", Desc = "Premium Automation", Key = true},
    {Name = "Vantage Hub",         Url = "https://raw.githubusercontent.com/MisterNovitski/Vantage/refs/heads/main/mm2.txt", Desc = "Auto Steal Hub", Key = true},
    {Name = "Nova Hub",            Url = "https://raw.githubusercontent.com/NovaHubRBLX/NovaHub/refs/heads/main/novahub.lua", Desc = "Full Automation", Key = true},
    {Name = "Ajjans Hub",          Url = "https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua", Desc = "Inf Speed | Auto Steal", Key = true},
    {Name = "Nemesis Hub",         Url = "https://raw.githubusercontent.com/x2zu/loader/main/freeloader.lua", Desc = "Free Loader Hub", Key = true},
    {Name = "Solix Hub",           Url = "https://raw.githubusercontent.com/bao8jl/solixhub/main/loader", Desc = "Walkspeed | Auto Steal | Auto Place", Key = true},
    {Name = "Hoshi Hub",           Url = "https://hoshihub.site/loader.lua", Desc = "Premium Script Hub", Key = true},
    {Name = "Axon Hub",            Url = "https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua", Desc = "Fast Instant Steal | Auto Farm | God Mode", Key = true},
    {Name = "Flow Hub",            Url = "https://api.luarmor.net/files/v4/loaders/5946add9ab91f1e04cb005346a8b1968.lua", Desc = "Auto Hatch | Auto Place | Fly", Key = true},
    {Name = "Rift Hub",            Url = "https://rifton.top/loader.lua", Desc = "Titan Temple Eggs | Instant Steal", Key = true},
    {Name = "Kexxe Hub",           Url = "https://raw.githubusercontent.com/premiumbuddy/kex/refs/heads/main/kexxxx", Desc = "Auto Steal | Auto Hatch | Auto Upgrade Pets", Key = true},
    {Name = "Vxeze Hub",           Url = "https://vxezestudio.online/api/scripts/script_G5CGjqj2X3rOS/stream/init", Desc = "Premium Hub", Key = true},
    {Name = "Snowy Hub",           Url = "https://flowauth.net/v1/ui/a87f00d9adf63658655fcd02ab86a4ef.lua", Desc = "Auto Farm Hub", Key = true},
    {Name = "OMG Hub",             Url = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua", Desc = "Instant Steal | God Mode", Key = true},
    {Name = "Asvra Hub",           Url = "https://raw.githubusercontent.com/asvraRoblox/stealegg/refs/heads/main/main", Desc = "Auto Steal Hub", Key = true},
    {Name = "Zero Hub",            Url = "https://www.zeroimpact.online/raw/loader", Desc = "Automation Hub", Key = true},
    {Name = "Miranda Hub",         Url = "https://api.jnkie.com/api/v1/luascripts/public/f56794e06dcfb4adad5dc739dff503f38ca8f7cc94e045eafe823a3c5f09c4cc/download", Desc = "Instant Steal | Show Egg Data", Key = true},
    {Name = "Probest Hub",         Url = "https://api.jnkie.com/api/v1/luascripts/public/0199b576f5c2d5a34159f0f9f4e1de0a566b4d1da5b1cfa5d2f71ade9bdcaa24/download", Desc = "Premium Hub", Key = true},
    {Name = "GS Hub",              Url = "https://gist.githubusercontent.com/spiritualgaming1123-beep/46ef55c5f8284e076aafc5ebd12233f4/raw/5b24749c3931c1838a76e64c9af508dcdd03700a/gistfile1.lua", Desc = "Auto Farm Hub", Key = true},
    {Name = "SportsClub Hub",      Url = "https://loader.sportsclub.fun/loader.luau", Desc = "Premium Loader", Key = true},
    {Name = "ScriptVerse Hub",     Url = "https://scriptversekey.xyz/s/steal-an-egg", Desc = "Auto Steal | Max Speed", Key = true},
    {Name = "ZK Hub",              Url = "https://zkcommunity.cloud/loader.lua", Desc = "Community Hub", Key = true, Pre = '_G.Config = {ApiKey = "ZKCOMMUNITYcfdb742a751aad57d79b375ea6c7cbc7"}'},
    {Name = "Axonic Hub",          Url = "https://raw.githubusercontent.com/Kenniel123/Steal-A-Egg/refs/heads/main/Steal%20A%20Egg", Desc = "Auto Steal Hub", Key = true},
    {Name = "Pig Hub",             Url = "https://raw.githubusercontent.com/mopsscript7-gif/steal-an-egg/refs/heads/main/script.lua", Desc = "Instant Steal | Auto Bloom Event", Key = true},
    {Name = "Neox Hub",            Url = "https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", Desc = "Premium Hub", Key = true},
    {Name = "Clover Hub",          Url = "https://raw.githubusercontent.com/Ryuun0x/Clover/refs/heads/main/main.lua", Desc = "Steal All Areas | Auto Event | Rarity Filter", Key = true},
    {Name = "FYY Hub",             Url = "https://fyycommunity.com/", Desc = "Community Hub", Key = true},
    {Name = "Lennon Hub",          Url = "https://api.jnkie.com/api/v1/luascripts/public/bf52181bce5c28e6ecd16eebfa1a88ddaf646c7acb10015fbaa7b30dc7bad0a8/download", Desc = "Auto Farm | Top Egg | Fast Steal", Key = true},
    {Name = "Sys Hub",             Url = "https://syshub.fun/free", Desc = "Free Hub", Key = true},
    {Name = "Chiyo Hub",           Url = "https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua", Desc = "Auto Steal Hub", Key = true},
    {Name = "Tsuo Hub",            Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/stealanegg", Desc = "Fast Instant Steal | Auto Farm | Angel & Demon Eggs", Key = true},
    {Name = "ToolBox Hub",         Url = "https://raw.githubusercontent.com/Abdullahking20/loader-lua/main/loader", Desc = "God Mode | Instant Steal | Auto Bloom", Key = true},
    {Name = "Mahindra Hub",        Url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaegg", Desc = "Instant Steal | Show Egg Data | Keyless", Key = true},
    {Name = "FynessedHub",         Url = "https://raw.githubusercontent.com/AhmadV6/StealAnEgg/refs/heads/main/FynessedHub", Desc = "Auto Steal | Auto Farm Eggs", Key = true},
    {Name = "Infinite Yield",      Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", Desc = "Admin Commands | Server Hop", Key = false},
    {Name = "Delta Script",        Url = "https://pastefy.app/iedWaiQX/raw", Desc = "Keyless | Auto Steal | 100% Working", Key = false},
    {Name = "Speed Hub (Alt)",     Url = "https://pastefy.app/kQ2m1nSa/raw", Desc = "Auto Farming | No Key", Key = false},
}

local PerBox = 8
local GroupNames = {"TOP HUBS", "KEYLESS HUBS", "POPULAR HUBS", "MORE HUBS", "ALL SCRIPTS", "EXTRA SCRIPTS", "BONUS"}
for i = 1, #Scripts, PerBox do
    local side = (math.floor((i-1)/PerBox) % 2 == 0) and "Left" or "Right"
    local gName = GroupNames[math.floor((i-1)/PerBox) + 1] or "SCRIPTS"
    local badge = (i == 1) and "HOT" or nil
    local box = EggTab:CreateGroupBox(side, gName, badge, StarHubUI.Icons.Zap)
    for j = i, math.min(i + PerBox - 1, #Scripts) do
        local s = Scripts[j]
        box:AddActionRow(s.Name .. (s.Key and "  [KEY]" or "  [NO KEY]"), s.Desc, StarHubUI.Icons.Zap, function() LoadScript(s) end)
    end
end

-- Ride A Pet
local RidePetTab = Window:CreateTab({
    Title = "Ride A Pet",
    IconId = StarHubUI.Icons.Zap,
    BadgeText = "15+",
    LayoutOrder = 4
})

local RidePetScripts = {
    {Name = "Ouroboros Hub",      Url = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua", Desc = "Auto Pickup | Auto Buy Food | Auto Place Eggs", Key = false},
    {Name = "Mario Hub",          Url = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua", Desc = "Auto Collect Eggs | Auto Hatch | Auto Collect Cash", Key = false},
    {Name = "Arc Hub (Oxide)",    Url = "https://raw.githubusercontent.com/xulfo/Oxide-Loader/main/Main.lua", Desc = "Auto Farm Eggs | Egg Loop | Pet Loop | Auto Plant", Key = false},
    {Name = "LuxuryXHub",         Url = "https://raw.githubusercontent.com/LostInSyntaxx/RideAPet/main/loader.lua", Desc = "Live Eggs Realtime | Instant TP", Key = false},
    {Name = "Hertz Hub",          Url = "https://raw.githubusercontent.com/Nueveee999/Rideapet/main/ride.lua", Desc = "Egg Glide | Live Egg | Teleports", Key = false},
    {Name = "Serenity Hub",       Url = "https://raw.githubusercontent.com/MUshihara/Serenity-hub/main/loader.lua", Desc = "Auto Steal Eggs | Keyless", Key = false},
    {Name = "Mystrix Hub",        Url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/loader", Desc = "Auto Farm Best Eggs | Auto Hatch | Auto Rebirth", Key = false},
    {Name = "Chilli Hub",         Url = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua", Desc = "Find Volcanic | Cherub | Solaris", Key = false},
    {Name = "LarpHub (Keyless)",  Url = "https://pastebin.com/raw/VPqrctbP", Desc = "Instant Blackhole Egg", Key = false},
    {Name = "Synerox Hub",        Url = "https://synex.lat/loaders/ride-a-pet.lua", Desc = "Instant Steal | Auto Farm | Auto Buy Luck", Key = false},
    {Name = "Akaz Hub",           Url = "https://akazhub.netlify.app/script.lua", Desc = "Auto Farm | Auto Place | Noclip During Fly", Key = false},
    {Name = "Blyxo Hub (Keyless)",Url = "https://flowauth.net/v1/loaders/1d8892dc79719bebaad7bac289e338c9.lua", Desc = "Instant Steal | Auto Hatch | God Mode", Key = false},
    {Name = "Nemo Hub",           Url = "https://raw.githubusercontent.com/NemoScripts/NemoHubGames/refs/heads/main/besthub", Desc = "Egg List Real Time | Highest Luck First", Key = false},
    {Name = "ThiAez Hub",         Url = "https://raw.githubusercontent.com/GZSSF/RideAPetV2/refs/heads/main/RideAPetV2", Desc = "Auto Best Egg | Egg ESP", Key = false},
    {Name = "Sapka Autofarm",     Url = "https://raw.githubusercontent.com/sapka342-sudo/sapka-rblx/refs/heads/main/ride-a-pet.luau", Desc = "Egg Autofarm | Keyless", Key = false},
    {Name = "Bac0nHck Hub",       Url = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/rideapet.lua", Desc = "Keyless Script", Key = false},
    {Name = "Thumbs Hub",         Url = "https://api.luarmor.net/files/v4/loaders/7a310d875453e7adb4fe6046e3ab0af9.lua", Desc = "Auto Farm Eggs | Teleport to Base | Egg ESP", Key = false},
    {Name = "CM Hub",             Url = "https://cmhub-key-system.vercel.app/roblox/loader.lua", Desc = "Instant Auto Steal | Auto Hatch | Auto Upgrade", Key = true},
    {Name = "Lennon Hub",         Url = "https://api.luarmor.net/files/v4/loaders/f560113c1b55b4e2b8143b9574ed0e97.lua", Desc = "Official Ride A Pet Hub", Key = true},
}

local RPPerBox = 8
local RPGroupNames = {"TOP HUBS", "KEYLESS HUBS", "MORE HUBS", "PREMIUM HUBS"}
for i = 1, #RidePetScripts, RPPerBox do
    local side = (math.floor((i-1)/RPPerBox) % 2 == 0) and "Left" or "Right"
    local gName = RPGroupNames[math.floor((i-1)/RPPerBox) + 1] or "SCRIPTS"
    local badge = (i == 1) and "HOT" or nil
    local box = RidePetTab:CreateGroupBox(side, gName, badge, StarHubUI.Icons.Zap)
    for j = i, math.min(i + RPPerBox - 1, #RidePetScripts) do
        local s = RidePetScripts[j]
        box:AddActionRow(s.Name .. (s.Key and "  [KEY]" or "  [NO KEY]"), s.Desc, StarHubUI.Icons.Zap, function() LoadScript(s) end)
    end
end

-- Misc Tab
local MiscTab = Window:CreateTab({
    Title = "Misc",
    IconId = StarHubUI.Icons.Settings,
    LayoutOrder = 5
})

local AntiAfkBox = MiscTab:CreateGroupBox("Left", "ANTI-AFK", "MODULE", StarHubUI.Icons.Zap)
local AntiAfkActive = false
AntiAfkBox:AddToggle("Enable Anti-AFK", "Prevents you from being kicked for inactivity", false, function(v)
    AntiAfkActive = v
    if v then
        task.spawn(function()
            while AntiAfkActive and task.wait(58) do
                local plr = game.Players.LocalPlayer
                if plr and plr.Character then
                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end
        end)
        StarHubUI:Notify({Title = "ANTI-AFK", Content = "Anti-AFK is now ACTIVE", Duration = 3})
    else
        StarHubUI:Notify({Title = "ANTI-AFK", Content = "Anti-AFK disabled", Duration = 3})
    end
end)
AntiAfkBox:AddToggle("Auto Reconnect", "Automatically rejoins if disconnected", false, function() end)

local UtilBox = MiscTab:CreateGroupBox("Right", "UTILITIES", "MODULE", StarHubUI.Icons.Settings)
UtilBox:AddActionRow("Copy Server Link", "Copies current server link to clipboard", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard("https://www.roblox.com/games/" .. game.PlaceId) end)
    StarHubUI:Notify({Title = "COPIED", Content = "Server link copied!", Duration = 3})
end)
UtilBox:AddActionRow("Rejoin Server", "Rejoins the current server", StarHubUI.Icons.Zap, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)
UtilBox:AddActionRow("Server Hop", "Hops to a new random server", StarHubUI.Icons.Zap, function()
    StarHubUI:Notify({Title = "SERVER HOP", Content = "Hopping to a new server...", Duration = 3})
end)

-- ============================================
-- SETTINGS SECTION
-- ============================================
Window:AddNavHeader("SETTINGS", 6)

-- Settings Tab
local SettingsTab = Window:CreateTab({
    Title = "Settings",
    IconId = StarHubUI.Icons.Settings,
    LayoutOrder = 8
})

local GenBox = SettingsTab:CreateGroupBox("Left", "GENERAL", "CONFIG", StarHubUI.Icons.Settings)
GenBox:AddToggle("Auto Load Config", "Automatically load saved settings", true, function() end)
GenBox:AddToggle("Notifications", "Show notification popups", true, function() end)
GenBox:AddToggle("Discord RPC", "Show game activity on Discord", false, function() end)
GenBox:AddToggle("Hide Watermark", "Hide the hub watermark", false, function() end)
GenBox:AddSlider("UI Scale", 50, 150, 100, function(v) end)

local KeyBox = SettingsTab:CreateGroupBox("Right", "HOTKEYS", "CONFIG", StarHubUI.Icons.Zap)
KeyBox:AddActionRow("Toggle UI Key: RightControl", "Click to change toggle keybind", StarHubUI.Icons.Zap, function()
    StarHubUI:Notify({Title = "HOTKEY", Content = "Press any key to set new toggle key", Duration = 3})
end)
KeyBox:AddActionRow("Reset All Settings", "Restore default configuration", StarHubUI.Icons.Zap, function()
    StarHubUI:Notify({Title = "SETTINGS", Content = "All settings reset to default", Duration = 3})
end)
KeyBox:AddActionRow("Unload Hub", "Completely remove Nyxus Hub", StarHubUI.Icons.Zap, function()
    StarHubUI:Notify({Title = "UNLOAD", Content = "Unloading Nyxus Hub...", Duration = 3})
    wait(1)
    pcall(function() Window:Destroy() end)
end)

StarHubUI:Notify({
    Title = "NYXUS HUB",
    Content = "Loaded! 80+ Blox Fruits | 50+ Egg | 15+ Ride A Pet scripts | Settings ready.",
    Duration = 4
})
