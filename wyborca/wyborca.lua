local core_gui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local IMAGE_SIZE = 150

-- MUZYKA (MP4)
local path = "wyborca.mp4"
local url = "https://github.com/KacpereQisNoob/etaszto/raw/refs/heads/main/wyborca.mp4"

if not isfile(path) then
    writefile(path, game:HttpGet(url))
end

local musicSound = Instance.new("Sound")
musicSound.SoundId = getcustomasset(path)
musicSound.Looped = true
musicSound.Volume = 2
musicSound.Parent = core_gui
musicSound:Play()

-- OBIEKTY
local objects = {}

local function spawnOne()
    local gui = Instance.new("ScreenGui")
    gui.Name = "BouncingImageGui_" .. tostring(#objects + 1)
    gui.ResetOnSpawn = false
    gui.Parent = core_gui

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.fromOffset(IMAGE_SIZE, IMAGE_SIZE)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://88807703940874"
    img.Parent = gui

    Instance.new("UICorner", img).CornerRadius = UDim.new(0,12)

    local screenSize = workspace.CurrentCamera.ViewportSize

    local pos = Vector2.new(
        math.random(0, screenSize.X - IMAGE_SIZE),
        math.random(0, screenSize.Y - IMAGE_SIZE)
    )

    local speed = Vector2.new(
        math.random(-300, 300),
        math.random(-300, 300)
    )

    if speed.Magnitude < 50 then
        speed = speed.Unit * 150
    end

    table.insert(objects, {
        img = img,
        pos = pos,
        speed = speed
    })
end

-- START
spawnOne()

-- +5 CO SEKUNDĘ
task.spawn(function()
    while true do
        task.wait(1)
        for i = 1, 5 do
            spawnOne()
        end
    end
end)

-- RUCH
RunService.RenderStepped:Connect(function(dt)
    local screenSize = workspace.CurrentCamera.ViewportSize

    for _, obj in ipairs(objects) do
        obj.pos += obj.speed * dt

        if obj.pos.X <= 0 or obj.pos.X + IMAGE_SIZE >= screenSize.X then
            obj.speed = Vector2.new(-obj.speed.X, obj.speed.Y)
        end

        if obj.pos.Y <= 0 or obj.pos.Y + IMAGE_SIZE >= screenSize.Y then
            obj.speed = Vector2.new(obj.speed.X, -obj.speed.Y)
        end

        obj.img.Position = UDim2.new(0, obj.pos.X, 0, obj.pos.Y)
    end
end)
