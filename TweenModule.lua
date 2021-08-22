local TweenService = game:GetService("TweenService")

local Tweening = {}

function Tweening:Animate(name, duration, properties)
    duration = duration or .3
    local TI = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    
    local Tweening = TweenService:Create(name, TI, properties)

    local InnerAnims = {}

    function InnerAnims:Play(Animation)
        Animation:Play()
    end

    return InnerAnims
end

return Tweening

--[[
usage:

local Tween = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cryptweb/modules/main/TweenModule.lua"))()

local hello = Tween:Animate(itemName, 0.6, {Transparency = 1})

Tween:Play(hello)
]]
