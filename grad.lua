local core_gui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- GUI
local musicGui = Instance.new("ScreenGui")
musicGui.Name = "BouncingImageGui"
musicGui.ResetOnSpawn = false
musicGui.Parent = core_gui

-- IMAGE
local img = Instance.new("ImageLabel")
img.Size = UDim2.fromOffset(150,150)
img.BackgroundTransparency = 1
img.Image = "rbxthumb://type=Asset&id=76361684108024&w=420&h=420"
img.Parent = musicGui

Instance.new("UICorner", img).CornerRadius = UDim.new(0,12)

-- RUCH
local speed = Vector2.new(200,150)
local pos = Vector2.new(200,200)

-- MUZYKA
local path = "music.mp3"
local url = "https://github.com/KacpereQisNoob/etaszto/raw/refs/heads/main/Bzhylka_-_Na_ukraine_vypal_grad_Rock_version__SkySound.cc_.mp3-Abobus-Amogusovich-SoundLoadMate.com.mp3"

if not isfile(path) then
    writefile(path, game:HttpGet(url))
end

local musicSound = Instance.new("Sound")
musicSound.SoundId = getcustomasset(path)
musicSound.Looped = true
musicSound.Volume = 2
musicSound.Parent = core_gui
musicSound:Play()

-- BOUNCE LOGIC
RunService.RenderStepped:Connect(function(dt)
    pos += speed * dt

    local screenSize = workspace.CurrentCamera.ViewportSize

    if pos.X <= 0 or pos.X + 150 >= screenSize.X then
        speed = Vector2.new(-speed.X, speed.Y)
    end

    if pos.Y <= 0 or pos.Y + 150 >= screenSize.Y then
        speed = Vector2.new(speed.X, -speed.Y)
    end

    img.Position = UDim2.new(0,pos.X,0,pos.Y)
end)
