local TweenService = game:GetService("TweenService")

local Tweening = {}

function Tweening:Create(obj, info, properties, callback)
    local Tweening = TweenService:Create(obj, unpack(info), properties)
    Tweening:Play()
    
    if (callback) then
        anim.Completed:Connect(callback) 
    end
end

return Tweening

--[[
usage:

local Tween = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cryptweb/modules/main/TweenModule.lua"))()

Tween:Create(itemName, {1}, {Transparency = 1}, function()
    print('Transparency is now 1')
end)
]]
