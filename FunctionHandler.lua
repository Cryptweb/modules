-- // I have no idea why you would use this, but I made this for myself lol
local f = {}

function f.add(name, callback)
    if (not name) then return print('missing name') end
    if (not callback) then return print('missing callback') end
    
    table.insert(f, name)
    f[name] = callback
end
    
function f.get(tbl)
    return tbl
end
    
function f.insert(tbl)
    for i, v in pairs(f) do
        if (typeof(v) == 'function') then
            if (i ~= 'get' and i ~= 'add' and i ~= 'insert') then
                table.insert(tbl, i)
                tbl[i] = v 
            end
        end
    end
end

return f

--[[

usage:

-- // Defining the module
local f = loadstring(game:HttpGet('https://raw.githubusercontent.com/Cryptweb/modules/main/FunctionHandler.lua'))()

-- // Creating a function to redeem all of the game codes (Size Legends)
f.add('code', function()
    local player = game:GetService('Players').LocalPlayer
    local remote = player.PlayerGui.Codes.MainFrame.Redeem
    
    for _, v in pairs(player.Codes:GetChildren()) do
        if (v:IsA('BoolValue')) then
            remote.Redeemed:FireServer(v.Name)
        end
    end
end)

-- // Creating 2 new tables and inserting all of the functions into the first table, and getting all of the functions from the first table then inserting them into the new table (useless)
local newtbl = {} local funcs = {} do f.insert(newtbl) funcs = f.get(newtbl) end

-- // Running the function
funcs.code()

]]
