-- KONFIGURASI SCRIPT
local Smoothness = 0.2 -- Semakin kecil angkanya (misal 0.05), semakin halus/lambat lock-nya. Jika 1, langsung instan.
local TeamCheck = true -- Ubah ke false jika ingin mengunci teman satu tim juga (misal di game Free For All)

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- Fungsi mencari musuh terdekat berdasarkan jarak karakter
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- Team Check
            if not TeamCheck or (player.Team ~= LocalPlayer.Team) then
                local char = player.Character
                if char and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") then
                    if char.Humanoid.Health > 0 then
                        -- Menghitung jarak antara kepala kamu dan kepala musuh
                        local distance = (char.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                        if distance < shortestDistance then
                            closestPlayer = player
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- LOOP UTAMA (Berjalan setiap frame sebelum game dirender)
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        local target = getClosestPlayer()
        
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local targetHeadPos = target.Character.Head.Position
            
            -- Membuat kamera menghadap ke arah kepala musuh secara halus (Lerp)
            local targetCFrame = CFrame.new(Camera.CFrame.Position, targetHeadPos)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Smoothness)
        end
    end
end)
