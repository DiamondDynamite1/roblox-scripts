local GUI = {}

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
