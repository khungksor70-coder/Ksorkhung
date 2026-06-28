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

UI.Banner({ Text = "Script Sửa Lỗi + Menu Mèo Đen Sẵn Sàng!" })

