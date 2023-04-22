local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/el-the-mundo/xsx-source-edited/main/source.lua"))()

--variable stuff
local Player = game.Players.LocalPlayer

getgenv().uiversion = 1

local Notif = library:InitNotifications()

for i = 0,0 do
  task.wait(0.05)
  local LoadingXSX = Notif:Notify("Loading Untitled Hub.", 3, "information") -- notification, alert, error, success, information
end

if gamePlaceId == 8651781069 and game.PlaceId == 8651781069 then 
    
getgenv().speedBoostToggle = false
getgenv().oldSpeedBoost = game.Workspace[Player.Name]:GetAttribute("SpeedBoost")
getgenv().newSpeedBoost = nil

getgenv().jumpBoostToggle = false
getgenv().oldJumpBoost = game.Workspace[Player.Name]:GetAttribute("JumpBoost")
getgenv().newJumpBoost = nil

getgenv().disconnectESP = false
getgenv().espFont = 1
getgenv().espSize = 15

  library:Introduction()
  wait(1)
  library.rank = "Private"
  local Wm = library:Watermark("Untitled Hub | v" .. uiversion ..  " | " .. library:GetUsername() .. " | Rank: " .. library.rank)
  local FpsWm = Wm:AddWatermark("FPS: " .. library.fps)
  coroutine.wrap(function()
  while wait(.75) do
    FpsWm:Text("FPS: " .. library.fps)
  end
  end)()

  library.title = "Untitled Hub"
  local Init = library:Init()
  local Tab1 = Init:NewTab("Example tab")
  local MainTab = Init:NewTab("Main")
  local PlayerTab = Init:NewTab("Player")
  local ESPTab = Init:NewTab("ESP")


  local Section1 = Tab1:NewSection("Example Components")
  local PlayerSection = PlayerTab:NewSection("Player")
  local MainSection = MainTab:NewSection("Main")
  local ESPSection = ESPTab:NewSection("ESP")


  local Label1 = Tab1:NewLabel("Example label", "left")--"left", "center", "right"
  local PlayerLabel1 = PlayerTab:NewLabel("Player Modification", "left")--"left", "center", "right"
  local MainLabel1 = MainTab:NewLabel("Farms", "left")--"left", "center", "right"
  local ESPSettingsLabel = ESPTab:NewLabel("ESP Settings", "left")--"left", "center", "right"


  local Toggle1 = Tab1:NewToggle("Example togglezzzzz", false, function(value)
  local vers = value and "on" or "off"
  print("one " .. vers)
  end):AddKeybind(Enum.KeyCode.RightControl)

  local Toggle2 = Tab1:NewToggle("Toggle", false, function(value)
  local vers = value and "on" or "off"
  print("two " .. vers)
  end):AddKeybind(Enum.KeyCode.LeftControl)

  local JumpBoostToggle = PlayerTab:NewToggle("Jump Boost", false, function(value)
  local vers = value and "on" or "off"

  if jumpBoostToggle == true and vers == "off" then
    jumpBoostToggle = false
  end

  if vers == "on" then
    jumpBoostToggle = true
    game.Workspace[Player.Name]:SetAttribute("JumpBoost", newJumpBoost)
  elseif vers == "off" then
    JumpBoostToggle = false
    game.Workspace[Player.Name]:SetAttribute("JumpBoost", oldJumpBoost)
  end
  end)

  local JumpBoostSlider = PlayerTab:NewSlider("", "", true, "/", {min = 0, max = 250, default = 0}, function(value)
  if jumpBoostToggle == true then
    game.Workspace[Player.Name]:SetAttribute("JumpBoost", value)
    newJumpBoost = game.Workspace[Player.Name]:GetAttribute("JumpBoost")
  end

  if jumpBoostToggle == true and not game.Workspace[Player.Name]:SetAttribute("JumpBoost", value) then
    game.Workspace[Player.Name]:SetAttribute("JumpBoost", value)
  end
  end)

  local SpeedBoostToggle = PlayerTab:NewToggle("Speed Boost", false, function(value)
  local vers = value and "on" or "off"

  if speedBoostToggle == true and vers == "off" then
    speedBoostToggle = false
  end

  if vers == "on" then
    speedBoostToggle = true
    game.Workspace.Ijaur:SetAttribute("SpeedBoost", newSpeedBoost)
  elseif vers == "off" then
    speedBoostToggle = false
    game.Workspace.Ijaur:SetAttribute("SpeedBoost", oldSpeedBoost)
  end
  end)

  local SpeedBoostSlider = PlayerTab:NewSlider("", "", true, "/", {min = 0, max = 125, default = 0}, function(value)
  if speedBoostToggle == true then
    game.Workspace[Player.Name]:SetAttribute("SpeedBoost", value)
    getgenv().newSpeedBoost = game.Workspace.Ijaur:GetAttribute("SpeedBoost")
  end

  if speedBoostToggle == true and not game.Workspace[Player.Name]:SetAttribute("SpeedBoost", value) then
    game.Workspace[Player.Name]:SetAttribute("SpeedBoost", value)
  end
  end)

  local Camera = workspace.CurrentCamera
  local runService = game:GetService("RunService")
  local tu = nil


function addToESP(Target, TargetLocation)
	local ESPDrawing = Drawing.new("Text")
	ESPDrawing.Visible = false
	ESPDrawing.Center = true
	ESPDrawing.Outline = true
	ESPDrawing.Color = Color3.fromRGB(159, 115, 255)
	ESPDrawing.Text = Target.Name
    ESPDrawing.Size = espSize
	ESPDrawing.Font = espFont

	local function UpdateESP()
		tu = game:GetService("RunService").RenderStepped:Connect(function()
			if Target and TargetLocation:FindFirstChild(Target.Name) then
				local TargetPosition, Target_Onscreen = Camera:WorldToViewportPoint(Target.Position)
				if Target_Onscreen then
					ESPDrawing.Position = Vector2.new(TargetPosition.X, TargetPosition.Y)
					ESPDrawing.Visible = true
				else
					ESPDrawing.Visible = false
				end
			else
				if Target.Name == nil or disconnectESP == true then
					tu:Disconnect()
				end
				ESPDrawing.Visible = false
			end
        end)
	end
	coroutine.wrap(UpdateESP)()

  
end

  local MobESP = ESPTab:NewToggle("Enable Mob ESP", false, function(value)
  local vers = value and "on" or "off"
  if vers == "on" then
    disconnectESP = false
        for i, mob in pairs(workspace.NPCS:GetChildren()) do
            if mob:IsA("MeshPart") then
              coroutine.wrap(addToESP)(mob, game.Workspace.NPCS)
            end
        end

        workspace.NPCS.ChildAdded:Connect(function(mob)
            if mob:IsA("MeshPart") then
                coroutine.wrap(addToESP)(mob, game.Workspace.NPCS)
            end
        end)
        
    else
        if vers == "off" then
          tu:disconnect()
        end
    end
end)

local ESPFontSize = ESPTab:NewSlider("ESP Font Size", "", true, "/", {min = 1, max = 50, default = 1}, function(value)
    espSize = value
end)

local espFontthing = ESPTab:NewTextbox("ESP Font", "", "(ONLY NUMBERS)", "all", "small", true, false, function(val)
    espFont = tonumber(val)
end)


  local Button1 = Tab1:NewButton("Button", function()
  print("one")
  end)

  local c
  local AutoRuneFarmToggle = MainTab:NewToggle("Auto-Use Rune", false, function(value)
  local vers = value and "on" or "off"
  local HTTP = game:GetService("HttpService")
  local CheckRune = HTTP:JSONDecode(game.Workspace[Player.Name]:GetAttribute("Inflictions"))

  if vers == "on" then
    if not game.Workspace[Player.Name]:FindFirstChild("Sword") then
      Notif:Notify("You must have your sword equipped! Equipping your sword. Re-enable this toggle.", 5)
      wait(1.5)
      keypress(0x31)
      keyrelease(0x31)
      return
    elseif vers == "on" and game.Workspace[Player.Name]:FindFirstChild("Sword") then
      c=game:GetService("RunService").Heartbeat:Connect(function()
      if not CheckRune.Rage then
        game:GetService("ReplicatedStorage").Events.Rune:FireServer()
      end
      end)
    else
      c:disconnect()
    end
  end

  if vers == "off" then
    c:disconnect()
  end

  if vers == "on" then
    game.Workspace[Player.Name].ChildRemoved:Connect(function(Child)
    if Child.Name == "Sword" and vers == "on" then
      c:disconnect()
      Notif:Notify("You have unequipped your sword! Equip your sword then re-enable this toggle.", 5)
    end
    end)
  end
  end)

  --SettingsTab

  local SettingsTab = Init:NewTab("Settings")
  local SettingsSection = SettingsTab:NewSection("Settings")


  local CopyGameIDButton = SettingsTab:NewButton("Copy PlaceId", function()
  library:Copy(game.PlaceId)
  end)

  local CopyGameIDButton = SettingsTab:NewButton("Rejoin", function()
  library:Rejoin()
  end)

  local MenuBind = SettingsTab:NewKeybind("Menu Toggle Bind", Enum.KeyCode.RightAlt, function(key)
  Init:UpdateKeybind(Enum.KeyCode[key])
  end)

  local Textbox1 = SettingsTab:NewTextbox("Set FPS Cap [500 Max]", "", "1-500", "all", "small", true, false, function(val)
  if typeof(val) == "number" then
    library:UnlockFps(val)
  else
    return Notif:Notify("Input has to be a number!", 5)
  end
  end)

  local WMToggle = SettingsTab:NewToggle("Toggle Watermark", true, function(value)
  local vers = value and "on" or "off"
  if vers == "off" then
    Wm:Hide()
  else
    Wm:Show()
  end
  end)

  local ToggleFPSCounter = SettingsTab:NewToggle("Toggle FPS Counter", true, function(value)
  local vers = value and "on" or "off"
  if vers == "off" then
    FpsWm:Hide()
  else
    FpsWm:Show()
  end
  end)


  local Textbox1 = Tab1:NewTextbox("Text box 1 [auto scales // small]", "", "1", "all", "small", true, false, function(val)
  print(val)
  end)

  local Textbox2 = Tab1:NewTextbox("Text box 2 [medium]", "", "2", "all", "medium", true, false, function(val)
  print(val)
  end)

  local Textbox3 = Tab1:NewTextbox("Text box 3 [large]", "", "3", "all", "large", true, false, function(val)
  print(val)
  end)

  local Selector1 = Tab1:NewSelector("Selector 1", "bungie", {"fg", "fge", "fg", "fg"}, function(d)
  print(d)
  end):AddOption("fge")

  local Slider1 = Tab1:NewSlider("Slider 1", "", true, "/", {min = 1, max = 100, default = 20}, function(value)
  print(value)
  end)

  -------

  local FinishedLoading = Notif:Notify("Voxlblade: Loaded!", 5)
elseif gamePlaceId == 8651781069 and game.PlaceId ~= 8651781069 then
     return Notif:Notify("You are not in: Voxlblade!", 5)
elseif gamePlaceId == 8534845015 and game.PlaceId == 8534845015 then
    
  --variables
  local Player = game.Players.LocalPlayer
  local Character = Player.Character or Player.CharacterAdded:Wait()
  getgenv().espFont = 2
  getgenv().espSize = 18
  getgenv().autoFarm = false
      
    library:Introduction()
    wait(1)
    library.rank = "Private"
    local Wm = library:Watermark("Untitled Hub | v" .. uiversion ..  " | " .. library:GetUsername() .. " | Rank: " .. library.rank)
    local FpsWm = Wm:AddWatermark("FPS: " .. library.fps)
    coroutine.wrap(function()
    while wait(.75) do
      FpsWm:Text("FPS: " .. library.fps)
    end
    end)()
  
    library.title = "Untitled Hub"
    local Init = library:Init()
    local Tab1 = Init:NewTab("Example tab")
    local MainTab = Init:NewTab("Main")
    local PlayerTab = Init:NewTab("Player")
    local ESPTab = Init:NewTab("ESP")
  
  
    local Section1 = Tab1:NewSection("Example Components")
    local PlayerSection = PlayerTab:NewSection("Player")
    local MainSection = MainTab:NewSection("Main")
    local ESPSection = ESPTab:NewSection("ESP")
  
  
    local Label1 = Tab1:NewLabel("Example label", "left")--"left", "center", "right"
    local PlayerLabel1 = PlayerTab:NewLabel("Player Modification", "left")--"left", "center", "right"
    local MainLabel1 = MainTab:NewLabel("Farms", "left")--"left", "center", "right"
    local ESPSettingsLabel = ESPTab:NewLabel("ESP Settings", "left")--"left", "center", "right"
    local Toggle1 = Tab1:NewToggle("Example toggle", false, function(value)
    local vers = value and "on" or "off"
    print("one " .. vers)
    end):AddKeybind(Enum.KeyCode.RightControl)
  
    local Toggle2 = Tab1:NewToggle("Toggle", false, function(value)
    local vers = value and "on" or "off"
    print("two " .. vers)
    end):AddKeybind(Enum.KeyCode.LeftControl)
    
    local AutoFarmToggle = MainTab:NewToggle("Enable Auto-Farm", false, function(value)
    local vers = value and "on" or "off"
    local farm = nil
    if vers == "on" then
        end
    end)
  
    local Camera = workspace.CurrentCamera
    local runService = game:GetService("RunService")
    local tu = nil
  
  
  function addToESP1(Target, TargetLocation)
    local ESPDrawing = Drawing.new("Text")
    ESPDrawing.Visible = false
    ESPDrawing.Center = true
    ESPDrawing.Outline = true
    ESPDrawing.Color = Color3.fromRGB(159, 115, 255)
    ESPDrawing.Text = Target.Name
      ESPDrawing.Size = espSize
    ESPDrawing.Font = espFont
  
    local function UpdateESP()
      tu = game:GetService("RunService").RenderStepped:Connect(function()
        if Target and TargetLocation:FindFirstChild(Target.Name) then
          local TargetPosition, Target_Onscreen = Camera:WorldToViewportPoint(Target.Position)
          if Target_Onscreen then
            ESPDrawing.Position = Vector2.new(TargetPosition.X, TargetPosition.Y)
            ESPDrawing.Visible = true
          else
            ESPDrawing.Visible = false
          end
        else
          if Target.Name == nil then
            tu:Disconnect()
          end
          ESPDrawing.Visible = false
        end
          end)
    end
    coroutine.wrap(UpdateESP)()
  end
      
      
    local Blahlabel1 = MainTab:NewLabel("TPs", "left")--"left", "center", "right"
    local TPToLibrary = MainTab:NewButton("Teleport To Library", function()
        keypress(0x46)
        Character.HumanoidRootPart.CFrame = CFrame.new(-30.031395, -116.369606, 328.73584)
        keyrelease(0x46)
    end)
    
    local Blahlabel2 = MainTab:NewLabel("Miscellaneous", "left")--"left", "center", "right"
    local QuickSellBox = MainTab:NewTextbox("Quick Sell Items", "", "SELLABLE ITEMS: Rokakaka, Arrow, Haunted Sword, Bomu Bomu Devil Fruit, Mysterious Camera, Stop Sign, Spin Manual, Mochi Mochi Devil Fruit, Hamon Manual, Stone Mask, Barrel, Bari Bari Devil Fruit", "all", "large", true, false, function(val)
        game:GetService("ReplicatedStorage").GlobalUsedRemotes.SellItem:FireServer(tostring(val))
    end)
  
  
  
    local ItemESP = ESPTab:NewToggle("Enable Item ESP", false, function(value)
    local vers = value and "on" or "off"
    if vers == "on" then
          for i, item in pairs(workspace.Item:GetChildren()) do
               coroutine.wrap(addToESP1)(item, game.Workspace.Item)
          end
  
          workspace.Item.ChildAdded:Connect(function(item)
               coroutine.wrap(addToESP1)(item, game.Workspace.Item)
          end)
      end
  end)
  
  local ESPFontSize = ESPTab:NewSlider("ESP Font Size", "", true, "/", {min = 1, max = 50, default = 1}, function(value)
      espSize = value
  end)
  
  local espFontthing = ESPTab:NewTextbox("ESP Font", "", "(ONLY NUMBERS)", "all", "small", true, false, function(val)
      espFont = tonumber(val)
  end)
  
  
    local Button1 = Tab1:NewButton("Button", function()
    print("one")
    end)
    --SettingsTab
  
    local SettingsTab = Init:NewTab("Settings")
    local SettingsSection = SettingsTab:NewSection("Settings")
  
  
    local CopyGameIDButton = SettingsTab:NewButton("Copy PlaceId", function()
    library:Copy(game.PlaceId)
    end)
  
    local CopyGameIDButton = SettingsTab:NewButton("Rejoin", function()
    library:Rejoin()
    end)
  
    local MenuBind = SettingsTab:NewKeybind("Menu Toggle Bind", Enum.KeyCode.RightAlt, function(key)
    Init:UpdateKeybind(Enum.KeyCode[key])
    end)
  
    local Textbox1 = SettingsTab:NewTextbox("Set FPS Cap [500 Max]", "", "1-500", "all", "small", true, false, function(val)
    if typeof(val) == "number" then
      library:UnlockFps(val)
    else
      return Notif:Notify("Input has to be a number!", 5)
    end
    end)
  
    local WMToggle = SettingsTab:NewToggle("Toggle Watermark", true, function(value)
    local vers = value and "on" or "off"
    if vers == "off" then
      Wm:Hide()
    else
      Wm:Show()
    end
    end)
  
    local ToggleFPSCounter = SettingsTab:NewToggle("Toggle FPS Counter", true, function(value)
    local vers = value and "on" or "off"
    if vers == "off" then
      FpsWm:Hide()
    else
      FpsWm:Show()
    end
    end)
  
  
    local Textbox1 = Tab1:NewTextbox("Text box 1 [auto scales // small]", "", "1", "all", "small", true, false, function(val)
    print(val)
    end)
  
    local Textbox2 = Tab1:NewTextbox("Text box 2 [medium]", "", "2", "all", "medium", true, false, function(val)
    print(val)
    end)
  
    local Textbox3 = Tab1:NewTextbox("Text box 3 [large]", "", "3", "all", "large", true, false, function(val)
    print(val)
    end)
  
    local Selector1 = Tab1:NewSelector("Selector 1", "bungie", {"fg", "fge", "fg", "fg"}, function(d)
    print(d)
    end):AddOption("fge")
  
    local Slider1 = Tab1:NewSlider("Slider 1", "", true, "/", {min = 1, max = 100, default = 20}, function(value)
    print(value)
    end)
  
    local FinishedLoading = Notif:Notify("Sakura Stand: Loaded!", 5)
elseif gamePlaceId == 8534845015 and game.PlaceId ~= 8534845015 then
  return Notif:Notify("You are not in: Sakura Stand!", 5)
elseif gamePlaceId == 10046661315 and game.PlaceId == 10046661315 then
    --variables
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
getgenv().espFont = 2
getgenv().espSize = 18
getgenv().autoFarm = false
    
  library:Introduction()
  wait(1)
  library.rank = "Private"
  local Wm = library:Watermark("Untitled Hub | v" .. uiversion ..  " | " .. library:GetUsername() .. " | Rank: " .. library.rank)
  local FpsWm = Wm:AddWatermark("FPS: " .. library.fps)
  coroutine.wrap(function()
  while wait(.75) do
    FpsWm:Text("FPS: " .. library.fps)
  end
  end)()

  library.title = "Untitled Hub"
  local Init = library:Init()
  local Tab1 = Init:NewTab("Example tab")
  local MainTab = Init:NewTab("Main")
  local PlayerTab = Init:NewTab("Player")
  local ESPTab = Init:NewTab("ESP")


  local Section1 = Tab1:NewSection("Example Components")
  local PlayerSection = PlayerTab:NewSection("Player")
  local MainSection = MainTab:NewSection("Main")
  local ESPSection = ESPTab:NewSection("ESP")


  local Label1 = Tab1:NewLabel("Example label", "left")--"left", "center", "right"
  local PlayerLabel1 = PlayerTab:NewLabel("Player Modification", "left")--"left", "center", "right"
  local MainLabel1 = MainTab:NewLabel("Farms", "left")--"left", "center", "right"
  local ESPSettingsLabel = ESPTab:NewLabel("ESP Settings", "left")--"left", "center", "right"
  local Toggle1 = Tab1:NewToggle("Example toggle", false, function(value)
  local vers = value and "on" or "off"
  print("one " .. vers)
  end):AddKeybind(Enum.KeyCode.RightControl)

  local NoFallToggle = PlayerTab:NewToggle("Enable No-Fall", false, function(value)
    local vers = value and "on" or "off"
        if vers == "on" then
           local fallDamageRemote = Character.CharacterHandler.Remotes:FindFirstChild("ApplyFallDamage")
           local oldName
           if fallDamageRemote then
            oldName = Instance.new("Folder")
            oldName.Parent = fallDamageRemote
            oldName.Name = fallDamageRemote.Name
 
            fallDamageRemote.Name = "v"
           end
        else
          local fallDamageRemote = Character.CharacterHandler.Remotes:FindFirstChild("ApplyFallDamage")
          if fallDamageRemote then
            if falldamageEvent:FindFirstChild("ApplyFallDamage") then
             falldamageEvent.Name = falldamageEvent.ApplyFallDamage.Name
             falldamageEvent.ApplyFallDamage:Destroy()
            end
          end
        end
    end)
  
  local AutoFarmToggle = MainTab:NewToggle("Enable Auto-Farm", false, function(value)
  local vers = value and "on" or "off"
  local farm = nil
  if vers == "on" then
      end
  end)

  local Camera = workspace.CurrentCamera
  local runService = game:GetService("RunService")
  local tu = nil


function addToESP1(Target, TargetLocation)
	local ESPDrawing = Drawing.new("Text")
	ESPDrawing.Visible = false
	ESPDrawing.Center = true
	ESPDrawing.Outline = true
	ESPDrawing.Color = Color3.fromRGB(159, 115, 255)
	ESPDrawing.Text = Target.Name
    ESPDrawing.Size = espSize
	ESPDrawing.Font = espFont

	local function UpdateESP()
		tu = game:GetService("RunService").RenderStepped:Connect(function()
			if Target and TargetLocation:FindFirstChild(Target.Name) then
				local TargetPosition, Target_Onscreen = Camera:WorldToViewportPoint(Target.Position)
				if Target_Onscreen then
					ESPDrawing.Position = Vector2.new(TargetPosition.X, TargetPosition.Y)
					ESPDrawing.Visible = true
				else
					ESPDrawing.Visible = false
				end
			else
				if Target.Name == nil then
					tu:Disconnect()
				end
				ESPDrawing.Visible = false
			end
        end)
	end
	coroutine.wrap(UpdateESP)()
end
    
    
  local Blahlabel1 = MainTab:NewLabel("TPs", "left")--"left", "center", "right"
  local TPToLibrary = MainTab:NewButton("Teleport To Library", function()
      keypress(0x46)
      Character.HumanoidRootPart.CFrame = CFrame.new(-30.031395, -116.369606, 328.73584)
      keyrelease(0x46)
  end)
  
  local Blahlabel2 = MainTab:NewLabel("Miscellaneous", "left")--"left", "center", "right"
  local QuickSellBox = MainTab:NewTextbox("Quick Sell Items", "", "SELLABLE ITEMS: Rokakaka, Arrow, Haunted Sword, Bomu Bomu Devil Fruit, Mysterious Camera, Stop Sign, Spin Manual, Mochi Mochi Devil Fruit, Hamon Manual, Stone Mask, Barrel, Bari Bari Devil Fruit", "all", "large", true, false, function(val)
      game:GetService("ReplicatedStorage").GlobalUsedRemotes.SellItem:FireServer(tostring(val))
  end)



  local ItemESP = ESPTab:NewToggle("Enable Item ESP", false, function(value)
  local vers = value and "on" or "off"
  if vers == "on" then
        for i, item in pairs(workspace.Item:GetChildren()) do
             coroutine.wrap(addToESP1)(item, game.Workspace.Item)
        end

        workspace.Item.ChildAdded:Connect(function(item)
             coroutine.wrap(addToESP1)(item, game.Workspace.Item)
        end)
    end
end)

local ESPFontSize = ESPTab:NewSlider("ESP Font Size", "", true, "/", {min = 1, max = 50, default = 1}, function(value)
    espSize = value
end)

local espFontthing = ESPTab:NewTextbox("ESP Font", "", "(ONLY NUMBERS)", "all", "small", true, false, function(val)
    espFont = tonumber(val)
end)


  local Button1 = Tab1:NewButton("Button", function()
  print("one")
  end)
  --SettingsTab

  local SettingsTab = Init:NewTab("Settings")
  local SettingsSection = SettingsTab:NewSection("Settings")


  local CopyGameIDButton = SettingsTab:NewButton("Copy PlaceId", function()
  library:Copy(game.PlaceId)
  end)

  local CopyGameIDButton = SettingsTab:NewButton("Rejoin", function()
  library:Rejoin()
  end)

  local MenuBind = SettingsTab:NewKeybind("Menu Toggle Bind", Enum.KeyCode.RightAlt, function(key)
  Init:UpdateKeybind(Enum.KeyCode[key])
  end)

  local Textbox1 = SettingsTab:NewTextbox("Set FPS Cap [500 Max]", "", "1-500", "all", "small", true, false, function(val)
  if typeof(val) == "number" then
    library:UnlockFps(val)
  else
    return Notif:Notify("Input has to be a number!", 5)
  end
  end)

  local WMToggle = SettingsTab:NewToggle("Toggle Watermark", true, function(value)
  local vers = value and "on" or "off"
  if vers == "off" then
    Wm:Hide()
  else
    Wm:Show()
  end
  end)

  local ToggleFPSCounter = SettingsTab:NewToggle("Toggle FPS Counter", true, function(value)
  local vers = value and "on" or "off"
  if vers == "off" then
    FpsWm:Hide()
  else
    FpsWm:Show()
  end
  end)


  local Textbox1 = Tab1:NewTextbox("Text box 1 [auto scales // small]", "", "1", "all", "small", true, false, function(val)
  print(val)
  end)

  local Textbox2 = Tab1:NewTextbox("Text box 2 [medium]", "", "2", "all", "medium", true, false, function(val)
  print(val)
  end)

  local Textbox3 = Tab1:NewTextbox("Text box 3 [large]", "", "3", "all", "large", true, false, function(val)
  print(val)
  end)

  local Selector1 = Tab1:NewSelector("Selector 1", "bungie", {"fg", "fge", "fg", "fg"}, function(d)
  print(d)
  end):AddOption("fge")

  local Slider1 = Tab1:NewSlider("Slider 1", "", true, "/", {min = 1, max = 100, default = 20}, function(value)
  print(value)
  end)

  local FinishedLoading = Notif:Notify("Rogue Lineage Script: Loaded!", 5)
end

-- // FUNCTION DOCS:
--[[
MAIN COMPONENT DOCS:

-- // local library = loadstring(game:HttpGet(link: url))()
-- // library.title = text: string
-- // local Window = library:Init()

-- [library.title contains rich text]

-- / library:Remove()
-- destroys the library

-- / library:Text("new")
-- sets the lbrary's text to something new

- / library:UpdateKeybind(Enum.KeyCode.RightAlt)
-- sets the lbrary's keybind to switch visibility to something new

__________________________

-- // local notificationLibrary = library:InitNotifications()
-- // local Notification = notificationLibrary:Notify(text: string, time: number, type: string (information, notification, alert, error, success))

-- [Notify contains rich text]

-- / 3rd argument is a function, used like this:

Notif:Notify("Function notification", 7, function()
print("done")
end)

-- / Welcome:Text("new text")
-- sets the notifications text to something differet [ADDS A +0.4 ONTO YOUR TIMER]

__________________________

-- // local Wm = library:Watermark(text: string)

-- [Watermark contains rich text]

-- / Wm:Hide()
-- hides the watermark from eye view

-- / Wm:Show()
-- makes the watermark visible at the top of your screen

-- / Wm:Text("new")
-- sets the watermark's text to something new

-- / Wm:Remove()
-- destroys the watermark

__________________________

-- // local Tab1 = Init:NewTab(text: string)

-- [tab title contains rich text]

-- / Tab1:Open()
-- opens the tab you want

-- / Tab1:Remove()
-- destroys the tab

-- / Tab1:Hide()
-- hides the tab from eye view

-- / Tab1:Show()
-- makes the tab visible on the selection table

-- / Tab1:Text("new")
-- sets the tab's text to something new

__________________________

-- [label contains rich text]

-- / Label1:Text("new")
-- sets the label's text to something new

-- / Label1:Remove()
-- destroys the label

-- / Label1:Hide()
-- hides the label from eye view

-- / Label1:Show()
-- makes the tab visible on the page that is used

-- / Label1:Align("le")
-- aligns the label to a new point in text X

__________________________

-- [Button contains rich text]

-- / Button1:AddButton("text", function() end)
-- adds a new button inside of the frame [CAN ONLY GO UP TO 4 BUTTONS AT A TIME]

-- / Button1:Fire()
-- executes the script within the button

-- / Button1:Text("new")
-- sets the button's text to something new

-- / Button1:Hide()
-- hides the button from eye view

-- / Button1:Show()
-- makes the button visible

-- / Button1:Remove()
-- destroys the button

__________________________

-- [Sections contain rich text]

-- / Section1:Text("new")
-- sets the section's text to something new

-- / Section1:Hide()
-- hides the section from eye view

-- / Section1:Show()
-- makes the section visible

-- / Section1:Remove()
-- destroys the section

__________________________

-- [Toggles contain rich text]

-- / Toggle1:Text("new")
-- sets the toggle's text to something new

-- / Toggle1:Hide()
-- hides the toggle from eye view

-- / Toggle1:Show()
-- makes the toggle visible

-- / Toggle1:Remove()
-- destroys the toggle

-- / Toggle1:Change()
-- changes the toggles state to the opposite

-- / Toggle1:Set(true)
-- sets the toggle to true even if it is true

-- / Toggle1:AddKeybind(Enum.KeyCode.P, false, function() end) -- false / true is used for just changing the toggles state
-- adds a keybind to the toggle

-- / Toggle1:SetFunction(function() end)
-- sets the toggles function

__________________________

-- [Keybinds contain rich text]

-- / Keybind1:Text("new")
-- sets the keybind's text to something new

-- / Keybind1:Hide()
-- hides the keybind from eye view

-- / Keybind1:Show()
-- makes the keybind visible

-- / Keybind1:Remove()
-- destroys the keybind

-- / Keybind1:SetKey(Enum.KeyCode.P)
-- sets the keybinds new key

-- / Keybind1:Fire()
-- fires the keybind function

-- / Keybind1:SetFunction(function() end)
-- sets the new keybind function

__________________________

-- [Textboxes contain rich text]

-- / Textbox1:Input("new")
-- sets the text box's input to something new

-- / Textbox1:Place("new")
-- sets the text box's placeholder to something new

-- / Textbox1:Fire()
-- fires the textbox function

-- / Textbox1:SetFunction(function() end)
-- sets the text boxes new function

-- / Textbox1:Text("new")
-- sets the textbox's text to something new

-- / Textbox1:Hide()
-- hides the textbox from eye view

-- / Textbox1:Show()
-- makes the textbox visible

-- / Textbox1:Remove()
-- destroys the textbox

__________________________

-- [Selectors contain rich text]

-- / Selector1:SetFunction(function() end)
-- sets the selector new function

-- / Selector1:Text("new")
-- sets the selector's text to something new

-- / Selector1:Hide()
-- hides the selector from eye view

-- / Selector1:Show()
-- makes the selector visible

-- / Selector1:Remove()
-- destroys the selector

__________________________

-- [Sliders contain rich text]

-- / Slider1:Value(1)
-- sets the slider new value

-- / Slider1:SetFunction(function() end)
-- sets the slider new function

-- / Slider1:Text("new")
-- sets the slider's text to something new

-- / Slider1:Hide()
-- hides the slider from eye view

-- / Slider1:Show()
-- makes the slider visible

-- / Slider1:Remove()
-- destroys the slider

---------------------------------------------------------------------------------------------------------

MISC SEMI USELESS DOCS:

-- / library.rank = ""
-- returns the rank you choose (default = "private")

-- / library.fps
-- returns FPS you're getting in game

-- / library.version
-- returns the version of the library

-- / library.title = ""
-- returns the title of the library

-- / library:GetDay("word") -- word, short, month, year
-- returns the os day

-- / library:GetTime("24h") -- 24h, 12h, minute, half, second, full, ISO, zone
-- returns the os time

-- / library:GetMonth("word") -- word, short, digit
-- returns the os month

-- / library:GetWeek("year_S") -- year_S, day, year_M
-- returns the os week

-- / library:GetYear("digits") -- digits, full
-- returns the os year

-- / library:GetUsername()
-- returns the localplayers username

-- / library:GetUserId()
-- returns the localplayers userid

-- / library:GetPlaceId()
-- returns the games place id

-- / library:GetJobId()
-- returns the games job id

-- / library:CheckIfLoaded()
-- returns true if you're fully loaded

-- / library:Rejoin()
-- rejoins the same server as you was in

-- / library:Copy("stuff")
-- copies the inputed string

-- / library:UnlockFps(500) -- only works with synapse
-- sets the max fps to something you choose

-- / library:PromptDiscord("invite")
-- invites you to a discord
]]--