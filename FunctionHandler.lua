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
