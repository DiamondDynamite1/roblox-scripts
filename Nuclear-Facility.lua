-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local killButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local killTextBox = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local explosionButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local gunButton = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UICorner_5 = Instance.new("UICorner")

--Properties:

ScreenGui.Parent = game:GetService("CoreGui")

Frame.Parent = ScreenGui
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0623471886, 0, 0.0909090936, 0)
Frame.Selectable = true
Frame.Size = UDim2.new(0, 200, 0, 150)

killButton.Name = "killButton"
killButton.Parent = Frame
killButton.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
killButton.BorderSizePixel = 0
killButton.Position = UDim2.new(0.049999997, 0, 0.75777781, 0)
killButton.Size = UDim2.new(0, 180, 0, 25)
killButton.Font = Enum.Font.SourceSansBold
killButton.Text = "Kill"
killButton.TextColor3 = Color3.fromRGB(255, 255, 255)
killButton.TextSize = 20.000
killButton.TextWrapped = true

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = killButton

killTextBox.Name = "killTextBox"
killTextBox.Parent = Frame
killTextBox.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
killTextBox.BorderSizePixel = 0
killTextBox.Position = UDim2.new(0.049999997, 0, 0.528888941, 0)
killTextBox.Size = UDim2.new(0, 180, 0, 25)
killTextBox.Font = Enum.Font.SourceSansBold
killTextBox.PlaceholderText = "Player Name"
killTextBox.Text = ""
killTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
killTextBox.TextSize = 20.000

UICorner_2.CornerRadius = UDim.new(0, 20)
UICorner_2.Parent = killTextBox

explosionButton.Name = "explosionButton"
explosionButton.Parent = Frame
explosionButton.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
explosionButton.BorderSizePixel = 0
explosionButton.Position = UDim2.new(0.049999997, 0, 0.299999982, 0)
explosionButton.Size = UDim2.new(0, 180, 0, 25)
explosionButton.Font = Enum.Font.SourceSansBold
explosionButton.Text = "Pepper + Water"
explosionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
explosionButton.TextSize = 20.000

UICorner_3.CornerRadius = UDim.new(0, 20)
UICorner_3.Parent = explosionButton

gunButton.Name = "gunButton"
gunButton.Parent = Frame
gunButton.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
gunButton.BorderColor3 = Color3.fromRGB(72, 72, 72)
gunButton.BorderSizePixel = 0
gunButton.Position = UDim2.new(0.049999997, 0, 0.0711111128, 0)
gunButton.Size = UDim2.new(0, 180, 0, 25)
gunButton.Font = Enum.Font.SourceSansBold
gunButton.Text = "Gun"
gunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
gunButton.TextSize = 20.000

UICorner_4.CornerRadius = UDim.new(0, 20)
UICorner_4.Parent = gunButton

UICorner_5.CornerRadius = UDim.new(0, 20)
UICorner_5.Parent = Frame

-- Scripts:

local function NZRWRJJ_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	local frame = script.Parent
	local players = game:GetService("Players")
	local UIS = game:GetService("UserInputService")
	
	frame.Draggable = true
	
	UIS.InputBegan:Connect(function(key,typing) 
		if not typing and key.KeyCode == Enum.KeyCode.P then
			frame.Parent.Enabled = not frame.Parent.Enabled
		end
	end)
	
	frame.gunButton.MouseButton1Click:Connect(function() 
		fireclickdetector(game:GetService("Workspace").Map.Projects.gun.touch.ClickDetector)
	end)
	
	frame.explosionButton.MouseButton1Click:Connect(function() 
		fireclickdetector(game:GetService("Workspace").Map.Projects.Pepper_Crate.ClickDetector)
		fireclickdetector(game:GetService("Workspace").Map.Projects.Glass.ClickDetector)
	end)
	
	local function killPlayer(name) 
		local event = players:FindFirstChild("InflictTarget",true)
	
		if event == nil then print("no damaging event found") end
	
	
		local target 
		for _,v in pairs(players:GetChildren()) do
			if(v.Name:lower():match(name:lower())) then 
				target = v
				break 
			end
		end
		if target then
	
			local char = target.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				local torso = char:FindFirstChild("UpperTorso")
				if hum and torso then
					-- Script generated by Remote2Script
	
					local A_1 = hum
					local A_2 = torso
					local A_3 = 150
					local A_4 = Vector3.new(-0.670269966, -0.029699754, 0.741522729)
					local A_5 = 0
					local A_6 = 0
					local A_7 = false
					event:FireServer(A_1, A_2, A_3, A_4, A_5, A_6, A_7) 
				end
			end
		end
	end
	
	frame.killButton.MouseButton1Click:Connect(function() 
		local name = frame.killTextBox.Text:lower()
		if name == "all" then
			for _,v in pairs(players:GetChildren()) do
				killPlayer(v.Name)
			end
		else 
			killPlayer(name) 
		end
		
	end)
	
	
	
end
coroutine.wrap(NZRWRJJ_fake_script)()