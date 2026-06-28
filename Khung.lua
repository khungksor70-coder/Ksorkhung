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
})
