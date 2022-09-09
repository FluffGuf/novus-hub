-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local novus = library.new("Novus Hub", 5013109572)


-- themes
local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

-- first page
local playerPage = novus:addPage("Player", 5012544693)

-- getting needed vars for Player
local humanoid = game.Players.LocalPlayer.Character.Humanoid

-- sections
local movement = playerPage:addSection("Movement")
movement:addSlider("WalkSpeed", 16, 16, 500, function(ws)
    humanoid.WalkSpeed = ws
end)  

movement:addSlider("JumpPower", 50, 50, 500, function(jp)
    humanoid.JumpPower = jp
end)

local health = playerPage:addSection("Health")

health:addButton("Heal", function()
    humanoid.Hewalth = humanoid.MaxHealth
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



-- load
novus:SelectPage(novus.pages[1], true)