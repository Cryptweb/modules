-- // I have no idea why you would use this, but I made this for myself lol
local f = {}

function f.add(name, callback)
    if (not name) then return print('missing name') end
    if (not callback) then return print('missing callback') end
    
    table.insert(f, name)
    f[name] = callback
end
    
function f.getFunctions()
    return f
end
    
return f

--[[

usage:

-- // Defining the module
local f = loadstring(game:HttpGet('https://raw.githubusercontent.com/Cryptweb/modules/main/FunctionHandler.lua'))()

-- // Creating a function to redeem all of the game codes (Size Legends)
f.add('redeemCodes', function()
    local player = game:GetService('Players').LocalPlayer
    local remote = player.PlayerGui.Codes.MainFrame.Redeem
    
    for _, v in pairs(player.Codes:GetChildren()) do
        if (v:IsA('BoolValue')) then
            remote.Redeemed:FireServer(v.Name)
        end
    end
end)

-- // Defining the variable that gets all the functions
local functions = functionHandler.getFunctions()

-- // If it fails to get/find the functions
if (not functions) then return print('failed to find functions') end

-- // Using the redeem game codes function
functions.redeemCodes()

]]
