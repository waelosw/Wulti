-- Loop TP Script (avec vérification de jeu)

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- 🔒 GAME ID CHECK (comme Ohio script)
local GAME_ID = 114697347887839

if game.PlaceId ~= GAME_ID then
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WrongGame"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 80)
    frame.Position = UDim2.new(0.5, -130, 0.5, -40)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Text = "❌ Ce script fonctionne\nuniquement dans le bon jeu !"
    label.TextColor3 = Color3.fromRGB(255,80,80)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.Parent = frame

    task.wait(4)
    screenGui:Destroy()
    return
end

-- 📍 POSITION TP
local TARGET_CFRAME = CFrame.new(-10661.78, 514.65, -255.62)

-- GUI
local looping = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoopTP"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 110)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -55)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,8)

-- BARRE TITRE
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,30)
titleBar.BackgroundColor3 = Color3.fromRGB(50,50,50)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,8)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,0,1,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔵 Loop TP"
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- LOOP BUTTON
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(1,-20,0,30)
startButton.Position = UDim2.new(0,10,0,40)
startButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
startButton.Text = "▶️ Loop TP"
startButton.TextColor3 = Color3.fromRGB(255,255,255)
startButton.TextSize = 13
startButton.Font = Enum.Font.GothamBold
startButton.BorderSizePixel = 0
startButton.Parent = mainFrame

Instance.new("UICorner", startButton).CornerRadius = UDim.new(0,6)

-- STOP BUTTON
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(1,-20,0,30)
stopButton.Position = UDim2.new(0,10,0,75)
stopButton.BackgroundColor3 = Color3.fromRGB(0,200,100)
stopButton.Text = "⏹️ Stop"
stopButton.TextColor3 = Color3.fromRGB(255,255,255)
stopButton.TextSize = 13
stopButton.Font = Enum.Font.GothamBold
stopButton.BorderSizePixel = 0
stopButton.Parent = mainFrame

Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0,6)

-- TP FUNCTION
local function teleportPlayer()
    local character = localPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = TARGET_CFRAME
    end
end

-- LOOP START
startButton.MouseButton1Click:Connect(function()
    if looping then return end
    looping = true

    task.spawn(function()
        while looping do
            teleportPlayer()
            task.wait(0.2)
        end
    end)
end)

-- LOOP STOP
stopButton.MouseButton1Click:Connect(function()
    looping = false
end)

-- DRAG
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function()
    dragging = false
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then

        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
