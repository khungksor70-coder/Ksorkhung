-- Khởi tạo Thư viện UI (Sử dụng một UI Library mượt mà, giao diện tối giản)
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

-- Tạo Cửa sổ Menu chính
local UI = Material.Load({
    Title = "⚡ SPEED HUB BY GEMINI",
    Style = 3, -- Giao diện màu tối thanh lịch
    SizeX = 400,
    SizeY = 300,
    Theme = "Dark",
    ColorOverrides = {
        Main = Color3.fromRGB(35, 35, 35)
    }
})

-- Tạo một Tab chức năng
local MainTab = UI.New({
    Title = "Main Cheats"
})

-- Các biến lưu trạng thái ban đầu
local _G = getgenv and getgenv() or _G
_G.SpeedEnabled = false
_G.WalkSpeedValue = 16 -- Tốc độ mặc định của Roblox

-- Hàm xử lý vòng lặp tăng tốc độ
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                
                if _G.SpeedEnabled then
                    humanid.WalkSpeed = _G.WalkSpeedValue
                else
                    -- Nếu tắt hack, trả về tốc độ bình thường (chỉ đổi nếu đang bị hack đè)
                    if humanoid.WalkSpeed == _G.WalkSpeedValue then
                        humanoid.WalkSpeed = 16
                    end
                end
            end
        end)
    end
end)

-- 1. NÚT BẬT/TẮT (TOGGLE)
MainTab.Toggle({
    Text = "Bật/Tắt Tăng Tốc",
    Callback = function(state)
        _G.SpeedEnabled = state
        if state then
            print("Speed: Đã BẬT")
        else
            print("Speed: Đã TẮT")
        end
    end,
    Enabled = false -- Mặc định vào game là tắt
})

-- 2. THANH TRƯỢT CHỈNH TỐC ĐỘ (SLIDER)
MainTab.Slider({
    Text = "Tùy Chỉnh Tốc Độ",
    Callback = function(value)
        _G.WalkSpeedValue = value
    end,
    Min = 16,
    Max = 250,
    Def = 50 -- Tốc độ mặc định khi kéo thanh trượt
})

-- Thông báo nhỏ góc màn hình khi chạy script thành công
UI.Banner({
    Text = "Script đã kích hoạt! Hãy tận hưởng."
})-- Khởi tạo Thư viện UI Material
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

-- 1. TẠO CỬA SỔ MENU CHÍNH
local UI = Material.Load({
    Title = "⚡ SPEED HUB BY GEMINI",
    Style = 3,
    SizeX = 400,
    SizeY = 300,
    Theme = "Dark",
    ColorOverrides = { Main = Color3.fromRGB(30, 30, 30) }
})

local MainTab = UI.New({ Title = "Main Cheats" })

-- Biến cấu hình toàn cục
getgenv().SpeedEnabled = false
getgenv().WalkSpeedValue = 16

-- 2. SỬA LỖI TỐC ĐỘ (Sử dụng cách can thiệp trực tiếp vào thuộc tính để chống Anti-Cheat cơ bản)
task.spawn(function()
    while task.wait(0.05) do -- Chạy nhanh hơn để đè lại hệ thống của game
        pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoid then
                if getgenv().SpeedEnabled then
                    humanoid.WalkSpeed = getgenv().WalkSpeedValue
                else
                    -- Nếu tắt, trả về mặc định
                    if humanoid.WalkSpeed == getgenv().WalkSpeedValue then
                        humanoid.WalkSpeed = 16
                    end
                end
            end
        end)
    end
end)

-- Thêm các Element vào Menu
MainTab.Toggle({
    Text = "Bật/Tắt Tăng Tốc",
    Callback = function(state)
        getgenv().SpeedEnabled = state
    end,
    Enabled = false
})

MainTab.Slider({
    Text = "Tùy Chỉnh Tốc Độ",
    Callback = function(value)
        getgenv().WalkSpeedValue = value
    end,
    Min = 16,
    Max = 250,
    Def = 50
})

-- 3. TẠO NÚT BẬT/TẮT MENU HÌNH MẶT MÈO ĐEN
local CoreGui = game:GetService("CoreGui")
local MainGui = UI.Gui -- Lấy dữ liệu giao diện gốc của thư viện

-- Tạo Nút bấm tròn
local CatButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

-- Đưa nút vào CoreGui để không bị mất khi nhân vật chết
CatButton.Name = "CatMenuButton"
CatButton.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
CatButton.Size = UDim2.new(0, 60, 0, 60)
CatButton.Position = UDim2.new(0, 10, 0, 150) -- Vị trí bên trái màn hình
CatButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CatButton.BorderSizePixel = 0
-- Asset ID ảnh mặt mèo đen chất lượng cao trên Roblox
CatButton.Image = "rbxassetid://12803260799" 

UICorner.CornerRadius = UDim.new(1, 0) -- Làm nút tròn xoe
UICorner.Parent = CatButton

-- Khi bấm vào mặt mèo -> Ẩn hoặc Hiện Menu
local menuVisible = true
CatButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainGui.Enabled = menuVisible
end)

-- Cho phép kéo thả nút mặt mèo tới vị trí bất kỳ trên màn hình (Drag)
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

CatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = CatButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        CatButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

CatButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UI.Banner({ Text = "Script Sửa Lỗi + Menu Mèo Đen Sẵn Sàng!" })-- Khởi tạo Thư viện UI Material
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

-- 1. TẠO CỬA SỔ MENU CHÍNH (KHÓA Ở GIỮA MÀN HÌNH)
local UI = Material.Load({
    Title = "👁️ ESP HUB BY GEMINI",
    Style = 3,
    SizeX = 400,
    SizeY = 300,
    Theme = "Dark",
    ColorOverrides = { Main = Color3.fromRGB(30, 30, 30) }
})

-- Khóa vị trí Menu ở chính giữa màn hình và tắt tính năng kéo thả của thư viện
local MainGui = UI.Gui
if MainGui and MainGui:FindFirstChild("Main") then
    local MainFrame = MainGui.Main
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Căn giữa chính xác theo kích thước 400x300
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Vô hiệu hóa script kéo thả mặc định của thư viện trên khung này nếu có
    for _, v in pairs(MainFrame:GetChildren()) do
        if v:IsA("LocalScript") or v:IsA("Script") then
            v.Disabled = true
        end
    end
end

-- Tạo Tab 1: ESP
local ESPTab = UI.New({ Title = "ESP" })

-- Biến lưu trạng thái ESP
getgenv().ESPEnabled = false
local espObjects = {}

-- Hàm tạo ESP cho một người chơi
local function createESP(player)
    if player == game.Players.LocalPlayer then return end

    local function applyESP(character)
        if not character then return end
        
        -- Chờ nhân vật tải xong các bộ phận chính
        local head = character:WaitForChild("Head", 5)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not head or not humanoidRootPart then return end

        -- Xóa ESP cũ nếu có trước khi tạo mới
        if espObjects[player] then
            for _, obj in pairs(espObjects[player]) do pcall(function() obj:Destroy() end) end
        end
        espObjects[player] = {}

        -- 1. Tạo Highlight (Khung viền phát sáng xuyên tường - tối ưu cho Roblox mới)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Parent = character
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ bên trong
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Viền trắng
        highlight.OutlineTransparency = 0
        highlight.Enabled = getgenv().ESPEnabled
        table.insert(espObjects[player], highlight)

        -- 2. Tạo BillboardGui hiển thị Tên trên đầu
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPName"
        billboard.Parent = head
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        table.insert(espObjects[player], billboard)

        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextStrokeTransparency = 0 -- Tạo viền chữ đen cho dễ nhìn
        textLabel.Visible = getgenv().ESPEnabled
        table.insert(espObjects[player], textLabel)
    end

    player.CharacterAdded:Connect(applyESP)
    if player.Character then applyESP(player.Character) end
end

-- Kích hoạt ESP cho những người đang ở sẵn trong server và người mới vào
for _, p in pairs(game.Players:GetPlayers()) do createESP(p) end
game.Players.PlayerAdded:Connect(createESP)

-- Khi người chơi thoát game thì dọn dẹp bộ nhớ ESP của họ
game.Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do pcall(function() obj:Destroy() end) end
        espObjects[player] = nil
    end
end)

-- NÚT BẬT/TẮT ESP TRONG TAB
ESPTab.Toggle({
    Text = "Esp người chơi",
    Callback = function(state)
        getgenv().ESPEnabled = state
        -- Cập nhật ẩn/hiện ngay lập tức cho toàn bộ người chơi mà không cần load lại
        for player, objects in pairs(espObjects) do
            for _, obj in pairs(objects) do
                pcall(function()
                    if obj:IsA("Highlight") then
                        obj.Enabled = state
                    elseif obj:IsA("TextLabel") then
                        obj.Visible = state
                    end
                end)
            end
        end
    end,
    Enabled = false
})

-- 2. TẠO NÚT CHỮ "K" Ở GÓC TRÁI ĐỂ ẨN/HIỆN MENU
local CoreGui = game:GetService("CoreGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ToggleButton.Name = "K_ToggleMenuButton"
ToggleButton.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 15, 0, 150) -- Góc bên trái màn hình
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleButton.Text = "K"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 10) -- Bo góc vuông nhẹ cho đẹp
UICorner.Parent = ToggleButton

-- Sự kiện nhấn nút chữ "K" để Bật/Tắt Menu
local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainGui.Enabled = menuVisible
end)

UI.Banner({ Text = "Script ESP đã sẵn sàng. Nhấn nút K để ẩn/hiện!" })


