local TextBox = Instance.new("TextButton",Instance.new("ScreenGui",game.CoreGui))
TextBox.BorderColor3=Color3.new(1,0,0)
TextBox.BorderSizePixel=1
TextBox.BackgroundColor3=Color3.new()
TextBox.TextColor3=Color3.new(1,0,0)
TextBox.TextSize=16
TextBox.Text="made by Squiggle on discord"
TextBox.Size=UDim2.new(0,300,0,50)
TextBox.AnchorPoint=Vector2.new(0.5,0.5)
TextBox.Position=UDim2.new(0,workspace.CurrentCamera.ViewportSize.X/2,0,workspace.CurrentCamera.ViewportSize.Y/2)
TextBox.AutoButtonColor=false
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
TextBox.MouseButton1Down:Connect(function()
	local drag = true
	task.spawn(function()
		TextBox.MouseButton1Up:Wait()
		drag=false
	end)
	local px,py = mouse.X,mouse.Y
	while drag do game:GetService("RunService").RenderStepped:Wait()
		local cx,cy = mouse.X,mouse.Y
		TextBox.Position=TextBox.Position+UDim2.new(0,cx-px,0,cy-py)
		px,py=cx,cy
	end
end)

-- This file was generated using Luraph Obfuscator v13.8.1
