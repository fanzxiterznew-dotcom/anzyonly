-- // AUTO-SPIN UNIVERSAL V2 // --
-- // Cukup ganti REMOTE_NAME saja // --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local REMOTE_NAME = "Play" -- GANTI SESUAI REMOTE SPY (Contoh: "Spin", "Play", "Request")

-- // FUNGSI AUTO-SPIN // --
local function startAutoPlay()
    -- Mencari Remote di ReplicatedStorage (tempat paling umum untuk Remote)
    local remote = ReplicatedStorage:FindFirstChild(REMOTE_NAME, true)

    if not remote then
        warn("Remote '"..REMOTE_NAME.."' tidak ditemukan di ReplicatedStorage. Mencoba di tempat lain...")
        return
    end

    print("Remote ditemukan! Memulai Auto-Spin...")

    task.spawn(function()
        while true do
            -- Kita coba FireServer dengan asumsi game umum (tanpa argumen)
            -- Beberapa game butuh argumen, jika gagal, Anda harus memasukkan angkanya
            local success, err = pcall(function()
                remote:FireServer() 
            end)

            if not success then
                -- Jika butuh argumen, coba tambahkan 1 (angka default umum)
                remote:FireServer(1)
            end

            task.wait(0.3) -- Delay 0.3 detik agar tidak kena Kick Spam
        end
    end)
end

-- Menjalankan fungsi
startAutoPlay()
