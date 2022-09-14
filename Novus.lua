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
   
    local ninjaEvent = game:GetService("Players").LocalPlayer.ninjaEvent
    nlAutoFarm:addToggle("AutoSwing", false, function(nlAutoSwing)
        local eventName = "swingKatana"
        -- nl stands for Ninja Legends
        getgenv().autoswing = nlAutoSwing
        while getgenv().autoswing do
            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:FindFirstChild("ninjitsuGain") then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    break
                end
            end
            ninjaEvent:FireServer(eventName)
            wait()
        end
    end)

    nlAutoFarm:addToggle("AutoSell", false, function(state)
        getgenv().autosell = state
        while getgenv().autosell do
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait(0.1)
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0)
            wait(0.1)
        end
    end)

    local nlAutoBuy = ninjaLegendsPage:addSection("Auto Buy")
    local bestIsland = "Blazing Vortex Island"

    nlAutoBuy:addToggle("Auto Buy Swords", false, function(state)
        local eventName = "buyAllSwords"
        getgenv().buyswords = state
        while getgenv().buyswords do
            ninjaEvent:FireServer(eventName, bestIsland)
            wait(0.5)
        end
    end)

    nlAutoBuy:addToggle("Auto Buy Belts", false, function(state)
        local eventName = "buyAllBelts"
        getgenv().buybelts = state
        while getgenv().buybelts do
            ninjaEvent:FireServer(eventName, bestIsland)
            wait(0.5)
        end
    end)

    nlAutoBuy:addToggle("Auto Buy Skills", false, function(state)
        getgenv().buyskills = state
        local eventName = "buyAllSkills"
        while getgenv().buyskills do
            ninjaEvent:FireServer(eventName, bestIsland)
            wait(0.5)
        end
    end)

    nlAutoBuy:addToggle("Auto Buy Ranks", false, function(state)
        ranks = game:GetService("ReplicatedStorage"):WaitForChild("Ranks"):WaitForChild("Ground"):GetChildren()
        local eventName = "buyRank"
        getgenv().buyrank = state
        while getgenv().buyrank do
            for i, rank in pairs(ranks) do
                ninjaEvent:FireServer(eventName, rank.Name)
                wait(0.2)
            end  
        end
    end)
    
    local nlAutoHatch = ninjaLegendsPage:addSection("Auto Hatch")
    
    nlAutoHatch:addToggle("Auto Hatch Infinity Void Crystal", false, function(state)
        local openCrystalRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote")
        local autoEvolveRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("autoEvolveRemote")
        getgenv().autohatch = state
        while getgenv().autohatch do
            openCrystalRemote:InvokeServer("openCrystal", "Infinity Void Crystal")
            wait(1.5)
            autoEvolveRemote:InvokeServer("autoEvolvePets")
            wait(1.5)
        end
    end)
    
    local nlTeleport = ninjaLegendsPage:addSection("Teleport")

    local Islands = {}
    for i,v in next, game.workspace.islandUnlockParts:GetChildren() do 
        if v then 
            table.insert(Islands, v.Name)
        end
    end
    
    nlTeleport:addDropdown("Select Island", Islands, function(island)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.islandUnlockParts[island].islandSignPart.CFrame
    end)


    local lightIslands =
    {["Mystical Waters"]={347.74, 8824.53, 114.27},
    ["Sword of Legends"]={1834.15, 38.70, -141.37},
    ["Elemental Tornado"]={299.75, 30383.09, -90.15},
    ["Zen Master's Blade"]={5044.94, 49.08, 1618.46}}

    local darkIslands =
    {["Lava Pit"]={-116.63, 12952.53, 271.14},
    ["Tornado"]={325.64, 16872.09, -9.99},
    ["Swords of Ancients"]={648.36, 38.70, 2409.72},
    ["Fallen Infinity Blade"]={1875.94, 39.43, -6805.74}}

    local lightIslandsNames = {}
    local darkIslandsNames = {}

    local function insertNames(fromTable, toTable)
        for name, _ in pairs(fromTable) do
            table.insert(toTable, name)
        end
    end

    insertNames(lightIslands, lightIslandsNames)
    insertNames(darkIslands, darkIslandsNames)

    x = nil
    y = nil 
    z = nil

    local function tpToKarmaIsland(fromTable, islandName)
        for name, table in pairs(fromTable) do
            if name == islandName then
                for _, coord in pairs(table) do
                    print("Entered for 2")
                    if x == nil then
                        x = coord
                    elseif x ~= nil and y == nil then
                        y = coord
                    else
                        z = coord
                    end
                end
            end
        end
    end

    nlTeleport:addDropdown("Select Light Karma Island", lightIslandsNames, function(islandName)
        tpToKarmaIsland(lightIslands, islandName)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y ,z)
        x = nil
        y = nil
        z = nil
    end)

    nlTeleport:addDropdown("Select Dark Karma Island", darkIslandsNames, function(islandName)
        tpToKarmaIsland(darkIslands, islandName)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y ,z)
        x = nil
        y = nil
        z = nil
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

-- prison life
if game.PlaceId == 155615604 then
    local prisonlifepage = novus:addPage("Prison Life", 5012544693)

    local plgivegun = prisonlifepage:addSection("Gun Giver")

    plgivegun:addDropdown("Select Gun to give yourself", {"M9", "Remington 870", "AK-47"}, function(v)
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver[v].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
    end)

    local plopgun = prisonlifepage:addSection("OP Gun")

    plopgun:addDropdown("Select Gun to make OP", {"M9", "Remington 870", "AK-47"}, function(v)
        local module = nil
        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v) then
            module = require(game:GetService("Players").LocalPlayer.Backpack[v].GunStates)
        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(v) then
            module = require(game:GetService("Players").LocalPlayer.Character[v].GunStates)
        end
        if module then
            module["MaxAmmo"] = math.huge
            module["CurrentAmmo"] = math.huge
            module["StoredAmmo"] = math.huge
            module["FireRate"] = 0.000001
            module["Spread"] = 0
            module["Range"] = math.huge
            module["Bullets"] = 10
            module["ReloadTime"] = 0.000001
            module["AutoFire"] = true
        end
    end)

    local plteleport = prisonlifepage:addSection("Teleport")

    plteleport:addButton("Cell Block", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.3862915039062, 99.98997497558594, 2439.28662109375)
    end)

    plteleport:addButton("Criminal Base", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-943.9027709960938, 94.1287612915039, 2056.36279296875)
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

e_player:addButton("Rejoin", function()
    local teleportService = game:GetService("TeleportService")
    local player = game:GetService("Players").LocalPlayer
    teleportService:Teleport(game.PlaceId, player)
end)

-- settings page
local settings = novus:addPage("Settings", 5012544693)

local colors = settings:addSection("Colors")
local keybinds = settings:addSection("Keybinds")
local more = settings:addSection("More")

for theme, color in pairs(themes) do -- all in one theme changer
	colors:addColorPicker(theme, color, function(color3)
		novus:setTheme(theme, color3)
	end)
end

keybinds:addKeybind("Toggle Keybind", Enum.KeyCode.PageDown, function()
	novus:toggle()
end, function()
end)

more:addButton("Close UI", function()
    game.CoreGui:WaitForChild("Novus Hub"):Remove()
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