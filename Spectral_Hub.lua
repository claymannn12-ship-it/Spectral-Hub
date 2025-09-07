-- Spectral Hub - Expandable Version with Auto-Refresh
-- Developer: Sp3ctr@l
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpectralHub"
screenGui.Parent = PlayerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
-- Create Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true
-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Text = "Spectral Hub"
title.Parent = frame
-- Table of games (add new games here)
local scripts = {
["Aladia PvP"] = "https://raw.githubusercontent.com/claymannn12-ship-it/Aladia-PvP/main/main.lua",
["Arsenal"] = "https://raw.githubusercontent.com/claymannn12-ship-it/Arsenal/main/Main.lua",
["Strongest Battlegrounds"] = "https://raw.githubusercontent.com/claymannn12-ship-it/Strongest_Battleground/refs/heads/main/Spectral_Hub.lua",
-- ["New Game"] = "Raw GitHub URL for new game script"
}
-- Function to create buttons dynamically
local function createButtons()
local yPos = 80
for gameName, url in pairs(scripts) do
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 220, 0, 40)
button.Position = UDim2.new(0, 40, 0, yPos)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 18
button.Text = gameName
button.Parent = frame
button.AutoButtonColor = false

button.MouseEnter:Connect(function()
TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
end)

button.MouseLeave:Connect(function()
TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
end)

-- Auto-refresh: fetch latest script each click
button.MouseButton1Click:Connect(function()
local success, err = pcall(function()
-- Fetch the latest script from GitHub
local scriptCode = game:HttpGet(url, true) -- 'true' forces bypass cache
loadstring(scriptCode)()
end)
if success then
print(gameName .. " executed successfully!")
screenGui:Destroy() -- Terminates the main GUI after successful execution
else
warn("Failed to execute " .. gameName .. ": " .. tostring(err))
end
end)

yPos = yPos + 50
end
end
-- Call the function to generate buttons
createButtons()
