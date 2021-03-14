local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DiamondDynamite1/roblox-scripts/main/gui-maker.lua", true))()


--variables 
local godmode,autofarm,autolevel = false
local player = game:GetService("Players").LocalPlayer
local code = "É”iÇ«É’M"
local event = game:GetService("ReplicatedStorage").RemoteEvents.MagicEvent

--make guis
local gui = GUI:new()

local potionGui = GUI:new("none")
potionGui.instance.Enabled = false
potionGui.instance.Frame.Position = UDim2.new(potionGui.instance.Frame.Position.X.Scale*4, 0, potionGui.instance.Frame.Position.Y.Scale, 0)

--make buttons
local potionsButton = gui:addButton("Potions")
local godmodeButton = gui:addButton("Godmode [OFF]")
local autofarmButton = gui:addButton("Autofarm [OFF]")
local autolevelButton = gui:addButton("Autolevel [OFF]")


--button do stuff
potionsButton.MouseButton1Click:Connect(function() 
    potionGui.instance.Enabled = not potionGui.instance.Enabled
end)

godmodeButton.MouseButton1Click:Connect(function()
    godmode = not godmode
    godmodeButton.Text = "Godmode ["..(godmode and "ON" or "OFF").."]"
end)

autolevelButton.MouseButton1Click:Connect(function() 
    autolevel = not autolevel
    autolevelButton.Text = "Autolevel ["..(autolevel and "ON" or "OFF").."]"
    local RunService = game:GetService("RunService")

    if autolevel then
        RunService:BindToRenderStep("level",0,function() 
            player.Character:MoveTo(Vector3.new(10000,10000,10000))
            event:FireServer("HealthPotion",code)
        end)
    else RunService:UnbindFromRenderStep("level") end
end)

autofarmButton.MouseButton1Click:Connect(function() 
    autofarm = not autofarm
    autofarmButton.Text = "Autofarm ["..(autofarm and "ON" or "OFF").."]"
end)


--potion gui buttons
local potions = {"Health","Speed","Damage","Defense"}

for _,v in pairs(potions) do
    local button = potionGui:addButton(v.." Potion")
    button.MouseButton1Click:Connect(function ()
        event:FireServer(v.."Potion",code)
    end)
end


--godmode and autofarm
while wait(.3) do
    if autofarm then
        local children = game:GetService("Workspace"):GetChildren()
        for _,v in pairs(children) do
            if (v.Name == "Thief" or v.Name == "Thug" or v.Name == "Pirate" or v.Name == "Wizard" or v.Name == "Dark Wizard Boss" or v.Name == "Cave Wizard" or v.Name == "Mountain Wizard") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                event:FireServer("Disturbed",v.HumanoidRootPart.Position, code)
                wait()
            end
        end
    end
    if godmode and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health < player.Character.Humanoid.MaxHealth then
        event:FireServer("HealthPotion",code)
    end
end
