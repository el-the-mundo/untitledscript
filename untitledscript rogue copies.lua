-- Credits To The Original Devs @xz, @goof
getgenv().Config = {
	Invite = "richminion",
	Version = "1",
}

getgenv().luaguardvars = {
	DiscordName = "username#0000",
}

-- variables
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
getgenv().walkSpeedToggle = false

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Other/main/Lmao.lua"))()

library:init() -- Initalizes Library Do Not Delete This


if gamePlaceId == 8651781069 and game.PlaceID == 8651781069 then
	local Window = library.NewWindow({
		title = "untitled hub private",
		size = UDim2.new(0, 525, 0, 650)
	})
	
	local tabs = {
		Tab1 = Window:AddTab("Tab1"),
		Settings = library:CreateSettingsTab(Window),
	}
	
	-- 1 = Set Section Box To The Left
	-- 2 = Set Section Box To The Right
	
	local sections = {
		Section1 = tabs.Tab1:AddSection("Section1", 1),
		Section2 = tabs.Tab1:AddSection("Section2", 2),
	}
	
	sections.Section1:AddSeparator({
		text = "Player"
	})
	
	sections.Section1:AddToggle({
		enabled = true,
		text = "Max Edict (Golden Name)",
		flag = "Toggle_1",
		tooltip = "Tooltip1",
		risky = false, -- turns text to red and sets label to risky
		callback = function(lol)
			if lol == true then
				Player.leaderstats.MaxEdict.Value = true
			else
				if lol == false then
					Player.leaderstats.MaxEdict.Value = false
				end
			end
		end
	})		
	library:SendNotification("Voxlblade: Loaded!", 5, Color3.new(255, 0, 0))
else
	library:SendNotification("You are not in: Voxlblade! Copying Voxlblade Place ID...", 5, Color3.new(255, 0, 0))
	setclipboard(8651781069)
elseif gamePlaceId == 9978746069 and game.PlaceId == 9978746069 then
		local Window = library.NewWindow({
			title = "untitled hub private",
			size = UDim2.new(0, 525, 0, 650)
		})
		
		local tabs = {
			Tab1 = Window:AddTab("Tab1"),
			Settings = library:CreateSettingsTab(Window),
		}
		
		-- 1 = Set Section Box To The Left
		-- 2 = Set Section Box To The Right
		
		local sections = {
			Section1 = tabs.Tab1:AddSection("Section1", 1),
			Section2 = tabs.Tab1:AddSection("Section2", 2),
		}
		
		sections.Section1:AddSeparator({
			text = "Player"
		})
		
		sections.Section1:AddToggle({
			enabled = true,
			text = "Max Edict (Golden Name)",
			flag = "Toggle_1",
			tooltip = "Tooltip1",
			risky = false, -- turns text to red and sets label to risky
			callback = function(lol)
				if lol == true then
					Player.leaderstats.MaxEdict.Value = true
				else
					if lol == false then
						Player.leaderstats.MaxEdict.Value = false
					end
				end
			end
		})
		
		local c
		sections.Section1:AddToggle({
			enabled = true,
			text = "Anti-Fire",
			flag = "Puts out flames",
			tooltip = "Tooltip1",
			risky = false, -- turns text to red and sets label to risky
			callback = function(lol)
				if lol then
					pcall(function()
						c:disconnect()
					end)
					c=Character.ChildAdded:Connect(function(child)
						if child.Name == "Burning" and lol == true then
							Character.CharacterHandler.Remotes.Dodge:FireServer(game.Players.LocalPlayer)
						end
					end)
				elseif not lol then
					c:disconnect()
				end
			end
		})
		
		sections.Section1:AddButton({
			enabled = true,
			text = "Knock Self",
			flag = "Button_1",
			tooltip = "Tooltip1",
			risky = false,
			confirm = false, -- shows confirm button
			callback = function(v)
				game.Workspace.Live[Player.Name].CharacterHandler.Remotes.ApplyFallDamage:FireServer(300)
			end
		})
		
		sections.Section1:AddButton({
			enabled = true,
			text = "Take Life",
			flag = "Button_1",
			tooltip = "May not work in some games",
			risky = false,
			confirm = true, -- shows confirm button
			callback = function(v)
				game.Workspace.Live[Player.Name].CharacterHandler.Remotes.ApplyFallDamage:FireServer(9999999)
			end
		})
		
		sections.Section1:AddSeparator({
			text = "Separator"
		})
		
		sections.Section1:AddToggle({
			enabled = true, 
			text = "Speed",
			flag = "Toggle_1",
			tooltip = "Tooltip1",
			risky = true, -- turns text to red and sets label to risky
			callback = function(lol)
				getgenv().walkSpeedToggle = lol
				print("Toggle Is Now Set To : ".. tostring(getgenv().walkSpeedToggle))
			end
		})
		
		sections.Section1:AddSlider({
			text = "Walkspeed Value", 
			flag = 'Slider_1', 
			suffix = "", 
			value = 0.000,
			min = 0, 
			max = 100,
			increment = 1,
			tooltip = "Tooltip1",
			risky = false,
			callback = function(v)
				if walkSpeedToggle == true and not (game.Workspace.Live[Player.Name].Boosts:FindFirstChild("SpeedBoost")) then
					local WalkSpeedBoost = Instance.new("NumberValue")
					WalkSpeedBoost.Name = "SpeedBoost"
					WalkSpeedBoost.Value = v
					WalkSpeedBoost.Parent = game.Workspace.Live[Player.Name].Boosts
				  elseif not walkSpeedToggle and game.Workspace.Live[Player.Name].Boosts:FindFirstChild("SpeedBoost") then
					   for i, v in pairs (game.Workspace.Live[Player.Name]:GetChildren()) do
							if v.Name == "SpeedBoost" and walkSpeedToggle == false  then
								   v:Destroy()
							   end
							  end
						  end
				  print("Slider Value Is Now : ".. v)
			  end
		})
		
		sections.Section1:AddBind({
			text = "Keybind",
			flag = "Key_1",
			nomouse = true,
			noindicator = true,
			tooltip = "Tooltip1",
			mode = "toggle",
			bind = Enum.KeyCode.Q,
			risky = false,
			keycallback = function(v)
				print("Keybind Changed!")
			end
		})
		
		sections.Section1:AddList({
			enabled = true,
			text = "List",
			flag = "List_1",
			multi = false,
			tooltip = "Tooltip1",
			risky = false,
			dragging = false,
			focused = false,
			value = "1",
			values = {
				"1",
				"2",
				"3"
			},
			callback = function(v)
				print("List Value Is Now : "..v)
			end
		})
		
		sections.Section1:AddBox({
			enabled = true,
			focused = true,
			text = "TextBox1",
			input = "PlaceHolder1",
			flag = "Text_1",
			risky = false,
			callback = function(v)
				print(v)
			end
		})
		
		sections.Section1:AddText({
			enabled = true,
			text = "Text1",
			flag = "Text_1",
			risky = false,
		})
		
		sections.Section1:AddColor({
			enabled = true,
			text = "ColorPicker1",
			flag = "Color_1",
			tooltip = "ToolTip1",
			color = Color3.new(255, 255, 255),
			trans = 0,
			open = false,
			callback = function()
				
			end
		})
		
		sections.Section1:AddSeparator({
			text = "Streamer Mode"
		})
		
		
		sections.Section1:AddToggle({
			enabled = true,
			text = "Hide Name",
			flag = "Toggle_1",
			tooltip = "Tooltip1",
			risky = false, -- turns text to red and sets label to risky
			callback = function(lol)
				if lol then
					Player.leaderstats.Hidden.Value = true
					if not Player.PlayerGui:FindFirstChild("StatGui").Container.CharacterName.Visible then
						Player.PlayerGui:FindFirstChild("StatGui").Container.CharacterName.Visible = true
					end
				else
					if not lol then
						Player.leaderstats.Hidden.Value = false
						Player.PlayerGui:FindFirstChild("StatGui").Container.CharacterName.Visible = false
					end
				end
			end
		})
	library:SendNotification("RL: Richest Minion: Gaia: Loaded!", 5, Color3.new(255, 0, 0))
	else
		library:SendNotification("You are not in: RL: Richest Minion: Gaia! Copying PlaceId to clipboard...", 5, Color3.new(255, 0, 0))
		setclipboard("niggarqtest")
end



--Window:SetOpen(true) -- Either Close Or Open Window