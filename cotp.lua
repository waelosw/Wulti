-- Position Display Script (Mobile + PC)
local savedPosition = nil
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PosDisplay"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 160)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Barre de titre draggable
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
titleLabel.Text = "📍 Position Display"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Label affichage position actuelle
local currentPosLabel = Instance.new("TextLabel")
currentPosLabel.Size = UDim2.new(1, -20, 0, 35)
currentPosLabel.Position = UDim2.new(0, 10, 0, 35)
currentPosLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
currentPosLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
currentPosLabel.TextSize = 11
currentPosLabel.Font = Enum.Font.Gotham
currentPosLabel.Text = "X: --  Y: --  Z: --"
currentPosLabel.TextWrapped = true
currentPosLabel.BorderSizePixel = 0
currentPosLabel.Parent = mainFrame

local currentCorner = Instance.new("UICorner")
currentCorner.CornerRadius = UDim.new(0, 6)
currentCorner.Parent = currentPosLabel

-- Label affichage position sauvegardée
local savedPosLabel = Instance.new("TextLabel")
savedPosLabel.Size = UDim2.new(1, -20, 0, 35)
savedPosLabel.Position = UDim2.new(0, 10, 0, 75)
savedPosLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
savedPosLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
savedPosLabel.TextSize = 11
savedPosLabel.Font = Enum.Font.Gotham
savedPosLabel.Text = "💾 Sauvegardé : --"
savedPosLabel.TextWrapped = true
savedPosLabel.BorderSizePixel = 0
savedPosLabel.Parent = mainFrame

local savedCorner = Instance.new("UICorner")
savedCorner.CornerRadius = UDim.new(0, 6)
savedCorner.Parent = savedPosLabel

-- Bouton Save TP
local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(0.48, -5, 0, 30)
saveButton.Position = UDim2.new(0, 10, 0, 118)
saveButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
saveButton.Text = "💾 Save TP"
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.TextSize = 12
saveButton.Font = Enum.Font.GothamBold
saveButton.BorderSizePixel = 0
saveButton.Parent = mainFrame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 6)
saveCorner.Parent = saveButton

-- Bouton Teleport
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0.48, -5, 0, 30)
tpButton.Position = UDim2.new(0.5, 5, 0, 118)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
tpButton.Text = "⚡ Teleport"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 12
tpButton.Font = Enum.Font.GothamBold
tpButton.BorderSizePixel = 0
tpButton.Parent = mainFrame

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 6)
tpCorner.Parent = tpButton

-- Mise à jour position actuelle en temps réel
task.spawn(function()
    while true do
        local character = localPlayer.Character
        if character then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local p = hrp.Position
                currentPosLabel.Text = string.format(
                    "📍 X: %.2f  Y: %.2f  Z: %.2f",
                    p.X, p.Y, p.Z
                )
            end
        end
        task.wait(0.1)
    end
end)

-- Logique Save TP → affiche les coords sauvegardées
saveButton.MouseButton1Click:Connect(function()
    local character = localPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        savedPosition = character.HumanoidRootPart.CFrame
        local p = character.HumanoidRootPart.Position
        savedPosLabel.Text = string.format(
            "💾 X: %.2f  Y: %.2f  Z: %.2f",
            p.X, p.Y, p.Z
        )
        saveButton.Text = "✅ Sauvé !"
        task.wait(1.5)
        saveButton.Text = "💾 Save TP"
    end
end)

-- Logique Teleport → TP vers position sauvegardée
tpButton.MouseButton1Click:Connect(function()
    if savedPosition then
        local character = localPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = savedPosition
        end
    else
        tpButton.Text = "❌ Rien sauvé !"
        task.wait(1.5)
        tpButton.Text = "⚡ Teleport"
    end
end)

-- Drag (PC + Mobile)
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
