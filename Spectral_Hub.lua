-- Executor-friendly fancy GUI with animation and label

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- URLs of the scripts
local scripts = {
    ["Aladia PvP"] = "https://raw.githubusercontent.com/claymannn12-ship-it/Aladia-PvP/refs/heads/main/main.lua",
    ["Arsenal"] = "https://raw.githubusercontent.com/claymannn12-ship-it/Arsenal/refs/heads/main/Main.lua"
}

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FancyScriptSelectorGUI"
screenGui.Parent = PlayerGui

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, -0.5, 0) -- Start off-screen
frame.Parent = screenGui

-- Animate GUI entrance
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()

-- Create Developer label
local devLabel = Instance.new("TextLabel")
devLabel.Size = UDim2.new(1, 0, 0, 30)
devLabel.Position = UDim2.new(0, 0, 0, 0)
devLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
devLabel.Text = "Developer-Sp3ctr@l"
devLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
devLabel.Font = Enum.Font.GothamBold
devLabel.TextSize = 20
devLabel.Parent = frame

-- Create title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "Select a Script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

-- Function to create fancy button
local function createButton(name, yPosition)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 220, 0, 40)
    button.Position = UDim2.new(0, 40, 0, yPosition)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 18
    button.Text = name
    button.Parent = frame
    button.AutoButtonColor = false

    -- Hover animation
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)

    -- Click event
    button.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(scripts[name]))()
        end)
        if success then
            print(name .. " executed successfully!")
        else
            warn("Failed to execute " .. name .. ": " .. tostring(err))
        end
        -- Animate GUI exit
        TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, -0.5, 0)}):Play()
        wait(0.5)
        screenGui:Destroy()
    end)
end

-- Create buttons
createButton("Aladia PvP", 80)
createButton("Arsenal", 130)
