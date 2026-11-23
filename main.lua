
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "lashzty"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = player:WaitForChild("PlayerGui")

-- Главное окно
local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.fromOffset(300, 155)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
frame.BorderSizePixel = 0
frame.ZIndex = 999
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 25)
corner.Parent = frame

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(255, 65, 185)
outline.Thickness = 3
outline.Parent = frame

-- Ник
local nickname = Instance.new("TextLabel")
nickname.Size = UDim2.new(1, -60, 0, 45)
nickname.Position = UDim2.new(0, 10, 0, 20)
nickname.BackgroundTransparency = 1
nickname.Text = "lashzty"
nickname.TextColor3 = Color3.fromRGB(255, 90, 195)
nickname.TextSize = 28
nickname.Font = Enum.Font.GothamBold
nickname.ZIndex = 1000
nickname.Parent = frame

-- Надпись
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -15, 0, 40)
subtitle.Position = UDim2.new(0, 7, 0, 75)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Бустик от 50 валюток"
subtitle.TextColor3 = Color3.fromRGB(255, 100, 200)
subtitle.TextSize = 19
subtitle.Font = Enum.Font.GothamBold
subtitle.ZIndex = 1000
subtitle.Parent = frame

-- Кнопка замка
local locked = false

local lockButton = Instance.new("TextButton")
lockButton.Size = UDim2.fromOffset(38, 38)
lockButton.Position = UDim2.new(1, -48, 0, 12)
lockButton.BackgroundColor3 = Color3.fromRGB(55, 25, 50)
lockButton.Text = "🔓"
lockButton.TextSize = 21
lockButton.ZIndex = 1002
lockButton.Parent = frame

local lockCorner = Instance.new("UICorner")
lockCorner.CornerRadius = UDim.new(0, 10)
lockCorner.Parent = lockButton

lockButton.Activated:Connect(function()
    locked = not locked
    lockButton.Text = locked and "🔒" or "🔓"
    outline.Color = locked
        and Color3.fromRGB(255, 190, 80)
        or Color3.fromRGB(255, 65, 185)
end)

-- Перетаскивание
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if locked then return end

    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and not locked then
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
