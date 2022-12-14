-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local novus = library.new("Novus Hub", 5013109572)

local runService = game:GetService("RunService")
local character = game.Players.LocalPlayer.Character


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
        local ranks = game:GetService("ReplicatedStorage"):WaitForChild("Ranks"):WaitForChild("Ground"):GetChildren()
        local ownedRanks = game:GetService("Players").LocalPlayer:WaitForChild("ownedRanks"):GetChildren()
        local eventName = "buyRank"
        getgenv().buyrank = state
        while getgenv().buyrank do
            for _, rank in pairs(ranks) do
                for _, ownedRank in pairs(ownedRanks) do
                    if ownedRank.Name == rank.Name then break end
                end
                ninjaEvent:FireServer(eventName, rank.Name)
                wait(1)
            end  
        end
    end)


    local nlAutoBuyKarmaSkills = ninjaLegendsPage:addSection("Auto Buy Karma Skills")

    local function buyKarmaSkills(karmaSkills, ownedKarmaSkills, eventName)
        for _, karmaSkill in pairs(karmaSkills) do
            for _, ownedKarmaSkill in pairs(ownedKarmaSkills) do
                if ownedKarmaSkill.Name == karmaSkill.Name then break end
            end
            ninjaEvent:FireServer(eventName, karmaSkill.Name)
            wait(1.5)
        end
    end

    nlAutoBuyKarmaSkills:addToggle("Auto Buy Light Skills", false, function(state)
        local lightSkills = game:GetService("ReplicatedStorage"):WaitForChild("Light Skills"):WaitForChild("Ground"):GetChildren()
        local ownedLightSkills = game:GetService("Players").LocalPlayer:WaitForChild("ownedLightSkills"):GetChildren()
        local eventName = "buyLightSkill"
       
        getgenv().buylightskill = state
        while getgenv().buylightskill do
            buyKarmaSkills(lightSkills, ownedLightSkills, eventName)
        end
    end)

    nlAutoBuyKarmaSkills:addToggle("Auto Buy Dark Skills", false, function(state)
        local darkSkills = game:GetService("ReplicatedStorage"):WaitForChild("Dark Skills"):WaitForChild("Ground"):GetChildren()
        local ownedDarkSkills = game:GetService("Players").LocalPlayer:WaitForChild("ownedDarkSkills"):GetChildren()
        local eventName = "buyDarkSkill"
       
        getgenv().buydarkskill = state
        while getgenv().buydarkskill do
            buyKarmaSkills(darkSkills, ownedDarkSkills, eventName)
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
    local prisonLifePage = novus:addPage("Prison Life", 5012544693)

    local plGiveGun = prisonLifePage:addSection("Gun Giver")

    plGiveGun:addDropdown("Select Gun to give yourself", {"M9", "Remington 870", "AK-47"}, function(v)
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver[v].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
    end)

    local plOpGun = prisonLifePage:addSection("OP Gun")

    plOpGun:addDropdown("Select Gun to make OP", {"M9", "Remington 870", "AK-47"}, function(v)
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

    local plTeleport = prisonLifePage:addSection("Teleport")

    plTeleport:addButton("Cell Block", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.3862915039062, 99.98997497558594, 2439.28662109375)
    end)

    plTeleport:addButton("Criminal Base", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-943.9027709960938, 94.1287612915039, 2056.36279296875)
    end)
end

-- Slime Tower Tycoon
if game.PlaceId == 10675066724 then
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")

    local event = {
    Merge = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.MergeDroppers,
    Buy_Dropper = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuyDropper,
    Buy_Speed = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuySpeed,
    Deposit = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.DepositDrops,
}

    getgenv().Setting = {
    Grab_slime = false,
    Merge = false,
    Buy_Dropper = {boolean = false,unit = 1},
    Buy_Speed = false,
    Deposit = false,
}

    local slimetowertycoon = novus:addPage("Slime Tycoon", 5012544693)

    local sltAutomatics = slimetowertycoon:addSection("Automatics")

    sltAutomatics:addToggle("Auto Collect", false, function(x)
        getgenv().Setting.Grab_slime = x;
        if x then
            Grab_slime()
        end
    end)

    sltAutomatics:addToggle("Auto Sell", false, function(x)
        getgenv().Setting.Deposit = x;
        if x then
            Deposit()
        end
    end)

    sltAutomatics:addDropdown("Select Slime Unit", {"1", "5", "25", "50","100"}, function(x)
        getgenv().Setting.Buy_Dropper.unit = x;
    end)

    sltAutomatics:addToggle("Auto Buy Slime", false, function(x)
        getgenv().Setting.Buy_Dropper.boolean = x;
        if x then
            Buy_Dropper(getgenv().Setting.Buy_Dropper.unit)
        end
    end)

    sltAutomatics:addToggle("Auto Buy Rate", false, function(x)
        getgenv().Setting.Buy_Speed = x;
        if x then
            Buy_Speed()
        end
    end)

    sltAutomatics:addToggle("Auto Merge Slime", false, function(x)
        getgenv().Setting.Merge = x;
        if x then
            Merge()
        end
    end)

    sltAutomatics:addToggle("Auto Finish Obby", false, function(state)
        local portals =
        {CFrame.new(-350.25, 15.20, -496.26), CFrame.new(-350.19, 15.2, -296.42),
        CFrame.new(-240.07, 15.20, -304.31), CFrame.new(-350.24, 15.20, -96.03),
        CFrame.new(-238.66, 15.20, -104.58), CFrame.new(-350.46, 15.20, 103.06),
        CFrame.new(-238.22, 15.20, 95.36), CFrame.new(-349.19, 15.20, 302.37)}



        getgenv().autoObby = state
        while getgenv().autoObby do
            for i, v in pairs(portals) do
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v
                wait(0.07)
            end
            wait(1)
            local checkpoints = {}
            for _, v in pairs(game.Workspace.ObbyCheckpoints:GetChildren()) do
                table.insert(checkpoints, v.Name)
            end
            table.sort(checkpoints)
            for _, checkpointName in pairs(checkpoints) do
                for i, checkpoint in pairs(game.Workspace.ObbyCheckpoints:GetChildren()) do
                    if checkpoint:IsA("Part") and checkpoint.Name == checkpointName then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = checkpoint.CFrame
                        wait(0.95)
                    end
                end
            end
            num = 1
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-160.42, 99.478, -670.58)
            wait(2)
        end
    end)

    function Grab_slime()
        if LocalPlayer.Character then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            for i,v in ipairs(workspace["Drops"]:GetChildren()) do
                if v:IsA("Part") then
                    v.CFrame = hrp.CFrame
                end
             end
        end
        local added;
        added = workspace["Drops"].ChildAdded:Connect(function(v)
            task.wait(.2)
            if v:IsA("Part") and LocalPlayer.Character then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                v.CFrame = hrp.CFrame
            end
        end)
        task.spawn(function()
            while task.wait(.1) do
                if getgenv().Setting.Grab_slime ~= true then added:Disconnect() break; end
            end
        end)
    end
    
    function Deposit()
        task.spawn(function()
            while getgenv().Setting.Deposit and task.wait(.1) do
                event.Deposit:FireServer()
            end
        end)
    end
    
    function Buy_Dropper(value)
        task.spawn(function()
            while getgenv().Setting.Buy_Dropper.boolean and task.wait(.1) do
                local v = value or 1
                event.Buy_Dropper:FireServer(tonumber(v))
            end
        end)
    end
    
    function Buy_Speed()
        task.spawn(function()
            while getgenv().Setting.Buy_Speed and task.wait(.1) do
                event.Buy_Speed:FireServer(1)
            end
        end)
    end
    
    function Merge()
        task.spawn(function()
            while getgenv().Setting.Merge and task.wait(.1) do
                event.Merge:FireServer()
            end
        end)
    end
end

-- player page
local playerPage = novus:addPage("Player", 5012544693)

local movement = playerPage:addSection("Movement")

if game.PlaceId ~= 9872472334 and game.PlaceId ~= 10808838353 then

    movement:addSlider("WalkSpeed", 16, 16, 500, function(ws)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
    end)  

    movement:addSlider("JumpPower", 50, 50, 500, function(jp)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = jp
    end)


    local isNoClipping = false

    runService.Stepped:Connect(function()
        character = game.Players.LocalPlayer.Character
        if character then
            if isNoClipping then
                for i,v in pairs(character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
    end)

    movement:addToggle("NoClip", false, function(state)
        if isNoClipping then
            isNoClipping = false
        else
            isNoClipping = true
        end
    end)

    if game.PlaceId ~= 155615604 then
        -- FLY

        local flyPage = playerPage:addSection("Fly")


        local contextActionService = game:GetService("ContextActionService")
        local connection = nil
        local primaryPart = character.PrimaryPart
        local gravityVector = Vector3.new(0, game.Workspace.Gravity, 0)
        local yAxis = 0
        local force = 3000
        local forceCurve = 0.44
        local drag = 222
        local playerName = game:GetService("Players").LocalPlayer.Name
        local flyON = false

        -- creating Force
        local vectorForce = Instance.new("VectorForce", game.Workspace)
        vectorForce.Enabled = false
        vectorForce.Force = Vector3.new(0, 0, 0)
        vectorForce.RelativeTo = "World"
        vectorForce.Attachment0 = primaryPart.RootRigAttachment

        -- creating Align Orientation
        local alignOrientation = Instance.new("AlignOrientation", game.Workspace)
        alignOrientation.Enabled = false
        alignOrientation.Mode = "OneAttachment"
        alignOrientation.MaxTorque = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368
        alignOrientation.Responsiveness = 30
        alignOrientation.Attachment0 = primaryPart.RootRigAttachment


        -- making custom attachment

        local attachment0 = Instance.new("Attachment")
        attachment0.Position = Vector3.new(-2 ,0, 0)
        attachment0.Parent = character:WaitForChild("LowerTorso")

        local attachment1 = Instance.new("Attachment")
        attachment1.Position = Vector3.new(2, 0, 0)
        attachment1.Parent = character:WaitForChild("LowerTorso")

        -- creating Trail
        local trail = Instance.new("Trail", game.Workspace)
        trail.FaceCamera = true
        trail.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.05, 0.5),
            NumberSequenceKeypoint.new(1, 1)
        }
        trail.Enabled = false
        trail.Lifetime = 1
        trail.WidthScale = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.75),
            NumberSequenceKeypoint.new(0.05, 1),
            NumberSequenceKeypoint.new(1, 0.5)
        }

        trail.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.05, Color3.fromRGB(129, 255, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 231, 255)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(51, 81, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(171, 138, 255))
        }

        trail.Attachment0 = attachment0
        trail.Attachment1 = attachment1


        local function FlyAction(actionName, inputState, inputObject)
            if inputState ~= Enum.UserInputState.Begin then return Enum.ContextActionResult.Pass end
            if flyON == false then return Enum.ContextActionResult.Pass end
            if connection == true then return Enum.ContextActionResult.Pass end
            if connection == nil then
                connection = true
                if character.Humanoid.FloorMaterial ~= Enum.Material.Air then
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(0.1)
                end

                character = game:GetService("Players").LocalPlayer.Character
                primaryPart = character.PrimaryPart
                vectorForce.Attachment0 = primaryPart.RootRigAttachment
                alignOrientation.Attachment0 = primaryPart.RootRigAttachment
                attachment0.Parent = character:WaitForChild("LowerTorso")
                attachment1.Parent = character:WaitForChild("LowerTorso")
                trail.Attachment0 = attachment0
                trail.Attachment1 = attachment1
                vectorForce.Enabled = true
                alignOrientation.CFrame = primaryPart.CFrame
                alignOrientation.Enabled = true
                trail.Enabled = true

                character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                connection = runService.Heartbeat:Connect(function(deltaTime)
                    vectorForce.Force = gravityVector * primaryPart.AssemblyMass
                    local moveVector = Vector3.new(character.Humanoid.MoveDirection.X, yAxis, character.Humanoid.MoveDirection.Z)
                    if moveVector.Magnitude > 0 then
                        moveVector = moveVector.Unit
                        vectorForce.Force += moveVector * force * primaryPart.AssemblyMass
                        if math.abs(moveVector.Y) == 1 then
                            alignOrientation.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), moveVector, -primaryPart.CFrame.LookVector) * CFrame.fromOrientation(-math.pi /2, 0, 0)
                        else
                            alignOrientation.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), moveVector) * CFrame.fromOrientation(-math.pi /2, 0, 0)
                        end
                    end
                    if primaryPart.AssemblyLinearVelocity.Magnitude > 0 then
                        local dragVector = -primaryPart.AssemblyLinearVelocity.Unit * primaryPart.AssemblyLinearVelocity.Magnitude ^ forceCurve
                        vectorForce.Force += dragVector * drag * primaryPart.AssemblyMass
                    end
                end)
            else
                vectorForce.Enabled = false
                alignOrientation.Enabled = false
                trail.Enabled = false
                character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                connection:Disconnect()
                connection = nil
            end
            return Enum.ContextActionResult.Pass
        end

        local function UpAction(actionName, inputState, inputObject)
            if inputState == Enum.UserInputState.Begin then yAxis = 1 else yAxis = 0 end
            return Enum.ContextActionResult.Pass
        end

        local function DownAction(actionName, inputState, inputObject)
            if inputState == Enum.UserInputState.Begin then yAxis = -1 else yAxis = 0 end
            return Enum.ContextActionResult.Pass
        end

        contextActionService:BindAction("Fly", FlyAction, true, Enum.KeyCode.B)

        contextActionService:BindAction("Up", UpAction, true, Enum.KeyCode.Space)

        contextActionService:BindAction("Down", DownAction, true, Enum.KeyCode.LeftShift)



        local function stopFly()
            flyON = false
            vectorForce.Enabled = false
            alignOrientation.Enabled = false
            trail.Enabled = false
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            connection:Disconnect()
            connection = nil
        end


        flyPage:addToggle("Fly (Press B)", false, function(state)
            if state then
                flyON = true
            else
                stopFly()
            end
        end)

        flyPage:addSlider("Fly Speed", 3000, 2000, 5000, function(value)
            force = value
        end)
    end


    -- Teleport

    local teleport = playerPage:addSection("Teleport")

    local players = {}
    local playerNames = {}
    local localCharacter = nil
    local toPlayerCFrame = CFrame.new(0,0,0)

    -- getting Player Names
    for _, v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Name ~= game:GetService("Players").LocalPlayer.Name then
            table.insert(playerNames, v.Name)
        end 
    end

    -- getting Player Instances
    for _, v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Name ~= game:GetService("Players").LocalPlayer.Name then
            table.insert(players, v)
        end 
    end
    localCharacter = game:GetService("Players").LocalPlayer.Character

    -- creating dropdown
    local playerDropdown = teleport:addDropdown("Select Player", playerNames, function(playerName)
        for _, v in pairs(players) do
            if v.Name == playerName then
                toPlayerCFrame = v.Character.HumanoidRootPart.CFrame
                localCharacter.HumanoidRootPart.CFrame = toPlayerCFrame
            end
        end
        localCharacter = game:GetService("Players").LocalPlayer.Character
    end)

    -- if player joins
    game:GetService("Players").PlayerAdded:Connect(function(player)
        print(player.Name .. " joined the game!")
        table.insert(players, player)
        table.insert(playerNames, player.Name)
        teleport:updateDropdown(playerDropdown, "Select Player", playerNames)
    end)

    -- if player leaves
    num = 1
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        for _, v in pairs(playerNames) do
            if player.Name == v then 
                table.remove(playerNames, num)
            end
            num += 1
        end
        num = 1
        for _, v in pairs(players) do
            if v.Name == player.Name then
                table.remove(players, num)
            end
            num += 1
        end
        num = 1
        teleport:updateDropdown(playerDropdown, "Select Player", playerNames)
    end)

else
    -- Evade

    getgenv().settings = {
        walkSpeed = 1450,
        jumpPower = 3
    }

    movement:addSlider("Walkspeed", 1, 1, 10, function(walkSpeed)
        settings.walkSpeed = walkSpeed * 1450
    end)

    movement:addSlider("JumpPower", 1, 1, 50, function(jumpPower)
        settings.jumpPower = jumpPower * 3
    end)

    movement:addToggle("Angry Munci (use at your own risk)", false, function(state)
        if state then
            settings.walkSpeed = settings.walkSpeed * 11
        else
            settings.walkSpeed = settings.walkSpeed / 11
        end
    end)

    local characterMovement
    characterMovement = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
        local args = {...}
        local method = getnamecallmethod()
        if tostring(self) == 'Communicator' and method == "InvokeServer" and args[1] == "update" then
            return settings.walkSpeed, settings.jumpPower
        end
        return characterMovement(self,...)
    end))
end

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

e_player:addButton("Server Hop", function()
    local Player = game.Players.LocalPlayer    
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"

    local _place,_id = game.PlaceId, game.JobId
    local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
    end

    local Next; repeat
    local Servers = ListServers(Next)
    for i,v in next, Servers.data do
        if v.playing < v.maxPlayers and v.id ~= _id then
            local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
            if s then break end
        end
    end
    
    Next = Servers.nextPageCursor
    until not Next
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
    novus:toggle() end, function()
end)

if game.PlaceId == 9872472334 or game.PlaceId == 10808838353 then
    -- Evade
    
    local propertyNames = {"WalkSpeed", "JumpPower"}
    local propertyName = "walkSpeed"

    keybinds:addDropdown("Property", propertyNames, function(currentPropertyName)
        propertyName = currentPropertyName
        if currentPropertyName == "WalkSpeed" then
            propertyName = "walkSpeed"
        elseif currentPropertyName == "JumpPower" then
            propertyName = "jumpPower"
        end
    end)

    keybinds:addKeybind("Increase", Enum.KeyCode.B, function()
        if propertyName == "walkSpeed" then
            if not (getgenv().settings.walkSpeed >= 1450*10) then
                getgenv().settings.walkSpeed += 1450
            end
        elseif propertyName == "jumpPower" then
            if not (getgenv().settings.jumpPower >= 3*50) then
                getgenv().settings.jumpPower += 25
            end
        end
    end, function()
    end)

    keybinds:addKeybind("Decrease", Enum.KeyCode.V, function()
        if propertyName == "walkSpeed" then
            if not (getgenv().settings.walkSpeed <= 1450) then
                getgenv().settings.walkSpeed -= 1450
            end
        elseif propertyName == "jumpPower" then
            if not (getgenv().settings.walkSpeed <= 3) then
                getgenv().settings.jumpPower -= 25
            end
        end
    end, function()
    end)
end

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