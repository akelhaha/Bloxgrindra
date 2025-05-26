--// Protect GUI
local ScreenGui = Instance.new("ScreenGui")
syn.protect_gui(ScreenGui)
ScreenGui.Name = "BloxburgFarmGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

--// Main Frame
local Frame = Instance.new("Frame")
Frame.Name = "Main"
Frame.Size = UDim2.new(0.3, 0, 0.4, 0)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

--// UICorner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

--// Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Bloxburg Autofarm"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Parent = Frame

--// Auto Farm Button
local AutoFarmButton = Instance.new("TextButton")
AutoFarmButton.Name = "AutoFarmButton"
AutoFarmButton.Text = "Start AutoFarm"
AutoFarmButton.Font = Enum.Font.Gotham
AutoFarmButton.TextSize = 20
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoFarmButton.Size = UDim2.new(0.9, 0, 0.25, 0)
AutoFarmButton.Position = UDim2.new(0.05, 0, 0.25, 0)
AutoFarmButton.Parent = Frame

local AutoFarmUICorner = Instance.new("UICorner")
AutoFarmUICorner.CornerRadius = UDim.new(0, 6)
AutoFarmUICorner.Parent = AutoFarmButton

--// Godspeed Toggle
local GodspeedToggle = Instance.new("TextButton")
GodspeedToggle.Name = "GodspeedToggle"
GodspeedToggle.Text = "Godspeed: OFF"
GodspeedToggle.Font = Enum.Font.Gotham
GodspeedToggle.TextSize = 20
GodspeedToggle.TextColor3 = Color3.new(1, 1, 1)
GodspeedToggle.BackgroundColor3 = Color3.fromRGB(70, 0, 70)
GodspeedToggle.Size = UDim2.new(0.9, 0, 0.25, 0)
GodspeedToggle.Position = UDim2.new(0.05, 0, 0.55, 0)
GodspeedToggle.Parent = Frame

local GodspeedUICorner = Instance.new("UICorner")
GodspeedUICorner.CornerRadius = UDim.new(0, 6)
GodspeedUICorner.Parent = GodspeedToggle

--// Autofarm + Godspeed Logic
local autofarming = false
local godspeed = false

AutoFarmButton.MouseButton1Click:Connect(function()
    autofarming = not autofarming
    AutoFarmButton.Text = autofarming and "Stop AutoFarm" or "Start AutoFarm"

    if autofarming then
        task.spawn(function()
            while autofarming do
                local job = game:GetService("Players").LocalPlayer.Job
                if job and job.Name == "DeliveryPerson" then
                    local vehicle = workspace:FindFirstChild(game.Players.LocalPlayer.Name .. "'s Moped")
                    local delivery = workspace:FindFirstChild("DeliveryTarget")
                    if vehicle and delivery then
                        game.Players.LocalPlayer.Character:MoveTo(vehicle.Position)
                        wait(1)
                        game.Players.LocalPlayer.Character:MoveTo(delivery.Position)
                        wait(godspeed and 0.2 or 1.5)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

GodspeedToggle.MouseButton1Click:Connect(function()
    godspeed = not godspeed
    GodspeedToggle.Text = godspeed and "Godspeed: ON" or "Godspeed: OFF"
end)

--// Mobile Resizing Logic (Aspect Ratio Scaling)
local aspect = Instance.new("UIAspectRatioConstraint")
aspect.AspectRatio = 1.6
aspect.Parent = Frame

local scale = Instance.new("UIScale")
scale.Scale = 1
scale.Parent = Frame

local function resizeForMobile()
    local screenSize = workspace.CurrentCamera.ViewportSize
    if screenSize.X < 1000 then
        scale.Scale = 1.3
        Frame.Size = UDim2.new(0.6, 0, 0.6, 0)
        Frame.Position = UDim2.new(0.2, 0, 0.2, 0)
    else
        scale.Scale = 1
        Frame.Size = UDim2.new(0.3, 0, 0.4, 0)
        Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
    end
end

resizeForMobile()
game:GetService("UserInputService").WindowFocusReleased:Connect(resizeForMobile)
game:GetService("UserInputService").WindowFocused:Connect(resizeForMobile)
