-- Bloxburg Auto Farm GUI (Mobile Compatible with Auto-Resize)
-- Made for KRNL, optimized for iPhone and general mobile devices

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFarmGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main frame with padding and scaling
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

-- UI Corner rounding
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Bloxburg AutoFarm"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 22
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.AnchorPoint = Vector2.new(0, 0)
TitleLabel.Position = UDim2.new(0.05, 0, 0.03, 0)
TitleLabel.Size = UDim2.new(0.9, 0, 0.07, 0)
TitleLabel.Parent = MainFrame

-- Container for buttons
local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
ButtonsFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
ButtonsFrame.Parent = MainFrame

-- UIListLayout for buttons vertical alignment
local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ButtonsFrame
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 12)

-- Button creation helper
local function CreateButton(text)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Size = UDim2.new(1, 0, 0, 48)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Text = text
    btn.AutoButtonColor = true
    btn.Name = text:gsub("%s", "")
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    btn.Parent = ButtonsFrame
    return btn
end

-- Buttons
local AutoFarmButton = CreateButton("Toggle Auto Farm")
local AutoDeliveryButton = CreateButton("Toggle Auto Delivery")
local CloseButton = CreateButton("Close GUI")

-- State variables
local autoFarmOn = false
local autoDeliveryOn = false

-- Placeholder autofarm functionality (replace with actual automation logic)
local function AutoFarmToggle()
    autoFarmOn = not autoFarmOn
    AutoFarmButton.Text = autoFarmOn and "Auto Farm: ON" or "Toggle Auto Farm"
    if autoFarmOn then
        spawn(function()
            while autoFarmOn do
                -- Example: Farm logic here
                wait(2)
            end
        end)
    end
end

local function AutoDeliveryToggle()
    autoDeliveryOn = not autoDeliveryOn
    AutoDeliveryButton.Text = autoDeliveryOn and "Auto Delivery: ON" or "Toggle Auto Delivery"
    if autoDeliveryOn then
        spawn(function()
            while autoDeliveryOn do
                -- Example: Delivery logic here
                wait(3)
            end
        end)
    end
end

-- Button events
AutoFarmButton.MouseButton1Click:Connect(AutoFarmToggle)
AutoDeliveryButton.MouseButton1Click:Connect(AutoDeliveryToggle)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Dragging support for mouse and touch input
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        math.clamp(startPos.X.Scale + delta.X / workspace.CurrentCamera.ViewportSize.X, 0, 1 - MainFrame.Size.X.Scale),
        startPos.X.Offset + delta.X,
        math.clamp(startPos.Y.Scale + delta.Y / workspace.CurrentCamera.ViewportSize.Y, 0, 1 - MainFrame.Size.Y.Scale),
        startPos.Y.Offset + delta.Y
    )
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Auto resize logic based on aspect ratio
local function onResize()
    local aspectRatio = workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y

    if aspectRatio < 0.5 then
        -- Very tall screen (like some phones in portrait)
        MainFrame.Size = UDim2.new(0.8, 0, 0.6, 0)
        MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
    elseif aspectRatio < 0.7 then
        -- Tall phone or small tablet portrait
        MainFrame.Size = UDim2.new(0.6, 0, 0.6, 0)
        MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
    elseif aspectRatio < 1 then
        -- Portrait phone/tablet standard
        MainFrame.Size = UDim2.new(0.5, 0, 0.7, 0)
        MainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
    elseif aspectRatio < 1.5 then
        -- Landscape phones, smaller tablets
        MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
        MainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
    else
        -- Wide desktop or large tablet landscape
        MainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
        MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
    end
end

-- Connect resize event
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onResize)
-- Initial call to set size properly
onResize()

-- Protect GUI from scripts (KRNL specific)
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end

return ScreenGui
