local TweenService = game:GetService("TweenService")

local Tweening = {}

function Tweening:Create(name, duration, properties)
    duration = duration or .3
    local TI = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    
    local Tweening = TweenService:Create(name, TI, properties):Play()
end

return Tweening

--[[
usage:

local Tween = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cryptweb/modules/main/TweenModule.lua"))()

Tween:Create(itemName, 0.6, {Transparency = 1})
]]
