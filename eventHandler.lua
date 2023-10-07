local eventHandler = {};
eventHandler.__index = eventHandler;

function eventHandler.new()
    local self = setmetatable({}, eventHandler);
    self.handlers = {};
    return self;
end;

function eventHandler:on(event, handler)
    if not self.handlers[event] then
        self.handlers[event] = {};
    end;

    table.insert(self.handlers[event], handler);

    return {
        disconnect = function()
            for _, h in ipairs(self.handlers[event]) do
                if h == handler then
                    table.remove(self.handlers[event], _);
                    break;
                end;
            end;
        end
    };
end;

function eventHandler:fire(event, ...)
    local handlers = self.handlers[event];
    if handlers then
        for i in handlers do
            handlers[i](...);
        end;
    end;
end;

return eventHandler;
