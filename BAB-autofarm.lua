
-- Auto Farm Script (même interface que TP Saver)
local farming = false
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local waypoints = {
    Vector3.new(-25.06,  44.58,  1256.25),
    Vector3.new(-56.92,  50.00,  2034.41),
    Vector3.new(-41.48,  50.85,  2804.28),
    Vector3.new(-45.77,  65.75,  3570.05),
    Vector3.new(-45.52,  62.15,  4303.33),
    Vector3.new(-60.80,  48.69,  5127.00),
    Vector3.new(-38.92,  38.83,  5882.12),
    Vector3.new(-52.49,  43.52,  6624.59),
    Vector3.new(-28.03,  39.63,  7390.51),
    Vector3.new(-35.64,  54.82,  8180.87),
    Vector3.new(-31.34,  15.96,  8561.56),
    Vector3.new(-61.18,   9.74,  8689.88),
    Vector3.new(-55.09, -243.98, 8993.90),
    Vector3.new(-56.43, -347.12, 9488.66),
}

-- ===================== GUI =====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarm"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 110)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -55)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Barre de titre
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local patch = Instance.new("Frame")
patch.Size = UDim2.new(1, 0, 0, 10)
patch.Position = UDim2.new(0, 0, 1, -10)
patch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
patch.BorderSizePixel = 0
patch.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🟢 Auto Farm"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Bouton Auto Farm
local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(1, -20, 0, 30)
farmButton.Position = UDim2.new(0, 10, 0, 40)
farmButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
farmButton.Text = "🌾 Auto Farm"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.TextSize = 13
farmButton.Font = Enum.Font.GothamBold
farmButton.BorderSizePixel = 0
farmButton.Parent = mainFrame

local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 6)
farmCorner.Parent = farmButton

-- Bouton Stop
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(1, -20, 0, 30)
stopButton.Position = UDim2.new(0, 10, 0, 75)
stopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopButton.Text = "⛔ Stop"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.TextSize = 13
stopButton.Font = Enum.Font.GothamBold
stopButton.BorderSizePixel = 0
stopButton.Parent = mainFrame

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 6)
stopCorner.Parent = stopButton

-- ===================== LOGIQUE =====================
local function flyTo(hrp, target)
    local startPos = hrp.Position
    local elapsed = 0
    local travelTime = 2

    local connection
    connection = RunService.Heartbeat:Connect(function(dt)
        elapsed = elapsed + dt
        local alpha = math.clamp(elapsed / travelTime, 0, 1)
        hrp.CFrame = CFrame.new(startPos:Lerp(target, alpha))
        hrp.AssemblyLinearVelocity = Vector3.zero
        if alpha >= 1 then
            connection:Disconnect()
        end
    end)
    task.wait(travelTime)
end

farmButton.MouseButton1Click:Connect(function()
    if farming then return end
    farming = true
    farmButton.Text = "✅ En cours..."
    farmButton.BackgroundColor3 = Color3.fromRGB(0, 130, 200)

    task.spawn(function()
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")

        -- Téléport au point de départ
        hrp.CFrame = CFrame.new(waypoints[1])
        task.wait(0.5)

        humanoid.PlatformStand = true

        -- Parcours UNIQUE (plus de boucle infinie)
        for i = 2, #waypoints do
            if not farming then break end
            flyTo(hrp, waypoints[i])
        end

        -- Fin automatique
        farming = false
        humanoid.PlatformStand = false

        farmButton.Text = "✅ Terminé"
        farmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)

        task.wait(2)

        farmButton.Text = "🌾 Auto Farm"
        farmButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end)
end)

stopButton.MouseButton1Click:Connect(function()
    farming = false
    farmButton.Text = "🌾 Auto Farm"
    farmButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

-- ===================== DRAG (PC + Mobile) =====================
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement or
        input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
