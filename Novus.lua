-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local novus = library.new("Novus Hub", 5013109572)

--require("try-catch")


-- themes
local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

-- ninja legends
if game.PlaceId == 3956818381 then
    local ninjaLegendsPage = novus:addPage("Ninja Legends", 5012544693)
    
    local nlAutoFarm = ninjaLegendsPage:addSection("Auto Farm")
   
    nlAutoFarm:addToggle("AutoSwing", false, function(nlAutoSwing)
        -- nl stands for Ninja Legends
        getgenv().autoswing = nlAutoSwing
        while true do
            if not getgenv().autoswing then return end
            for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:FindFirstChild("ninjitsuGain") then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    break
                end
            end
            local A_1 = "swingKatana"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1)
            wait()
        end
    end)

    nlAutoFarm:addToggle("AutoSell", false, function(nlAutoSell)
        getgenv().autosell = nlAutoSell
        while true do
            if getgenv().autosell == false then return end
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait(0.1)
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0)
            wait(0.1)
        end
    end)

    local nlAutoBuy = ninjaLegendsPage:addSection("Auto Buy")
    local bestIsland = "Blazing Vortex Island"

    nlAutoBuy:addToggle("Auto Buy Swords", false, function(nlAutoBuySwords)
        getgenv().buyswords = nlAutoBuySwords
        while true do
            if not getgenv().buyswords then return end
            local A_1 = "buyAllSwords"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, bestIsland)
            wait(0.5)
        end
    end)

    nlAutoBuy:addToggle("Auto Buy Belts", false, function(nlAutoBuyBelts)
        getgenv().buybelts = nlAutoBuyBelts
        while true do
            if not getgenv().buybelts then return end
            local A_1 = "buyAllBelts"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, bestIsland)
            wait(0.5)
        end
    end)

    nlAutoBuy:addToggle("Auto Buy Ranks", false, function(nlAutoBuyRanks)
        getgenv().buyrank = nlAutoBuyRanks
        while true do
            if not getgenv().buyrank then return end
            local A_1 = "buyRank"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1)
            wait(0.5)
        end
    end)
    
    local nlAutoHatch = ninjaLegendsPage:addSection("Auto Hatch")
    nlAutoHatch:addToggle("Auto Hatch Infinity Void Crystal", false, function(state)
        while true do
            if state == false then return end
            local openCrytalRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote")
            local autoEvolveRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("autoEvolveRemote")
            openCrystalRemote:InvokeServer("openCrystal", "Infinity Void Crystal")
            wait(0.2)
            remoteAutoEvolve:InvokeServer("autoEvolvePets")
            wait(0.2)
        end
    end)

    local nlMisc = ninjaLegendsPage:addSection("Misc")

    nlMisc:addButton("Unlock Islands", function()
        local oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        for _,v in pairs(game:GetService("Workspace").islandUnlockParts:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.1)
        end
        wait(0.1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
    end)  

    local chests =
    {"Mythical Chest", "Thunder Chest" , "Golden Chest", "Enchanted Chest", "Magma Chest","Legends Chest",
    "Eternal Chest", "Sahara Chest", "Ancient Chest","Midnight Shadow Chest",
    "Wonder Chest", "Ultra Ninjiutsu Chest", "Golden Zen Chest","Skystorm Masters Chest",
    "Chaos Legends Chest", "Soul Fusion Chest"}

    local chestRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("checkChestRemote")
    nlMisc:addButton("Collect all Chests", function()
        for i, v in pairs(chests) do
            chestRemote:InvokeServer(v)
            wait(3)
        end
    end)

    nlMisc:addButton("Collect Light Karma Chest", function()
        chestRemote:InvokeServer("Light Karma Chest")
    end)

    nlMisc:addButton("Collect Dark Karma Chest", function()
        chestRemote:InvokeServer("Evil Karma Chest")
        wait(3)
    end)
end

-- player page
local playerPage = novus:addPage("Player", 5012544693)

local movement = playerPage:addSection("Movement")

movement:addSlider("WalkSpeed", 16, 16, 500, function(ws)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
end)  

movement:addSlider("JumpPower", 50, 50, 500, function(jp)
    humanoid.JumpPower = jp
end)

movement:addToggle("Fly", function()
end)

movement:addToggle("NoClip")

local health = playerPage:addSection("Health")

health:addButton("Heal", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = game.Players.LocalPlayer.Character.Humanoid.MaxHealth
end)

local RunService = game:GetService("RunService")
local humanoid = game.Players.LocalPlayer.Character.Humanoid

health:addToggle("Godmode", false, function(v)
    if v then
        RunService.Heartbeat:Connect(function()
            humanoid.Health = humanoid.MaxHealth
        end)
    else
        RunService.Heartbeat:Disconnect()
    end
end)

-- extras page
local extra = novus:addPage("Extra", 5012544693)

local e_player = extra:addSection("Player")

e_player:addButton("AntiAFK", function()
    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do v:Disable() end
end)

-- settings page
local settings = novus:addPage("Settings", 5012544693)

local colors = settings:addSection("Colors")
local keybinds = settings:addSection("Keybinds")

for theme, color in pairs(themes) do -- all in one theme changer
	colors:addColorPicker(theme, color, function(color3)
		novus:setTheme(theme, color3)
	end)
end

keybinds:addKeybind("Toggle Keybind", Enum.KeyCode.PageDown, function()
	novus:toggle()
end, function()
end)

-- credits page
local credits = novus:addPage("Credits", 5012544693)
local developers = credits:addSection("Developers")

developers:addButton("Owner - kxzy#0001")
developers:addButton("Owner - HungrigesSchleim#0656")


local uilib = credits:addSection("UI Lib")


local button = uilib:addButton("Venyx UI Lib", function()
    novus:Notify("Copy",  "Cancel", function(v)
        if v then
            setclipboard("https://github.com/GreenDeno/Venyx-UI-Library")
        else
            return
        end
    end)
    return
end)

if game.PlaceId == 2809202155 then
    novus:addPage("YBA", 5012544693)
end

-- load
novus:SelectPage(novus.pages[1], true)