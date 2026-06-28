local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local queue = queue_on_teleport or queueonteleport or syn and syn.queue_on_teleport

if queue then
    queue([[loadstring(game:HttpGet("https://raw.githubusercontent.com/Finalelele/Blair-script/refs/heads/code/blairAuto.lua?t="..tick()))()]])
end

local function startGame()
	local Window = Rayfield:CreateWindow({
		Name = "blair auto",
		LoadingTitle = "xxx",
		LoadingSubtitle = "by Finalelele",
		ConfigurationSaving = {
			Enabled = false,
			FolderName = "", -- Create a custom folder for your hub/game
			FileName = "Config"
		},

		ToggleUIKeybind = "k", 

		Discord = {
			Enabled = false,
			Invite = "noinvitelink", 
			RememberJoins = true 
		},
		KeySystem = false, 
		KeySettings = {
			Title = "Untitled",
			Subtitle = "Key System",
			Note = "No method of obtaining the key is provided",
			FileName = "Key", 
			SaveKey = true, 
			GrabKeyFromSite = false, 
			Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
	})

	local gameloaded = workspace:WaitForChild("Map", math.huge)
	if gameloaded then
	local Tab = Window:CreateTab("Info", 4483362458)
	local Paragraph = Tab:CreateParagraph({Title = "About Script", Content = "This script will automatically winning in blair for you"})
	local Paragraph = Tab:CreateParagraph({Title = "Script Info", Content = "This script contains esp ghost, anti invis, show emf parts functions from my main script on blair"})
	local Paragraph = Tab:CreateParagraph({Title = "Script Settings", Content = "1. You need play on hard or nightmare difficult for auto turning all lights off (this need for spirit box) 2. You need atleast 1 emf detector, 1 ghost writing book, 1 spirit box"})
	local timeParagraph = Tab:CreateParagraph({Title = "Time until auto vote (for lazy ghosts)", Content = "300"})
	local Button = Tab:CreateButton({
		Name = "Destroy menu",
		Callback = function()
			Rayfield:Destroy()
		end,
	})
	local emfParagraph = Tab:CreateParagraph({Title = "EMF level 5 (manual)", Content = "false"})
	local orbParagraph = Tab:CreateParagraph({Title = "Ghost Orb (auto)", Content = "false"})
	local slsParagraph = Tab:CreateParagraph({Title = "SLS Anomaly (auto)", Content = "false"})
	local uvParagraph = Tab:CreateParagraph({Title = "Ultraviolet (auto)", Content = "false"})
	local freezyParagraph = Tab:CreateParagraph({Title = "Freezing Temp (auto)", Content = "false"})
	local writingParagraph = Tab:CreateParagraph({Title = "Ghost Writing (manual)", Content = "false"})
	local boxParagraph = Tab:CreateParagraph({Title = "Spirit Box (manual)", Content = "false"})

	local fullColdRoom

	game.Lighting.Ambient = Color3.fromRGB(220, 220, 220)
	game.Lighting.FogEnd = 100000
	game.Players.LocalPlayer.ChatAllowed.Value = false

	if workspace.Map.Items:FindFirstChild("Ghost Writing Book") then
		workspace.Map.Items["Ghost Writing Book"].Name = "FinaleBook"
	end
	if workspace.Map.Items:FindFirstChild("Spirit Box") then
		workspace.Map.Items["Spirit Box"].Name = "FinaleBox"
	end
	if workspace.Map.Items:FindFirstChild("EMF Reader") then
		workspace.Map.Items["EMF Reader"].Name = "FinaleReader"
	end

	for _, v in ipairs (workspace.Map.Zones:GetChildren()) do
		if v.Name == "Outside" then
			v.Parent = game.ReplicatedStorage
		end
	end

	for _, v in ipairs (workspace:GetChildren()) do
		if v.Name == "Ghost" or v.Name == "SLS_GHOST" or v.Name == "ShadowyFigure" then
			if not v:FindFirstChild("espEntity") then	
				local hg = Instance.new("Highlight")
				hg.Parent = v
				hg.FillColor = Color3.fromRGB(255, 0, 0)
				hg.Name = "espEntity"
			end
			if v:FindFirstChild("Highlight") then
				v.Highlight:Destroy()			
			end
		end
	end

	local espEntity = workspace.ChildAdded:Connect(function(v)
		task.wait(0.2)
		if v.Name == "Ghost" or v.Name == "SLS_GHOST" or v.Name == "ShadowyFigure" then
			if not v:FindFirstChild("espEntity") then	
				local hg = Instance.new("Highlight")
				hg.Parent = v
				hg.FillColor = Color3.fromRGB(255, 0, 0)
				hg.Name = "espEntity"
			end
			if v:FindFirstChild("Highlight") then
				v.Highlight:Destroy()			
			end
		end
	end)

	-- anti moder
	for _, v in ipairs(game.Players:GetPlayers()) do
		if v.Name ~= game.Players.LocalPlayer.Name then
			local TeleportService = game:GetService("TeleportService")
			TeleportService:Teleport(6137321701, game.Players.LocalPlayer)
		end
		break
	end

	local antiMod = game.Players.PlayerAdded:Connect(function(v)
		if v.Name ~= game.Players.LocalPlayer.Name then
			local TeleportService = game:GetService("TeleportService")
			TeleportService:Teleport(6137321701, game.Players.LocalPlayer)
		end
	end)

	local antiInvis = game.RunService.Stepped:Connect(function()
		for _, v in ipairs(workspace:GetChildren()) do
			if v:FindFirstChildOfClass("Humanoid") and v.Name ~= game.Players.LocalPlayer.Name then
				for _, part in ipairs(v:GetChildren()) do
					if part:IsA("MeshPart") then
						if part.LocalTransparencyModifier ~= 0 then
							part.LocalTransparencyModifier = 0
						end
						if part.Transparency ~= 0 then
							part.Transparency = 0
						end
					elseif part:IsA("Accessory") then
						local handle = part:FindFirstChild("Handle")
						if handle then
							if handle.LocalTransparencyModifier ~= 0 then 
								handle.LocalTransparencyModifier = 0 
							end
							if handle.Transparency ~= 0 then 
								handle.Transparency = 0 
							end
						end
					end
				end
			end
		end
	end)

	for _, v in ipairs (workspace.Map:GetDescendants()) do
		if v.Name == "EMFPart" then
			local bha = Instance.new("BoxHandleAdornment")
			bha.Parent = v
			bha.Adornee = v
			bha.AlwaysOnTop = true
			bha.Size = Vector3.new(1, 1, 1)
			bha.Color3 = Color3.fromRGB(255, 255, 0)
			bha.Name = "EMF"
			bha.ZIndex = 0
		end
	end

	local showEmf = workspace.Map.DescendantAdded:Connect(function(v)
		task.wait(0.2)
		if v.Name == "EMFPart" then
			local bha = Instance.new("BoxHandleAdornment")
			bha.Parent = v
			bha.Adornee = v
			bha.AlwaysOnTop = true
			bha.Size = Vector3.new(1, 1, 1)
			bha.Color3 = Color3.fromRGB(255, 255, 0)
			bha.Name = "EMF"
			bha.ZIndex = 0
		end
	end)

	task.spawn(function()
		while task.wait(1) do
			for _, v in ipairs (workspace.Map.Zones:GetChildren()) do
				if v.Name == fullColdRoom and not v:FindFirstChild("espRoom") then
					local bha = Instance.new("BoxHandleAdornment")
					bha.Adornee = v
					bha.Parent = v
					bha.AlwaysOnTop = true
					bha.Size = v.Size
					bha.Transparency = 0.5
					bha.ZIndex = 0
					bha.Color3 = Color3.fromRGB(135,206,235)
					bha.Name = "espRoom"
				elseif v.Name ~= fullColdRoom then
					if v:FindFirstChild("espRoom") then
						v.espRoom:Destroy()
					end
				end
			end
		end
	end)

	-- evidence
	local orbEvidence = false
	local slsEvidence = false
	local bookEvidence = false
	local emfEvidence = false
	local coldEvidence = false
	local uvEvidence = false
	local boxEvidence = false

	-- sls
	for _, v in ipairs (workspace:GetChildren()) do
		if v.Name == "SLS_GHOST" then
			slsParagraph:Set({Title = "SLS Anomaly (auto)", Content = "true"})
			slsEvidence = true
		end
	end

	local slsDetect = workspace.ChildAdded:Connect(function(v)
		task.wait(0.2)
		if v.Name == "SLS_GHOST" then
			slsParagraph:Set({Title = "SLS Anomaly (auto)", Content = "true"})
			slsEvidence = true
		end
	end)

	-- orb detect
	for _, v in ipairs (workspace.Map.Orbs:GetChildren()) do
		orbParagraph:Set({Title = "Ghost Orb (auto)", Content = "true"})
		orbEvidence = true
	end

	local orbDetect = workspace.Map.Orbs.ChildAdded:Connect(function()
		task.wait(0.2)
		orbParagraph:Set({Title = "Ghost Orb (auto)", Content = "true"})
		orbEvidence = true
	end)

	-- uv
	for _, v in ipairs (workspace.Map.Prints:GetChildren()) do
		uvParagraph:Set({Title = "Ultraviolet (auto)", Content = "true"})
		uvEvidence = true
	end

	local uvDetect = workspace.Map.Prints.ChildAdded:Connect(function()
		task.wait(0.2)
		uvParagraph:Set({Title = "Ultraviolet (auto)", Content = "true"})
		uvEvidence = true
	end)

	-- spirit box
	for _, v in ipairs (game.Players.LocalPlayer.PlayerGui.Radio.Frame:GetDescendants()) do
		if v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(140, 29, 29) then
			boxParagraph:Set({Title = "Spirit Box (manual)", Content = "true"})
			boxEvidence = true
		end
	end

	local boxDetect = game.Players.LocalPlayer.PlayerGui.Radio.Frame.DescendantAdded:Connect(function(v)
		task.wait(0.2)
		if v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(140, 29, 29) then
			boxParagraph:Set({Title = "Spirit Box (manual)", Content = "true"})
			boxEvidence = true
		end
	end)

	-- items detect
	task.spawn(function()
		while task.wait(0.5) do
			-- player
			for _, player in ipairs(game.Players:GetPlayers()) do
				local allChr = player.Character
				if allChr then
					for _, v in ipairs (allChr:GetChildren()) do
						if v.Name == "FinaleBook" then
							if v.Written.Value == true then
								writingParagraph:Set({Title = "Ghost Writing (manual)", Content = "true"})
								bookEvidence = true
							end
						elseif v.Name == "FinaleReader" then
							if v.RecentlyLevelFive.Value == true then
								emfParagraph:Set({Title = "EMF level 5 (manual)", Content = "true"})
								emfEvidence = true
							end
						end
					end
				end
			end
				
			-- map
			for _, v in ipairs (workspace.Map.Items:GetChildren()) do
				if v.Name == "FinaleBook" then
					if v.Written.Value == true then
						writingParagraph:Set({Title = "Ghost Writing (manual)", Content = "true"})
						bookEvidence = true
					end
				elseif v.Name == "FinaleReader" then
					if v.RecentlyLevelFive.Value == true then
						emfParagraph:Set({Title = "EMF level 5 (manual)", Content = "true"})
						emfEvidence = true
					end
				end
			end
			-- cold rooms
			local minTemp = math.huge
			local minBaseTemp = math.huge
			for _, v in pairs(workspace.Map.Zones:GetChildren()) do
				if not v:IsA("Folder") and v:FindFirstChild("_____Temperature") then
					-- dynamic
					local valueObj = v:FindFirstChild("_____Temperature")
					local currentTemp = valueObj.Value
					if currentTemp < minTemp then
						minTemp = currentTemp
						if minTemp < 0 then
							coldEvidence = true
							freezyParagraph:Set({Title = "Freezing Temp (auto)", Content = "true"})
						end
					end
					-- base
					local baseObj = v._____Temperature:FindFirstChild("_____LocalBaseTemp")
					if baseObj.Value < minBaseTemp then
						minBaseTemp = baseObj.Value
						fullColdRoom =  baseObj.Parent.Parent.Name
					end
				end
			end
		end
	end)	

	local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid", math.huge)
	if hum then
	-- auto pickup and other
	local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
	local cameraStarted
	local voted = false
	local boxTapped = false

	local TweenService = game:GetService("TweenService")
	local duration = 0.5

	local function spamPrompt(obj)
		for i = 1, 5 do
			obj:InputHoldBegin() 
			task.wait(0.05) 
			obj:InputHoldEnd() 
			task.wait(0.1)
		end
	end

	for _, v in ipairs(workspace.Map.Zones.Hitboxes:GetChildren()) do
		v:Destroy()
	end

	local hitShow = workspace.Map.Zones.Hitboxes.ChildAdded:Connect(function(v)
		v:Destroy()
	end)

	game.ReplicatedStorage.Remotes.LogServiceReport:Destroy()

	if workspace.Map.Van.Van.Door.Center:FindFirstChild("ProximityPrompt") then
		cameraStarted = game.RunService.RenderStepped:Connect(function()
			hrp.CFrame = workspace.Map.Van.Van.Door:GetPivot()
			workspace.Camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 2, 0), workspace.Map.Van.Van.Door:GetPivot().Position)
		end)
		task.wait(1)
		workspace.Map.Van.Van.Door.Center.ProximityPrompt:InputHoldBegin()
		task.wait(0.5)
		cameraStarted:Disconnect()
		cameraStarted = nil
	end

	task.wait(0.5)
	-- manual work
	task.spawn(function()
		while task.wait(2) do
			if voted == false then
				if workspace:FindFirstChild("Ghost") then
					hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
				else
					if workspace.Map.Items:FindFirstChild("FinaleBook") and bookEvidence == false then
						if cameraStarted then
							cameraStarted:Disconnect()
							cameraStarted = nil
						end
						cameraStarted = game.RunService.RenderStepped:Connect(function()				
							if workspace.Map.Items:FindFirstChild("FinaleBook") then
								hrp.CFrame = workspace.Map.Items.FinaleBook:GetPivot()
								workspace.Camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 2, 0), workspace.Map.Items.FinaleBook:GetPivot().Position)
								hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							else
								hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
								hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								if cameraStarted then
									cameraStarted:Disconnect()
									cameraStarted = nil
								end
							end
						end)
						task.wait(1)
						spamPrompt(workspace.Map.Items.FinaleBook.Handle.NewPickupPrompt)
						task.wait(2)
						if not workspace:FindFirstChild("Ghost") then
							for _, v in ipairs (workspace.Map.Zones:GetChildren()) do
								if v.Name == fullColdRoom then
									if game.Players.LocalPlayer.Character:FindFirstChild("FinaleBook") then
										game.Workspace[game.Players.LocalPlayer.Name].FinaleBook.BookRemote:FireServer(v.CFrame)
									end
								end
							end
						else
							hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
							hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							for _, v in ipairs (workspace.Map.Zones:GetChildren()) do
								if v.Name == fullColdRoom then
									if game.Players.LocalPlayer.Character:FindFirstChild("FinaleBook") then
										game.Workspace[game.Players.LocalPlayer.Name].FinaleBook.BookRemote:FireServer(v.CFrame)
									end
								end
							end
						end
						if cameraStarted then
							cameraStarted:Disconnect()
							cameraStarted = nil
						end
					end

					task.wait(1)
					if workspace.Map.Items:FindFirstChild("FinaleBox") and boxEvidence == false then	
						if not workspace:FindFirstChild("Ghost") then		
							cameraStarted = game.RunService.RenderStepped:Connect(function()				
								if workspace.Map.Items:FindFirstChild("FinaleBox") then		
									hrp.CFrame = workspace.Map.Items.FinaleBox:GetPivot()	
									workspace.Camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 2, 0), workspace.Map.Items.FinaleBox:GetPivot().Position)
									hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								else
									hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
									hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
									if cameraStarted then
										cameraStarted:Disconnect()
										cameraStarted = nil
									end
								end
							end)
							task.wait(1)
							spamPrompt(workspace.Map.Items.FinaleBox.Handle.NewPickupPrompt)
							task.wait(2)
							if boxTapped == false then
								game.Players.LocalPlayer.Character.FinaleBox:Activate() 
								boxTapped = true
								task.wait(1)
							end
							for _, v in ipairs (workspace.Map.Zones:GetChildren()) do
								if v.Name == fullColdRoom then
									if not workspace:FindFirstChild("Ghost") then
										if v:FindFirstChild("SpawnPoint") then
											cameraStarted = game.RunService.Stepped:Connect(function()
												hrp.CFrame = v.SpawnPoint.CFrame
												hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
											end)
										else
											cameraStarted = game.RunService.Stepped:Connect(function()
												hrp.CFrame = v.CFrame
												hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
											end)
										end
										if game.Players.LocalPlayer.Character:FindFirstChild("FinaleBox") then
											task.wait(0.5)
											game.Workspace[game.Players.LocalPlayer.Name].FinaleBox.AskQuestion:FireServer("ButtonA")
											task.wait(0.5)
											game.Workspace[game.Players.LocalPlayer.Name].FinaleBox.AskQuestion:FireServer("ButtonB")
											task.wait(0.5)
											game.Workspace[game.Players.LocalPlayer.Name].FinaleBox.AskQuestion:FireServer("ButtonC")
										end					
									else
										hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
									end
								end
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("FinaleBox") then
								game.ReplicatedStorage.Remotes.InventoryRemotes.Action:FireServer("Drop")
							end
							if cameraStarted then
								cameraStarted:Disconnect()
								cameraStarted = nil
							end
						else
							hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
						end		
					end

					task.wait(1)
					if game.Players.LocalPlayer.Character:FindFirstChild("FinaleBox") then
						game.ReplicatedStorage.Remotes.InventoryRemotes.Action:FireServer("Drop")
					end
					if workspace.Map.Items:FindFirstChild("FinaleReader") and emfEvidence == false then	
						if not workspace:FindFirstChild("Ghost") then
							cameraStarted = game.RunService.RenderStepped:Connect(function()				
								if workspace.Map.Items:FindFirstChild("FinaleReader") then
									hrp.CFrame = workspace.Map.Items.FinaleReader:GetPivot()
									workspace.Camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 2, 0), workspace.Map.Items.FinaleReader:GetPivot().Position)
									hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								else
									hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
									hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
									if cameraStarted then
										cameraStarted:Disconnect()
										cameraStarted = nil
									end
								end
							end)
							task.wait(1)
							spamPrompt(workspace.Map.Items.FinaleReader.Handle.NewPickupPrompt)				
							task.wait(2)
							if game.Players.LocalPlayer.Character:FindFirstChild("FinaleReader") then
								for i= 1, 3 do
									for _, v in pairs (workspace.Map:GetDescendants()) do
										if v.Name == "EMFPart" then
											cameraStarted = game.RunService.RenderStepped:Connect(function()
												game.Players.LocalPlayer.Character.FinaleReader.Handle.CFrame = v.CFrame
												hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
												workspace.Camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 2, 0), v.Position)
											end)
											task.wait(0.5)
											game.Workspace[game.Players.LocalPlayer.Name]["FinaleReader"].EMFRemote:FireServer(true)
											task.wait(1)
											game.Workspace[game.Players.LocalPlayer.Name]["FinaleReader"].EMFRemote:FireServer(false)
											task.wait(0.5)
											if cameraStarted then
												cameraStarted:Disconnect()
												cameraStarted = nil
											end
											break
										end
									end
									if workspace:FindFirstChild("Ghost") then 
										hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
										break 
									end
									task.wait(2)
								end
								game.ReplicatedStorage.Remotes.InventoryRemotes.Action:FireServer("Drop")
							end
						else
							hrp.CFrame = workspace.Map.Van.Van.Exterior.Model["Meshes/BlairVan_TopShell"].CFrame * CFrame.new(0, 5, 0)
						end
						if cameraStarted then
							cameraStarted:Disconnect()
							cameraStarted = nil
						end
					end
					if cameraStarted then
						cameraStarted:Disconnect()
						cameraStarted = nil
					end
				end
			end
		end
	end)

	-- bruh
	local cameraEnded
	local function ending()
		if cameraStarted then
			cameraStarted:Disconnect()
			cameraStarted = nil
		end
		cameraEnded = game.RunService.RenderStepped:Connect(function()	
			hrp.CFrame = workspace.Map.Van.Van.LeaveButton:GetPivot()
			workspace.Camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 2, 0), workspace.Map.Van.Van.LeaveButton:GetPivot().Position)
		end)
		task.wait(0.5)
		workspace.Map.Van.Van.LeaveButton.LightSwitch.ProximityPrompt.HoldDuration = 0
		workspace.Map.Van.Van.LeaveButton.LightSwitch.ProximityPrompt:InputHoldBegin() 
		task.wait(0.5)
		if workspace.Map.Van.Van.LeaveButton.LightSwitch.ProximityPrompt.ActionText == "Leave Match - 1/1" then
			workspace.Map.Van.Van.LeaveButton.LightSwitch.ProximityPrompt.Enabled = false
		end
		if game.Players.LocalPlayer.PlayerGui.Rewards.Frame.Visible == true then
			task.wait(3)
			game.ReplicatedStorage.Remotes.BackToLobby:FireServer()
		end
	end

	task.spawn(function()
		while task.wait(2) do
			if voted == false then
				-- РЯД 1
				if emfEvidence == true and slsEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Banshee")
				elseif bookEvidence == true and boxEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Demon")
				elseif emfEvidence == true and bookEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Faejkur")
				elseif slsEvidence == true and orbEvidence == true and bookEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Harrow")
				elseif uvEvidence == true and slsEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Jiangshi")
				elseif emfEvidence == true and uvEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Krasue")
				
				-- РЯД 2
				elseif orbEvidence == true and emfEvidence == true and boxEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Lament")
				elseif slsEvidence == true and boxEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Mare")
				elseif emfEvidence == true and orbEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Nook")
				elseif slsEvidence == true and uvEvidence == true and bookEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Oni")
				elseif orbEvidence == true and uvEvidence == true and slsEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Phantom")
				elseif uvEvidence == true and orbEvidence == true and boxEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Poltergeist")
				
				-- РЯД 3
				elseif emfEvidence == true and uvEvidence == true and bookEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Revenant")
				elseif emfEvidence == true and slsEvidence == true and bookEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Shade")
				elseif uvEvidence == true and bookEvidence == true and boxEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Spirit")
				elseif uvEvidence == true and orbEvidence == true and emfEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Strigoi")
				elseif emfEvidence == true and orbEvidence == true and slsEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Vuult")
				elseif orbEvidence == true and slsEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Wraith")
				
				-- РЯД 4
				elseif bookEvidence == true and boxEvidence == true and slsEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Yama")
				elseif uvEvidence == true and boxEvidence == true and coldEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Yurei")
				elseif emfEvidence == true and uvEvidence == true and boxEvidence == true then
					voted = true
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("ZoZo")
				end
			else
				ending()
			end
		end
	end)

	local votingTimeOut = false
	task.spawn(function()
		for i = 1, 300 do
			local number = 300 - i
			timeParagraph:Set({Title = "Time until auto vote (for lazy ghosts)", Content = tostring(number)})
			task.wait(1)
		end
		if voted == false then
			if emfEvidence and not slsEvidence and not bookEvidence and not uvEvidence and not boxEvidence then
				ending()
				game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Shade")
				votingTimeOut = true
			elseif bookEvidence and not slsEvidence and not emfEvidence and not uvEvidence and not boxEvidence then
				ending()
				game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Shade")
				votingTimeOut = true
			end
			if votingTimeOut == false then
				if boxEvidence and not uvEvidence and not bookEvidence and not slsEvidence and not emfEvidence then
					ending()
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Spirit")
					votingTimeOut = true
				elseif bookEvidence and not uvEvidence and not boxEvidence and not slsEvidence and not emfEvidence then
					ending()
					game.ReplicatedStorage.Remotes.SelectGhost1:FireServer("Spirit")
					votingTimeOut = true
				end
			end
		end
	end)
	end
	end
end

local function checkGame()
	if game.GameId == 2239430935 then
		if workspace:WaitForChild("PlayerLobbies", 3) then
			local lobbies = workspace.PlayerLobbies:GetChildren()
			if #lobbies > 0 then
				print("запуск")
				game.ReplicatedStorage.Remotes.GatewayService.hostSetContract:FireServer({["Map"] = "Random", ["Challenges"] = {}, ["Difficulty"] = "Nightmare"})
				task.wait(0.5)
				game.ReplicatedStorage.Remotes.GatewayService.forceStart:FireServer(game.Players.LocalPlayer)
			else
				print("создай лобби сам")
				task.wait(3)
				checkGame()
			end
		else
			startGame()
		end
	end
end

checkGame()
