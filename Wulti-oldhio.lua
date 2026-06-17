-- OHIO TP Script (Mobile + PC)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Vérification du jeu Ohio
local GAME_ID = 7239319209 -- ID du jeu Ohio sur Roblox
if game.PlaceId ~= GAME_ID then
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WrongGame"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.CoreGui

    local errFrame = Instance.new("Frame")
    errFrame.Size = UDim2.new(0, 240, 0, 70)
    errFrame.Position = UDim2.new(0.5, -120, 0.5, -35)
    errFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    errFrame.BorderSizePixel = 0
    errFrame.Parent = screenGui

    local errCorner = Instance.new("UICorner")
    errCorner.CornerRadius = UDim.new(0, 8)
    errCorner.Parent = errFrame

    local errLabel = Instance.new("TextLabel")
    errLabel.Size = UDim2.new(1, -20, 1, 0)
    errLabel.Position = UDim2.new(0, 10, 0, 0)
    errLabel.BackgroundTransparency = 1
    errLabel.Text = "❌ Ce script fonctionne\nuniquement sur Ohio !"
    errLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    errLabel.TextSize = 13
    errLabel.Font = Enum.Font.GothamBold
    errLabel.TextWrapped = true
    errLabel.Parent = errFrame

    task.wait(4)
    screenGui:Destroy()
    return
end

local destinations = {
    { emoji = "👮", label = "Police",      x = 653.01,  y = 9.04,  z = -902.65  },
    { emoji = "🪑", label = "Meubles",     x = 898.81,  y = 6.25,  z = -767.10  },
    { emoji = "🏦", label = "Banque cash", x = 1116.74, y = 8.22,  z = -328.11  },
    { emoji = "🪖", label = "Militaire",   x = 727.41,  y = 65.02, z = -1399.14 },
    { emoji = "💎", label = "Diamant",     x = 1603.73, y = 8.37,  z = -694.60  },
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WULTI TP"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 30 + 40 + (#destinations * 44) + 10)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -((30 + 40 + (#destinations * 44) + 10) / 2))
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
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
titleLabel.Text = "🗺️ Wulti TP"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local lastTPLabel = Instance.new("TextLabel")
lastTPLabel.Size = UDim2.new(1, -20, 0, 30)
lastTPLabel.Position = UDim2.new(0, 10, 0, 35)
lastTPLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
lastTPLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
lastTPLabel.TextSize = 11
lastTPLabel.Font = Enum.Font.Gotham
lastTPLabel.Text = "🕓 Dernier TP : aucun"
lastTPLabel.TextWrapped = true
lastTPLabel.BorderSizePixel = 0
lastTPLabel.Parent = mainFrame

local lastTPCorner = Instance.new("UICorner")
lastTPCorner.CornerRadius = UDim.new(0, 6)
lastTPCorner.Parent = lastTPLabel

local colors = {
    Color3.fromRGB(0, 120, 255),
    Color3.fromRGB(180, 100, 0),
    Color3.fromRGB(0, 170, 100),
    Color3.fromRGB(120, 0, 200),
    Color3.fromRGB(200, 160, 0),
}

for i, dest in ipairs(destinations) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.Position = UDim2.new(0, 10, 0, 30 + 40 + (i - 1) * 42)
    btn.BackgroundColor3 = colors[i] or Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Text = dest.emoji .. "  " .. dest.label
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local originalText = btn.Text

    btn.MouseButton1Click:Connect(function()
        local character = localPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(dest.x, dest.y, dest.z)
            lastTPLabel.Text = "🕓 Dernier TP : " .. dest.emoji .. " " .. dest.label
            btn.Text = "✅ Téléporté !"
            task.wait(1.2)
            btn.Text = originalText
        end
    end)
end

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
