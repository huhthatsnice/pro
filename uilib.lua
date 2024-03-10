local screengui = Instance.new("ScreenGui")
local plr = game:GetService("Players").LocalPlayer
local mouse = plr:GetMouse()
local rs = game:GetService("RunService")
local input = game:GetService("UserInputService")

local function lerp(a,b,c)
	return a*(1.0-c)+(b*c)
end
local function invlerp(a,b,c)
	return (c-a)/(b-a)
end
local createdsections:{
	{
		{
			{
				Value:boolean|number|nil,
				Update:()->(),
				onUpdate:{
					()->()?
				}
			}
		}
	}
} = {}
local library = {}

local debugging = true

function library:CreateWindow(tag,size,position)
	local tag = tag or (debugging and "Debug") or ""
	local size = size or UDim2.new(0,375,0,500)
	local position = position or UDim2.new(0,100,0,100)

	local window = {SelectedTab="",isOpen=true,ScreenGui=screengui}

	local Background=Instance.new("Frame")
	Background.BorderSizePixel=2
	Background.BackgroundColor3=Color3.fromRGB(15,15,15)
	Background.Size=size
	Background.Position=position
	Background.BorderSizePixel=1
	Background.BorderColor3=Color3.fromRGB(50,50,50)
	local SettingsContainer=Instance.new("ScrollingFrame")
	SettingsContainer.BackgroundColor3=Color3.fromRGB(15,15,15)
	SettingsContainer.BorderSizePixel=1
	SettingsContainer.BorderColor3=Color3.fromRGB(50,50,50)
	SettingsContainer.ScrollBarThickness=2
	SettingsContainer.VerticalScrollBarPosition=Enum.VerticalScrollBarPosition.Right
	SettingsContainer.Parent=Background
	SettingsContainer.Size=Background.Size-UDim2.new(0,8,0,54)
	SettingsContainer.Position=UDim2.new(0,4,0,50)
	SettingsContainer.BorderSizePixel=2
	local TabHolder=Instance.new("Frame")
	TabHolder.BackgroundColor3=Color3.fromRGB(15,15,15)
	TabHolder.BorderSizePixel=1
	TabHolder.BorderColor3=Color3.fromRGB(50,50,50)
	TabHolder.Parent=Background
	TabHolder.Parent=Background
	TabHolder.Position=UDim2.new(0,4,0,28)
	TabHolder.Size=UDim2.new(0,367,0,20)
	TabHolder.BackgroundTransparency=1
	TabHolder.BorderSizePixel=0
	local SettingsContainerInset1=Instance.new("Frame")
	SettingsContainerInset1.Size=UDim2.new(0,0,0,0)
	SettingsContainerInset1.Position=UDim2.new(0,4,0,4)
	SettingsContainerInset1.Parent=SettingsContainer
	SettingsContainerInset1.BackgroundTransparency=1
	local SettingsContainerInset2=Instance.new("Frame")
	SettingsContainerInset2.Size=UDim2.new(0,172,0,0)
	SettingsContainerInset2.Position=UDim2.new(0,186,0,4)
	SettingsContainerInset2.Parent=SettingsContainer
	SettingsContainerInset2.BackgroundTransparency=1
	local UILayout=Instance.new("UIListLayout")
	UILayout.Parent=TabHolder
	UILayout.Padding=UDim.new(0,2)
	UILayout.FillDirection=Enum.FillDirection.Horizontal
	UILayout.SortOrder=Enum.SortOrder.LayoutOrder
	local NewUILayout=UILayout:Clone()
	NewUILayout.FillDirection=Enum.FillDirection.Vertical
	NewUILayout.Padding=UDim.new(0,6)
	NewUILayout.Parent=SettingsContainerInset1
	local NewUILayout=UILayout:Clone()
	NewUILayout.FillDirection=Enum.FillDirection.Vertical
	NewUILayout.Padding=UDim.new(0,6)
	NewUILayout.Parent=SettingsContainerInset2
	local WindowText=Instance.new("TextButton")
	WindowText.Parent=Background
	WindowText.Position=UDim2.new(0,2,0,0)
	WindowText.Size=UDim2.new(1,0,0,23)
	WindowText.BorderSizePixel=0
	WindowText.BackgroundTransparency=1
	WindowText.TextColor3=Color3.fromRGB(255,0,0)
	WindowText.TextXAlignment=Enum.TextXAlignment.Left
	WindowText.Text=tag
	WindowText.TextStrokeColor3=Color3.new()
	WindowText.TextStrokeTransparency=0
	WindowText.Font=Enum.Font.Ubuntu
	WindowText.TextSize=12
	WindowText.AutoButtonColor=false
	local drag = false
	local dragoffset
	WindowText.MouseButton1Down:Connect(function()
		drag=true
		dragoffset=Vector2.new(Background.Position.X.Offset,Background.Position.Y.Offset)-Vector2.new(mouse.X,mouse.Y)
		while drag do rs.RenderStepped:Wait()
			Background.Position=UDim2.new(0,mouse.X+dragoffset.X,0,mouse.Y+dragoffset.Y)
		end
	end)
	local function release()
		drag=false
	end
	mouse.Button1Up:Connect(release)
	WindowText.MouseButton1Up:Connect(release)
	Background.Parent=screengui
	function window:Toggle()
		window.isOpen=not window.isOpen
		if window.Open then
			Background.Parent=screengui
		else
			Background.Parent=nil
		end
	end
	function window:Close()
		window.isOpen=false
		Background.Parent=nil
	end
	function window:Open()
		window.isOpen=true
		Background.Parent=screengui
	end
	function window:UpdateTag(tag:string)
		local tag = tag or (debugging and "Debug") or ""
		WindowText.Text=tag
	end
	function window:AddTab(tabname:string,tabposition:number)
		local tabposition = tabposition or #TabHolder:GetChildren()
		local NewTab=Instance.new("TextButton")
		NewTab.LayoutOrder=tabposition
		NewTab.Parent=TabHolder
		NewTab.Position=UDim2.new(0,2,0,0)
		NewTab.Size=UDim2.new(0,80,0,20)
		NewTab.BackgroundColor3=Color3.fromRGB(15,15,15)
		NewTab.BorderColor3=Color3.fromRGB(50,50,50)
		NewTab.BorderSizePixel=2
		NewTab.TextColor3=Color3.fromRGB(255,0,0)
		NewTab.TextXAlignment=Enum.TextXAlignment.Left
		NewTab.Text=tabname
		NewTab.TextStrokeColor3=Color3.new()
		NewTab.TextStrokeTransparency=0
		NewTab.Font=Enum.Font.Ubuntu
		NewTab.TextColor3=Color3.fromRGB(255,0,0)
		NewTab.AutoButtonColor=false
		NewTab.TextSize=12
		NewTab.TextXAlignment=Enum.TextXAlignment.Center
		local first = true
		for i,v in pairs(createdsections) do
			first = false
			break
		end
		createdsections[tabname]={
			Instances={}
		}
		NewTab.MouseButton1Down:Connect(function()
			window:SetSelectedTab(tabname)
		end)

		local tab = {}
		function tab:AddSection(sectionname:string)
			local SectionContainer=Instance.new("Frame")
			SectionContainer.BackgroundColor3=Color3.fromRGB(15,15,15)
			SectionContainer.Size=UDim2.new(0,176,0,33)
			SectionContainer.Position=UDim2.new(0,4,0,0)
			SectionContainer.BorderSizePixel=2
			SectionContainer.BorderColor3=Color3.fromRGB(50,50,50)
			local SectionSettingContainer = SectionContainer:Clone()
			SectionSettingContainer.Position=UDim2.new(0,0,0,25)
			SectionSettingContainer.Size=SectionContainer.Size-UDim2.new(0,0,0,25)
			SectionSettingContainer.Parent=SectionContainer
			local NewUILayout=UILayout:Clone()
			NewUILayout.Parent=SectionSettingContainer
			NewUILayout.FillDirection=Enum.FillDirection.Vertical
			NewUILayout.Padding=UDim.new(0,4)
			local SectionName=WindowText:Clone()
			SectionName.Text=sectionname
			SectionName.Parent=SectionContainer

			local section = {}

			function section:AddSetting(settingname:string,settingtype:string,default:any,arg1:number,arg2:number,usesettingname:boolean)
				usesettingname=if usesettingname==nil then true else usesettingname
				local SettingContainer=Instance.new("Frame")
				SettingContainer.Size=UDim2.new(0,172,0,0)
				SettingContainer.Parent=SectionSettingContainer
				SettingContainer.BackgroundTransparency=1
				local SettingContainerInset=Instance.new("Frame")
				SettingContainerInset.Size=UDim2.new(0,0,0,0)
				SettingContainerInset.Position=UDim2.new(0,4,0,0)
				SettingContainerInset.Parent=SettingContainer
				SettingContainerInset.BackgroundTransparency=1
				local NewUILayout=UILayout:Clone()
				NewUILayout.Parent=SettingContainerInset
				NewUILayout.FillDirection=Enum.FillDirection.Vertical
				NewUILayout.Padding=UDim.new(0,4)
				local function incrementsize(val)
					SettingContainer.Size+=UDim2.new(0,0,0,val)
					SectionContainer.Size+=UDim2.new(0,0,0,val)
					SectionSettingContainer.Size+=UDim2.new(0,0,0,val)
				end
				if usesettingname then
					local SettingName=WindowText:Clone()
					SettingName.Text=settingname
					SettingName.Parent=SettingContainerInset
					SettingName.LayoutOrder=#SettingContainerInset:GetChildren()
					incrementsize(27)
				end
				createdsections[tabname][sectionname][settingname]={onUpdate={}}
				local settingvals=createdsections[tabname][sectionname][settingname]
				if settingtype=="Toggle" then
					local default = default or false
					local Setting=Instance.new("TextButton")
					Setting.LayoutOrder=#SettingContainerInset:GetChildren()
					Setting.Parent=SettingContainerInset
					Setting.Size=UDim2.new(0,15,0,15)
					Setting.Text=""
					Setting.BackgroundColor3=Color3.fromRGB(15,15,15)
					Setting.BorderSizePixel=2
					Setting.BorderColor3=Color3.fromRGB(50,50,50)
					Setting.AutoButtonColor=false
					incrementsize(19)
					settingvals.Value=if default then true else false
					local function update()
						settingvals.Value=not settingvals.Value
						for i,v in pairs(settingvals.onUpdate) do
							v()
						end
						if settingvals.Value then
							Setting.BackgroundColor3=Color3.fromRGB(75,75,75)
						else
							Setting.BackgroundColor3=Color3.fromRGB(15,15,15)
						end
					end
					Setting.MouseButton1Down:Connect(update)
					settingvals.Update=update
				elseif settingtype=="Button" then
					local Setting=Instance.new("TextButton")
					Setting.LayoutOrder=#SettingContainerInset:GetChildren()
					Setting.Parent=SettingContainerInset
					Setting.Size=UDim2.new(0,15,0,15)
					Setting.Text=""
					Setting.BackgroundColor3=Color3.fromRGB(15,15,15)
					Setting.BorderSizePixel=2
					Setting.BorderColor3=Color3.fromRGB(50,50,50)
					Setting.AutoButtonColor=false
					incrementsize(19)
					local function update()
						for i,v in pairs(settingvals.onUpdate) do
							v()
						end
					end
					Setting.MouseButton1Down:Connect(function()
						Setting.BackgroundColor3=Color3.fromRGB(75,75,75)
						update()
					end)
					Setting.MouseButton1Up:Connect(function()
						Setting.BackgroundColor3=Color3.fromRGB(15,15,15)
					end)
					settingvals.Update=update
				elseif settingtype=="Number" or settingtype=="Slider" then
					local default = default or 1
					local Setting=Instance.new("TextBox")
					Setting.LayoutOrder=#SettingContainerInset:GetChildren()
					Setting.Parent=SettingContainerInset
					Setting.Size=UDim2.new(0,50,0,23)
					Setting.Text=tostring(default)
					Setting.BackgroundColor3=Color3.fromRGB(15,15,15)
					Setting.BorderSizePixel=2
					Setting.BorderColor3=Color3.fromRGB(50,50,50)
					incrementsize(27)
					local lasttext=tostring(default)
					settingvals.Value=default
					if settingtype~="Slider" then
						local function update(val)
							if val then
								settingvals.Value=val
								Setting.Text=tostring(val)
								lasttext=Setting.text
								for i,v in pairs(settingvals.onUpdate) do
									v()
								end
							else
								Setting.Text=lasttext
							end
						end
						Setting.FocusLost:Connect(function()
							update(tonumber(Setting.Text))
						end)
						settingvals.Update=update
					elseif settingtype=="Slider" then
						local arg1 = arg1 or 0
						local arg2 = arg2 or 10
						local default = default and math.clamp(default,arg1,arg2) or (arg1+arg2)/2
						local SettingInset=Instance.new("Frame")
						SettingInset.Parent=SettingContainerInset
						SettingInset.LayoutOrder=#SettingContainerInset:GetChildren()
						SettingInset.BackgroundTransparency=1
						SettingInset.Size=UDim2.new(0,0,0,0)
						SettingInset.Position=UDim2.new(0,0,0,0)
						local SettingInteract=Instance.new("TextButton")
						SettingInteract.Parent=SettingInset
						SettingInteract.Text=""
						SettingInteract.BackgroundTransparency=1
						SettingInteract.Size=UDim2.new(0,160,0,16)
						SettingInteract.Position=UDim2.new(0,10,0,0)
						local SettingSliderBar=Instance.new("Frame")
						SettingSliderBar.Parent=SettingInteract
						SettingSliderBar.Size=UDim2.new(0,160,0,4)
						SettingSliderBar.Position=UDim2.new(0,0,0,6)
						SettingSliderBar.BackgroundColor3=Color3.fromRGB(50,50,50)
						SettingSliderBar.BorderSizePixel=0
						local SettingSlider=Instance.new("Frame")
						SettingSlider.Parent=SettingSliderBar
						SettingSlider.Position=UDim2.new(0,0,0,2)
						SettingSlider.AnchorPoint=Vector2.new(0.5,0.5)
						SettingSlider.Size=UDim2.new(0,8,0,16)
						SettingSlider.BackgroundColor3=Color3.fromRGB(15,15,15)
						SettingSlider.BorderSizePixel=2
						SettingSlider.BorderColor3=Color3.fromRGB(50,50,50)
						local drag = false
						local pmxrel
						local mxrel
						local update = function(val)
							if not val then
								local percent = mxrel/160
								settingvals.Value=lerp(arg1,arg2,percent)
								Setting.Text=tostring(settingvals.Value)
								for i,v in pairs(settingvals.onUpdate) do
									v()
								end
							else
								settingvals.Value=val
								SettingSlider.Position=UDim2.new(0,invlerp(arg1,arg2,math.clamp(val,arg1,arg2))*160,0,2)
							end
						end
						SettingInteract.MouseButton1Down:Connect(function()
							drag=true
							while drag do rs.RenderStepped:Wait()
								mxrel = math.clamp(mouse.X-SettingSliderBar.AbsolutePosition.X,0,160)
								SettingSlider.Position=UDim2.new(0,mxrel,0,2)
								if pmxrel~=mxrel then
									update()
								end
								pmxrel = mxrel
							end
						end)
						local function release()
							drag=false
						end
						mouse.Button1Up:Connect(release)
						SettingInteract.MouseButton1Up:Connect(release)
						Setting.FocusLost:Connect(function()
							update(tonumber(Setting.Text))
						end)
						update(default)
						incrementsize(21)
					end
				elseif settingtype=="String" then
					local default = default or ""
					local Setting=Instance.new("TextBox")
					Setting.LayoutOrder=#SettingContainerInset:GetChildren()
					Setting.Parent=SettingContainerInset
					Setting.Size=UDim2.new(0,100,0,23)
					Setting.Text=tostring(default)
					Setting.BackgroundColor3=Color3.fromRGB(15,15,15)
					Setting.BorderSizePixel=2
					Setting.BorderColor3=Color3.fromRGB(50,50,50)
					Setting.MultiLine=true
					Setting.ClearTextOnFocus=false
					incrementsize(27)
					settingvals.Value=default
					local function update(val)
						settingvals.Value=val
						for i,v in pairs(settingvals.onUpdate) do
							v()
						end
					end
					Setting.FocusLost:Connect(function()
						update(Setting.Text)
					end)
					settingvals.Update=update
				end
				return settingvals
			end
			function section:GetSettingValue(setting:string)
				return createdsections[tabname][sectionname][setting].Value
			end
			function section:UpdateSettingValue(setting:string,...)
				return createdsections[tabname][sectionname][setting].Update(...)
			end
			function section:ConnectSettingUpdate(setting:string,func:()->())
				table.insert(createdsections[tabname][sectionname][setting].onUpdate,func)
			end
			if window.SelectedTab == tabname then
				local nextcont = SettingsContainerInset1.UIListLayout.AbsoluteContentSize.Y<=SettingsContainerInset2.UIListLayout.AbsoluteContentSize.Y and SettingsContainerInset1 or SettingsContainerInset2
				SectionContainer.Parent=nextcont
			end
			table.insert(createdsections[tabname].Instances,SectionContainer)
			createdsections[tabname][sectionname]={}
			return section
		end
		if first then
			window:SetSelectedTab(tabname)
		end
		return tab
	end
	function window:SetSelectedTab(tab:string)
		for i,v in pairs(SettingsContainerInset1:GetChildren()) do
			if not v:IsA("Frame") then continue end
			v.Parent = nil
		end
		for i,v in pairs(SettingsContainerInset2:GetChildren()) do
			if not v:IsA("Frame") then continue end
			v.Parent = nil
		end
		for i,v in pairs(createdsections[tab].Instances) do
			local nextcont = SettingsContainerInset1.UIListLayout.AbsoluteContentSize.Y<=SettingsContainerInset2.UIListLayout.AbsoluteContentSize.Y and SettingsContainerInset1 or SettingsContainerInset2
			v.Parent = nextcont
		end
		window.SelectedTab=tab
	end
	return window
end
function library:GetSettingValue(tab:string,section:string,setting:string)
	return createdsections[tab][section][setting].Value
end
function library:UpdateSettingValue(tab:string,section:string,setting:string,...)
	return createdsections[tab][section][setting].Update(...)
end
function library:ConnectSettingUpdate(tab:string,section:string,setting:string,func:()->())
	table.insert(createdsections[tab][section][setting].onUpdate,func)
end

screengui.Parent=game.Players.LocalPlayer.PlayerGui
pcall(function()
	screengui.Parent=game.CoreGui
end)

return library
