-- Loop TP Script (Delta Executor)

local looping = false
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local TARGET_CFRAME = CFrame.new(
    -10661.78,
    514.65,
    -255.62
)

-- GUI
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

-- Barre titre
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,30)
titleBar.BackgroundColor3 = Color3.fromRGB(50,50,50)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,8)

local patch = Instance.new("Frame")
patch.Size = UDim2.new(1,0,0,10)
patch.Position = UDim2.new(0,0,1,-10)
patch.BackgroundColor3 = Color3.fromRGB(50,50,50)
patch.BorderSizePixel = 0
patch.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,0,1,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔵 Loop TP"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Bouton Loop TP
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(1,-20,0,30)
startButton.Position = UDim2.new(0,10,0,40)
startButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
startButton.Text = "▶️ Loop TP"
startButton.TextColor3 = Color3.new(1,1,1)
startButton.TextSize = 13
startButton.Font = Enum.Font.GothamBold
startButton.BorderSizePixel = 0
startButton.Parent = mainFrame

Instance.new("UICorner", startButton).CornerRadius = UDim.new(0,6)

-- Bouton Stop
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(1,-20,0,30)
stopButton.Position = UDim2.new(0,10,0,75)
stopButton.BackgroundColor3 = Color3.fromRGB(0,200,100)
stopButton.Text = "⏹️ Stop"
stopButton.TextColor3 = Color3.new(1,1,1)
stopButton.TextSize = 13
stopButton.Font = Enum.Font.GothamBold
stopButton.BorderSizePixel = 0
stopButton.Parent = mainFrame

Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0,6)

-- Bouton fermer (en haut à droite)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0,24,0,24)
closeButton.Position = UDim2.new(1,-28,0,3)
closeButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.BorderSizePixel = 0
closeButton.Parent = mainFrame

Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0,4)

-- Fonction TP
local function teleportPlayer()
    local character = localPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = TARGET_CFRAME
    end
end

-- Start Loop
startButton.MouseButton1Click:Connect(function()
    if looping then return end

    looping = true
    startButton.Text = "✅ Loop actif"

    task.spawn(function()
        while looping do
            teleportPlayer()
            task.wait(0.2)
        end
    end)
end)

-- Stop Loop
stopButton.MouseButton1Click:Connect(function()
    looping = false
    startButton.Text = "▶️ Loop TP"
end)

-- Fermer UI
closeButton.MouseButton1Click:Connect(function()
    looping = false
    screenGui:Destroy()
end)

-- Drag PC + Mobile
local dragging = false
local dragStart
local startPos

local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end

local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end

local function onInputChanged(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end

titleBar.InputBegan:Connect(onInputBegan)
titleBar.InputEnded:Connect(onInputEnded)
UserInputService.InputChanged:Connect(onInputChanged)
