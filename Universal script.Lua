local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Script Executor",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by Lava",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
   Name = "Execute (Old) Script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHub/Lava/refs/heads/main/obfuscated.lua%20(4).txt"))()
   end,
})

Tab:CreateButton({
   Name = "Execute (New) Update",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ElyxionHubScript/UniversalScript/refs/heads/main/obfuscated_script-1789699361831.lua.txt"))()
   end,
})
