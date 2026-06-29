--[[
    CRE: KHUNGKHONGXINH
    Chức năng: ESP Player xuyên bản đồ (Xa vẫn thấy) + Menu Bật/Tắt
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Tránh trùng lặp Menu cũ nếu chạy lại script
if CoreGui:FindFirstChild("ESP_Menu_KhungKhongXinh") then
    CoreGui:FindFirstChild("ESP_Menu_KhungKhongXinh"):Destroy()
end

-- TRẠNG THÁI BẬT/TẮT
local ESP_Enabled = true

-- --- TẠO GIAO DIỆN MENU (UI) ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESP_Menu_KhungKhongXinh"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Khung Menu Chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UUDim2.new(0, 180, 0, 90)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0) -- Vị trí góc trên bên trái
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể di chuyển menu trên màn hình
MainFrame.Parent = ScreenGui

-- Bo góc cho Menu
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Tiêu đề Menu (Credits)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "ESP MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 15)
Credit.Position = UDim2.new(0, 0, 0, 25)
Credit.Text = "Cre: khungkhongxinh"
Credit.TextColor3 = Color3.fromRGB(0, 255, 255)
Credit.TextSize = 11
Credit.Font = Enum.Font.SourceSansItalic
Credit.BackgroundTransparency = 1
Credit.Parent = MainFrame

-- Nút Bật/Tắt ESP
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 140, 0, 30)
ToggleBtn.Position = UDim2.new(0, 20, 0, 48)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100) -- Màu xanh lá khi bật
ToggleBtn.Text = "ESP: ON"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 5)
BtnCorner.Parent = ToggleBtn

-- --- HỆ THỐNG XỬ LÝ ESP ---
-- Sử dụng Highlight để hiển thị xuyên tường và không giới hạn khoảng cách
local function CreateESP(player)
    if player == LocalPlayer then return end

    local function ApplyHighlight(character)
        if not character then return end
        
        -- Chờ Nhân vật tải xong phần thân chính
        character:WaitForChild("HumanoidRootPart", 5)
        
        -- Xóa Highlight cũ nếu có
        if character:FindFirstChild("ESP_Highlight") then
            character:FindFirstChild("ESP_Highlight"):Destroy()
        end
        
        -- Tạo Highlight mới (Nhìn xuyên vật thể, không giới hạn tầm nhìn)
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "ESP_Highlight"
        Highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ bên trong thân
        Highlight.FillTransparency = 0.5 -- Độ trong suốt của thân
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Viền trắng bên ngoài
        Highlight.OutlineTransparency = 0 -- Độ rõ của viền
        Highlight.Adornee = character
        Highlight.Enabled = ESP_Enabled
        Highlight.Parent = character
    end

    -- Áp dụng khi nhân vật spawn
    if player.Character then
        ApplyHighlight(player.Character)
    end
    player.CharacterAdded:Connect(ApplyHighlight)
end

-- Tải ESP cho tất cả người chơi hiện tại và người chơi mới tham gia
for _, player in ipairs(Players:GetPlayers()) do
    CreateESP(player)
end
Players.PlayerAdded:Connect(CreateESP)

-- --- XỬ LÝ SỰ KIỆN BẬT / TẮT ---
ToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    
    if ESP_Enabled then
        ToggleBtn.Text = "ESP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    else
        ToggleBtn.Text = "ESP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Màu đỏ khi tắt
    end
    
    -- Cập nhật trạng thái hiển thị của tất cả Highlight
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("ESP_Highlight") then
            player.Character.ESP_Highlight.Enabled = ESP_Enabled
        end
    end
end)
