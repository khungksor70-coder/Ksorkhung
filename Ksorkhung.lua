--[[
    Script Creator: tiktok : khungkhongxinh
    Platform: Roblox Mobile (Delta Executor)
--]]

-- Khởi tạo UI Giao diện
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabContainer = Instance.new("Frame")
local ContentContainer = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")

-- Cấu hình ScreenGui
ScreenGui.Name = "KhungKhongXinhMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Nút chữ K để bật/tắt Menu (Dành cho điện thoại)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 100)
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "K"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true -- Có thể di chuyển nút chữ K trên màn hình

-- Bo tròn nút K
local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 25)
ButtonCorner.Parent = ToggleButton

-- Khung Menu Chính
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Tiêu đề Menu
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Text = "KhungKhongXinh Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold

-- Bản quyền tiktok
Credit.Name = "Credit"
Credit.Parent = MainFrame
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0.5, 0, 0, 5)
Credit.Size = UDim2.new(0, 190, 0, 30)
Credit.Text = "tiktok : khungkhongxinh"
Credit.TextColor3 = Color3.fromRGB(255, 60, 100)
Credit.TextSize = 14
Credit.TextXAlignment = Enum.TextXAlignment.Right
Credit.Font = Enum.Font.SourceSansItalic

-- Thanh chứa Tab
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.Size = UDim2.new(0, 100, 0, 200)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 5)
TabCorner.Parent = TabContainer

-- Vùng chứa tính năng
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentContainer.Position = UDim2.new(0, 120, 0, 40)
ContentContainer.Size = UDim2.new(0, 270, 0, 200)

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 5)
ContentCorner.Parent = ContentContainer

-- Các trang tính năng (Pages)
local ESPPage = Instance.new("Frame", ContentContainer)
ESPPage.Size = UDim2.new(1, 0, 1, 0)
ESPPage.BackgroundTransparency = 1
ESPPage.Visible = true

local FlyPage = Instance.new("Frame", ContentContainer)
FlyPage.Size = UDim2.new(1, 0, 1, 0)
FlyPage.BackgroundTransparency = 1
FlyPage.Visible = false

-- Nút chuyển Tab 1: ESP
local Tab1Btn = Instance.new("TextButton", TabContainer)
Tab1Btn.Size = UDim2.new(1, 0, 0, 40)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Tab1Btn.Text = "ESP"
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.Font = Enum.Font.SourceSansBold

-- Nút chuyển Tab 2: Fly
local Tab2Btn = Instance.new("TextButton", TabContainer)
Tab2Btn.Size = UDim2.new(1, 0, 0, 40)
Tab2Btn.Position = UDim2.new(0, 0, 0, 45)
Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab2Btn.Text = "Fly"
Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab2Btn.Font = Enum.Font.SourceSansBold

-- Logic chuyển Tab
Tab1Btn.MouseButton1Click:Connect(function()
    ESPPage.Visible = true
    FlyPage.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    ESPPage.Visible = false
    FlyPage.Visible = true
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

-- Logic ẩn/hiện menu bằng nút K
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

---------------------------------------------------------
-- CÁC TÍNH NĂNG CHÍNH (LOGIC)
---------------------------------------------------------

-- [TAB 1: ESP PLAYER]
local ESPEnabled = false
local ESPButton = Instance.new("TextButton", ESPPage)
ESPButton.Size = UDim2.new(0, 200, 0, 40)
ESPButton.Position = UDim2.new(0, 35, 0, 20)
ESPButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ESPButton.Text = "ESP PLAYER: OFF"
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.Font = Enum.Font.SourceSansBold

local function CreateESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        if not player.Character.HumanoidRootPart:FindFirstChild("Highlight") then
            local Highlight = Instance.new("Highlight")
            Highlight.Name = "Highlight"
            Highlight.Parent = player.Character.HumanoidRootPart
            Highlight.FillColor = Color3.fromRGB(255, 0, 0)
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            Highlight.FillTransparency = 0.5
        end
    end
end

local function RemoveESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local Highlight = player.Character.HumanoidRootPart:FindFirstChild("Highlight")
        if Highlight then Highlight:Destroy() end
    end
end

ESPButton.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        ESPButton.Text = "ESP PLAYER: ON"
        ESPButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        -- Bật ESP cho người chơi hiện tại và tương lai
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then CreateESP(p) end
        end
    else
        ESPButton.Text = "ESP PLAYER: OFF"
        ESPButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        for _, p in pairs(game.Players:GetPlayers()) do RemoveESP(p) end
    end
end)

-- [TAB 2: FLY]
local Flying = false
local FlyButton = Instance.new("TextButton", FlyPage)
FlyButton.Size = UDim2.new(0, 200, 0, 40)
FlyButton.Position = UDim2.new(0, 35, 0, 20)
FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FlyButton.Text = "FLY: OFF"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Font = Enum.Font.SourceSansBold

local lplayer = game.Players.LocalPlayer
local speed = 50

FlyButton.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        FlyButton.Text = "FLY: ON"
        FlyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        local char = lplayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local pvd = Instance.new("LinearVelocity")
        pvd.Name = "FlyVelocity"
        pvd.MaxForce = math.huge
        pvd.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector3
        pvd.VectorVelocity = Vector3.new(0,0,0)
        
        local attachment = Instance.new("Attachment")
        attachment.Name = "FlyAttachment"
        attachment.Parent = char.HumanoidRootPart
        pvd.Attachment0 = attachment
        pvd.Parent = char.HumanoidRootPart
        
        -- Vòng lặp bay (Phù hợp cho mobile di chuyển bằng Joystick)
        task.spawn(function()
            while Flying and char and char:FindFirstChild("HumanoidRootPart") do
                local cam = workspace.CurrentCamera
                local moveDirection = char:FindFirstChildOfClass("Humanoid").MoveDirection
                
                if moveDirection.Magnitude > 0 then
                    pvd.VectorVelocity = moveDirection * speed
                else
                    pvd.VectorVelocity = Vector3.new(0, 0, 0)
                end
                task.wait()
            end
            if pvd then pvd:Destroy() end
            if attachment then attachment:Destroy() end
        end)
    else
        FlyButton.Text = "FLY: OFF"
        FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)
