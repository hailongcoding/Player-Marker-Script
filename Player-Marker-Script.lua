-- FULL ESP + NAME + HP + **TOTAL CLEANUP ON CLOSE**!
-- Click X → GUI + ALL ESP + ALL LOOPS = **COMPLETELY GONE**!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local espBoxes = {}
local espNames = {}
local ESP_ALL = true
local MULTI_ESP_PLAYERS = {}
local PlayerColors = {}

-- === STOP FLAGS (to kill loops) ===
local RUNNING = true

-- MAIN GUI
local sg = Instance.new("ScreenGui")
sg.Name = "ESP"
sg.ResetOnSpawn = false
sg.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Parent = sg
frame.Size = UDim2.new(0, 400, 0, 540)
frame.Position = UDim2.new(0, 10, 0.5, -270)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Parent = frame
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.new(0, 0.6, 1)

local title = Instance.new("TextLabel")
title.Parent = titleBar
title.Size = UDim2.new(1, -50, 1, 0)
title.BackgroundTransparency = 1
title.Text = "FULL ESP + NAME + HP"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0, 10, 0, 0)

-- CLOSE BUTTON (NOW KILLS EVERYTHING!)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = titleBar
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 24
closeBtn.MouseButton1Click:Connect(function()
    RUNNING = false           -- Stop all loops
    sg:Destroy()              -- Remove GUI
    -- FULL CLEANUP
    for _, p in pairs(Players:GetPlayers()) do
        if espBoxes[p] then
            for _, box in pairs(espBoxes[p]) do pcall(function() box:Destroy() end) end
            espBoxes[p] = nil
        end
        if espNames[p] then
            pcall(function() espNames[p].billboard:Destroy() end)
            espNames[p] = nil
        end
    end
    print("ESP FULLY CLOSED & CLEANED!")
end)

-- TOGGLE ESP ALL
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = frame
toggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
toggleBtn.Position = UDim2.new(0.05, 0, 0, 50)
toggleBtn.BackgroundColor3 = Color3.new(0, 1, 0)
toggleBtn.Text = "ESP ALL: ON"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextSize = 18

-- Input + Add
local input = Instance.new("Username")
input.Parent = frame
input.Size = UDim2.new(0.6, 0, 0, 35)
input.Position = UDim2.new(0.05, 0, 0, 100)
input.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
input.PlaceholderText = "Player name"
input.TextColor3 = Color3.new(1,1,1)
input.TextSize = 16

local addBtn = Instance.new("TextButton")
addBtn.Parent = frame
addBtn.Size = UDim2.new(0.3, 0, 0, 35)
addBtn.Position = UDim2.new(0.67, 0, 0, 100)
addBtn.BackgroundColor3 = Color3.new(0, 0.8, 0)
addBtn.Text = "ADD"
addBtn.TextColor3 = Color3.new(1,1,1)
addBtn.TextSize = 16

-- Player List
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Parent = frame
playerListFrame.Size = UDim2.new(0.9, 0, 0, 250)
playerListFrame.Position = UDim2.new(0.05, 0, 0, 145)
playerListFrame.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
playerListFrame.ScrollBarThickness = 8

-- Clear + Status
local clearBtn = Instance.new("TextButton")
clearBtn.Parent = frame
clearBtn.Size = UDim2.new(0.9, 0, 0, 35)
clearBtn.Position = UDim2.new(0.05, 0, 0, 410)
clearBtn.BackgroundColor3 = Color3.new(1, 0, 0)
clearBtn.Text = "CLEAR ALL"
clearBtn.TextColor3 = Color3.new(1,1,1)
clearBtn.TextSize = 16

local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(0.9, 0, 0, 40)
status.Position = UDim2.new(0.05, 0, 0, 455)
status.BackgroundTransparency = 1
status.Text = "Click X = FULL CLEANUP!"
status.TextColor3 = Color3.new(0, 1, 0)
status.TextSize = 14

-- FULL BODY PARTS
local BODY_PARTS = {
    "Head","UpperTorso","LowerTorso",
    "LeftUpperArm","LeftLowerArm","LeftHand",
    "RightUpperArm","RightLowerArm","RightHand",
    "LeftUpperLeg","LeftLowerLeg","LeftFoot",
    "RightUpperLeg","RightLowerLeg","RightFoot",
    "Torso","Left Arm","Right Arm","Left Leg","Right Leg"
}

-- ESP FUNCTIONS
local function clearESP(plr)
    if espBoxes[plr] then
        for _, box in pairs(espBoxes[plr]) do pcall(function() box:Destroy() end) end
        espBoxes[plr] = nil
    end
    if espNames[plr] then
        pcall(function() espNames[plr].billboard:Destroy() end)
        espNames[plr] = nil
    end
end

local function createNameHP(plr)
    local char = plr.Character
    if not char or not char:FindFirstChild("Head") then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPNameHP"
    billboard.Parent = char.Head
    billboard.Size = UDim2.new(0, 250, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = billboard
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = plr.Name .. " | HP: " .. math.floor(humanoid.Health)
    nameLabel.TextColor3 = Color3.new(1,1,1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0,0,0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 16
    
    espNames[plr] = {billboard = billboard, label = nameLabel, humanoid = humanoid}
end

local function updateNameHP(plr)
    local data = espNames[plr]
    if not data then return end
    local humanoid = data.humanoid
    if humanoid and humanoid.Health > 0 then
        data.label.Text = plr.Name .. " | HP: " .. math.floor(humanoid.Health)
        local hpPercent = humanoid.Health / humanoid.MaxHealth
        data.label.TextColor3 = hpPercent > 0.5 and Color3.new(0,1,0) or 
                               (hpPercent > 0.25 and Color3.new(1,1,0) or Color3.new(1,0,0))
    end
end

local function addESP(plr)
    if plr == LocalPlayer then return end
    clearESP(plr)
    local char = plr.Character
    if not char then return end
    
    local color = PlayerColors[plr.Name] or Color3.new(1,1,1)
    espBoxes[plr] = {}
    
    for _, partName in pairs(BODY_PARTS) do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = part
            box.Size = part.Size + Vector3.new(0.2, 0.2, 0.2)
            box.Color3 = color
            box.Transparency = 0.2
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Parent = part
            table.insert(espBoxes[plr], box)
        end
    end
    
    createNameHP(plr)
end

local function updateESP()
    if not RUNNING then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if ESP_ALL or table.find(MULTI_ESP_PLAYERS, p) then
                addESP(p)
            else
                clearESP(p)
            end
        end
    end
end

-- Player List Buttons
local nextY = 5
local function createPlayerButton(plr)
    local btn = Instance.new("TextButton")
    btn.Parent = playerListFrame
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, nextY)
    btn.BackgroundColor3 = Color3.new(0.4, 0.4, 0.8)
    btn.Text = plr.DisplayName .. " (@ " .. plr.Name .. ")"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    
    local colorPreview = Instance.new("Frame")
    colorPreview.Parent = btn
    colorPreview.Size = UDim2.new(0, 20, 0, 20)
    colorPreview.Position = UDim2.new(1, -25, 0.5, -10)
    colorPreview.BackgroundColor3 = PlayerColors[plr.Name] or Color3.new(1,1,1)
    colorPreview.BorderSizePixel = 1
    
    local lastClick = 0
    local colorIndex = 1
    local colors = {Color3.new(1,0,0), Color3.new(0,1,0), Color3.new(0,0.6,1), Color3.new(1,1,0), Color3.new(1,0,1)}
    
    btn.MouseButton1Click:Connect(function()
        local now = tick()
        if now - lastClick < 0.3 then
            for i, v in pairs(MULTI_ESP_PLAYERS) do
                if v == plr then table.remove(MULTI_ESP_PLAYERS, i) end
            end
            btn:Destroy()
            clearESP(plr)
            nextY = nextY - 40
            playerListFrame.CanvasSize = UDim2.new(0, 0, 0, nextY)
        else
            colorIndex = colorIndex + 1
            if colorIndex > #colors then colorIndex = 1 end
            PlayerColors[plr.Name] = colors[colorIndex]
            colorPreview.BackgroundColor3 = colors[colorIndex]
            addESP(plr)
        end
        lastClick = now
    end)
    
    nextY = nextY + 40
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, nextY)
end

-- EVENTS
toggleBtn.MouseButton1Click:Connect(function()
    ESP_ALL = not ESP_ALL
    toggleBtn.Text = ESP_ALL and "ESP ALL: ON" or "ESP ALL: OFF"
    toggleBtn.BackgroundColor3 = ESP_ALL and Color3.new(0,1,0) or Color3.new(1,0,0)
    updateESP()
end)

addBtn.MouseButton1Click:Connect(function()
    local name = input.Text:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if (p.Name:lower():find(name) or p.DisplayName:lower():find(name)) and p ~= LocalPlayer then
            if not table.find(MULTI_ESP_PLAYERS, p) then
                table.insert(MULTI_ESP_PLAYERS, p)
                createPlayerButton(p)
                addESP(p)
                status.Text = "Added: " .. p.Name
                input.Text = ""
                return
            end
        end
    end
    status.Text = "Not found"
end)

clearBtn.MouseButton1Click:Connect(function()
    MULTI_ESP_PLAYERS = {}
    PlayerColors = {}
    playerListFrame:ClearAllChildren()
    nextY = 5
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    for _, p in pairs(Players:GetPlayers()) do clearESP(p) end
    updateESP()
    status.Text = "Cleared"
end)

input.FocusLost:Connect(function(enter)
    if enter then addBtn.MouseButton1Click:Fire() end
end)

-- HP UPDATE LOOP (stops when closed)
spawn(function()
    while RUNNING and wait(0.3) do
        for plr, data in pairs(espNames) do
            if plr and plr.Parent then
                updateNameHP(plr)
            end
        end
    end
end)

-- MAIN UPDATE LOOP (stops when closed)
spawn(function()
    while RUNNING and wait(1) do
        updateESP()
    end
end)

-- PLAYER EVENTS
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function()
            if RUNNING then spawn(function() wait(0.5); updateESP() end) end
        end)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer and RUNNING then
        p.CharacterAdded:Connect(function()
            spawn(function() wait(0.5); updateESP() end)
        end)
    end
end)

updateESP()
print("ESP LOADED - Click X = FULL SHUTDOWN!")
