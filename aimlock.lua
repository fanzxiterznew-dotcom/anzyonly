-- KONFIGURASI SCRIPT
local Smoothness = 0.2 
local TeamCheck = true 

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- SIGNATURE CERTIFICATE (Statik)
local SIGNATURE = [[308201ab30820114a00302010202046da5aef4300d06092a864886f70d0101050500301931173015060355040a0c0e313131646f74732073747564696f3020170d3137303932383036323230395a180f32303637303931363036323230395a301931173015060355040a0c0e313131646f74732073747564696f30819f300d06092a864886f70d010101050003818d00308189028181009e6bfd28384be84e8e56b960aeef8d5df41f59390d2f18c11910cf6ae33e8cf6b3d7fd7750fa0b9df44df2cf32eb63d2909caa24ae6f8f4610c3252323bc42018a4f169cc11fd0421466e9acfa2d9db8d6c479e0e63e88df2ef9cda97b19b44728d5eb973b5fb5a68266dde8d5c8dbd00d284f8a7d2b9993967c297cf3cb4cb10203010001300d06092a864886f70d010105050003818100149e29e18da90b981786b7000e24a219a7af8189e98cbb732ce983a8b211e9c3a8b7ab43b9686f59b04e5e30f854d0f3fc3ea895216c8a2f5c95ab1f241026d9843646eeb8e36508c2bd874b5041a94ad39fb0248f4d96b2f52189dca1d24119f92de191af5ae384414bec0740d5923886f6d39526e3f9ec77dd34fcbe02d6c9]]

print("Signature Loaded")
print("Length: "..#SIGNATURE)

local function checkSignature(sig)
    return sig == SIGNATURE
end

if checkSignature(SIGNATURE) then
    print("Signature Valid")
else
    print("Signature Invalid")
end

-- LOGIKA AIMBOT
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not TeamCheck or (player.Team ~= LocalPlayer.Team) then
                local targetHumanoid = player.Character:FindFirstChild("Humanoid")
                if targetHumanoid and targetHumanoid.Health > 0 then
                    local targetPos = player.Character.HumanoidRootPart.Position
                    local distance = (targetPos - myPos).Magnitude
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.Character.HumanoidRootPart.Position
        local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Smoothness)
    end
end)
