local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local camera = Workspace.CurrentCamera
local localPlayer = Players.LocalPlayer

-- Hàm cập nhật hướng nhìn camera về phía một vị trí cụ thể (ví dụ: một Part)
local function focusCameraOn(targetPosition)
    if camera and targetPosition then
        -- Giữ nguyên vị trí hiện tại của camera nhưng thay đổi hướng nhìn về targetPosition
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPosition)
    end
end

-- Ví dụ: Luôn hướng camera về một vị trí cố định trong Workspace mỗi khung hình
-- RunService.RenderStepped thường được dùng cho các tác vụ liên quan đến Camera
RunService.RenderStepped:Connect(function()
    local targetPart = Workspace:FindFirstChild("TargetPart") -- Thay thế bằng đối tượng mục tiêu hợp lệ
    if targetPart then
        focusCameraOn(targetPart.Position)
    end
end)
