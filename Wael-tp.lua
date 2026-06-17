-- TP Saver Script (Mobile + PC)
local savedPosition = nil
local savedSpawn = nil
local looping = false
local spawnMode = false
local spawnApplied = false
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TPSaver"
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
titleLabel.Text = "🔵 TP Saver"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Bouton principal 1 (Save TP / Save Spawn)
local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(1, -20, 0, 30)
saveButton.Position = UDim2.new(0, 10, 0, 40)
saveButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
saveButton.Text = "💾 Save TP"
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.TextSize = 13
saveButton.Font = Enum.Font.GothamBold
saveButton.BorderSizePixel = 0
saveButton.Parent = mainFrame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 6)
saveCorner.Parent = saveButton

-- Bouton principal 2 (Teleport / Apply)
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(1, -20, 0, 30)
tpButton.Position = UDim2.new(0, 10, 0, 75)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
tpButton.Text = "⚡ Teleport"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 13
tpButton.Font = Enum.Font.GothamBold
tpButton.BorderSizePixel = 0
tpButton.Parent = mainFrame

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 6)
tpCorner.Parent = tpButton

-- Bouton gris (mode spawn) au dessus du rouge
local spawnModeButton = Instance.new("TextButton")
spawnModeButton.Size = UDim2.new(0, 24, 0, 24)
spawnModeButton.Position = UDim2.new(1, -28, 1, -56)
spawnModeButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
spawnModeButton.Text = ""
spawnModeButton.BorderSizePixel = 0
spawnModeButton.Parent = mainFrame

local spawnModeCorner = Instance.new("UICorner")
spawnModeCorner.CornerRadius = UDim.new(0, 4)
spawnModeCorner.Parent = spawnModeButton

local spawnModeIcon = Instance.new("TextLabel")
spawnModeIcon.Size = UDim2.new(1, 0, 1, 0)
spawnModeIcon.BackgroundTransparency = 1
spawnModeIcon.Text = "🏠"
spawnModeIcon.TextSize = 13
spawnModeIcon.Font = Enum.Font.GothamBold
spawnModeIcon.Parent = spawnModeButton

-- Bouton rouge loop en bas à droite
local loopButton = Instance.new("TextButton")
loopButton.Size = UDim2.new(0, 24, 0, 24)
loopButton.Position = UDim2.new(1, -28, 1, -28)
loopButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
loopButton.Text = ""
loopButton.BorderSizePixel = 0
loopButton.Parent = mainFrame

local loopCorner = Instance.new("UICorner")
loopCorner.CornerRadius = UDim.new(0, 4)
loopCorner.Parent = loopButton

local loopIcon = Instance.new("TextLabel")
loopIcon.Size = UDim2.new(1, 0, 1, 0)
loopIcon.BackgroundTransparency = 1
loopIcon.Text = "↺"
loopIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
loopIcon.TextSize = 16
loopIcon.Font = Enum.Font.GothamBold
loopIcon.Parent = loopButton

-- Logique bouton gris (switch mode)
spawnModeButton.MouseButton1Click:Connect(function()
    spawnMode = not spawnMode

    if spawnMode then
        -- Passer en mode Spawn
        spawnModeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        saveButton.Text = "🏠 Save Spawn"
        saveButton.BackgroundColor3 = Color3.fromRGB(150, 80, 200)
        tpButton.Text = "✅ Apply"
        tpButton.BackgroundColor3 = Color3.fromRGB(200, 140, 0)
        spawnApplied = false
    else
        -- Revenir en mode TP normal
        spawnModeButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        saveButton.Text = "💾 Save TP"
        saveButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        tpButton.Text = "⚡ Teleport"
        tpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        spawnApplied = false
    end
end)

-- Logique Save TP / Save Spawn
saveButton.MouseButton1Click:Connect(function()
    local character = localPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if spawnMode then
            savedSpawn = character.HumanoidRootPart.CFrame
            saveButton.Text = "✅ Spawn saved !"
            task.wait(1.5)
            saveButton.Text = "🏠 Save Spawn"
        else
            savedPosition = character.HumanoidRootPart.CFrame
            saveButton.Text = "✅ saved position !"
            task.wait(1.5)
            saveButton.Text = "💾 Save TP"
        end
    end
end)

-- Connexion spawn personnalisé
local spawnConnection = nil

local function activateCustomSpawn()
    if spawnConnection then
        spawnConnection:Disconnect()
        spawnConnection = nil
    end
    spawnConnection = localPlayer.CharacterAdded:Connect(function(character)
        if spawnApplied and savedSpawn then
            task.wait() -- attendre que le perso charge
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            if hrp then
                hrp.CFrame = savedSpawn
            end
        end
    end)
end

-- Logique Teleport / Apply
tpButton.MouseButton1Click:Connect(function()
    if spawnMode then
        if not savedSpawn then
            tpButton.Text = "❌ Aucun spawn !"
            task.wait(1.5)
            tpButton.Text = "✅ Apply"
            return
        end
        spawnApplied = not spawnApplied
        if spawnApplied then
            activateCustomSpawn()
            tpButton.Text = "🟢 Appliqué !"
            task.wait(1.5)
            tpButton.Text = "🔴 Désactiver"
        else
            tpButton.Text = "⚪ Désactivé"
            task.wait(1.5)
            tpButton.Text = "✅ Appliquer"
        end
    else
        if savedPosition then
            local character = localPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = savedPosition
            end
        else
            tpButton.Text = "❌ Aucune position !"
            task.wait(1.5)
            tpButton.Text = "⚡ Teleport"
        end
    end
end)

-- Logique Loop TP
loopButton.MouseButton1Click:Connect(function()
    if not looping then
        if not savedPosition then return end
        looping = true
        loopButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        loopIcon.Text = "■"
        task.spawn(function()
            while looping do
                local character = localPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = savedPosition
                end
                task.wait(0.2)
            end
        end)
    else
        looping = false
        loopButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        loopIcon.Text = "↺"
    end
end)

-- Système de drag universel (PC + Mobile)
local dragging = false
local dragStart, startPos

local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end

local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end

local function onInputChanged(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement or
        input.UserInputType == Enum.UserInputType.Touch
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
