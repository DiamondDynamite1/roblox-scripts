local potionGui,godmode,autofarm,autolevel,moveTextBox,godmodeButton,autofarmButton,autolevelButton = false


local GUI = loadstring([[local GUI = {}

function GUI:new (toggleKeyCode,spaceBetweenChildren,buttonHeight) 
	spaceBetweenChildren = spaceBetweenChildren or 10
	buttonHeight = buttonHeight or 25
	toggleKeyCode = toggleKeyCode or Enum.KeyCode.P
	local UIS = game:GetService("UserInputService")

	local gui = {}
	gui.instance = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")

	gui.instance.Name = "gui maker"
	gui.instance.Parent = game:GetService("CoreGui")
	Frame.Parent = gui.instance
	Frame.Active = true
	Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.0623471886, 0, 0.0909090936, 0)
	Frame.Selectable = true
	Frame.Draggable = true
	Frame.Size = UDim2.new(0, 200, 0, 150)

	UICorner.CornerRadius = UDim.new(0, 20)
	UICorner.Parent = Frame

	UIS.InputBegan:Connect(function(key,typing) 
		if not typing and key.KeyCode == toggleKeyCode then 
			gui.instance.Enabled = not gui.instance.Enabled
		end
	end)

	local function scaleFrame()
		local childrenCount = #Frame:GetChildren()
		local newSize = childrenCount * spaceBetweenChildren + (childrenCount-1) * buttonHeight
		Frame.Size = UDim2.new(0,Frame.AbsoluteSize.X,0, newSize)
	end

	local function setChildrenPos()
		local frameHeight = Frame.AbsoluteSize.Y
		local i = 0
		for _,v in pairs(Frame:GetChildren()) do
			if not v:IsA("UICorner") then 
				local vPos = (i*25+(i+1)*10)/frameHeight
				v.Position = UDim2.new(0.05, 0, vPos, 0)
				i+=1
			end
		end
	end

	function gui:addButton (text,onclick)
		local Button = Instance.new("TextButton")
		local ButtonUICorner = Instance.new("UICorner")
		Button.Name = text
		Button.Parent = Frame
		Button.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
		Button.BorderColor3 = Color3.fromRGB(72, 72, 72)
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(0, 180, 0, 25)
		Button.Font = Enum.Font.SourceSansBold
		Button.Text = text
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.TextSize = 20.000
		ButtonUICorner.CornerRadius = UDim.new(0, 20)
		ButtonUICorner.Parent = Button
		if onclick then
			Button.MouseButton1Click:Connect(onclick)
		end
		scaleFrame()
		setChildrenPos()
		return Button
	end


	function gui:addTextBox (text)
		local TextBox = Instance.new("TextBox")
		local TextBoxUICorner = Instance.new("UICorner")

		TextBox.Name = text
		TextBox.Parent = Frame
		TextBox.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(0, 180, 0, 25)
		TextBox.Font = Enum.Font.SourceSansBold
		TextBox.PlaceholderText = text
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 20.000

		TextBoxUICorner.CornerRadius = UDim.new(0, 20)
		TextBoxUICorner.Parent = TextBox

		scaleFrame()
		setChildrenPos()
		return TextBox
	end

	return gui

end

return GUI

]])()

local player = game:GetService("Players").LocalPlayer
local code = "É”iÇ«É’M"

local event = game:GetService("ReplicatedStorage").RemoteEvents.MagicEvent

local gui = GUI:new()
potionGui = GUI:new("none")

gui:addButton("Potions",function() 
    potionGui.instance.Enabled = not potionGui.instance.Enabled
end)

godmodeButton = gui:addButton("Godmode [OFF]",function() 
    godmode = not godmode
    godmodeButton.Text = "Godmode ["..(godmode and "ON" or "OFF").."]"
end)



autofarmButton = gui:addButton("Autofarm [OFF]",function() 
    autofarm = not autofarm
    autofarmButton.Text = "Autofarm ["..(autofarm and "ON" or "OFF").."]"
end)

autolevelButton = gui:addButton("Autolevel [OFF]",function() 
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



potionGui.instance.Enabled = false
print(potionGui.instance.Frame.Position.X.Scale)
potionGui.instance.Frame.Position = UDim2.new(potionGui.instance.Frame.Position.X.Scale*4, 0, potionGui.instance.Frame.Position.Y.Scale, 0)

local potions = {"Health","Speed","Damage","Defense"}

for _,v in pairs(potions) do
    potionGui:addButton(v.." Potion",function ()
        event:FireServer(v.."Potion",code)
    end)
end

while wait(.15) do
    if autofarm then
        local children = game:GetService("Workspace"):GetChildren()
        local target
        for _,v in pairs(children) do
            if (v.Name == "Thief" or v.Name == "Thug" or v.Name == "Pirate" or v.Name == "Wizard" or v.Name == "Dark Wizard Boss" or v.Name == "Cave Wizard" or v.Name == "Mountain Wizard") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                target = v
                break
            end
        end
        if target and player.Character and player.Character.PrimaryPart then
            event:FireServer("Disturbed",target.HumanoidRootPart.Position, code)
        end
    end
    if godmode and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health < player.Character.Humanoid.MaxHealth then
        event:FireServer("HealthPotion",code)
    end
end
