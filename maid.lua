-- simple maid module i made for myself since i couldn't find any good ones that would satisfy my needs

local maid = {};
maid.__index = maid;

--- constructs the maid
-- @constructor
function maid.new()
    local self = setmetatable({}, maid);
    self.tasks = {};
    return self;
end;

--- gives the maid a task
-- returns a table which you can later remove/disconnect the maid with
function maid:give_task(task)
    if not task then
        return;
    end;

    local task_id = #self.tasks + 1;
    self.tasks[task_id] = task;

    return {
        remove = function()
            if not self.tasks[task_id] then return end;

            if self.tasks[task_id].Disconnect then
                self.tasks[task_id]:Disconnect();
            elseif self.tasks[task_id].Remove then
                self.tasks[task_id]:Remove();
            elseif self.tasks[task_id].Destroy then
                self.tasks[task_id]:Remove();
            end;
            
            table.remove(self.tasks, task_id);
            return true;
        end;
    };
end;

-- disconnects every single task
function maid:cleanup()
    for id, task in pairs(self.tasks) do
        if task.Disconnect then
            task:Disconnect()
        elseif task.Remove then
            task:Remove();
        elseif task.Destroy then
            task:Destroy();
        end;
    end;

    self.tasks = {};
end;

return maid;

--[[

example usage:

----------------------------------------
local m = loadstring(game:HttpGet('https://raw.githubusercontent.com/Cryptweb/modules/main/maid.lua'))().new();
local user_input_service = game.UserInputService;

local connection = user_input_service.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        print('Hello, World!');
    end;
end);
local connection_handler = m:give_task(connection);

local connection2 = user_input_service.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then
        print('Hello, World!');
    end;
end);
local connection_handler2 = m:give_task(connection2);

game.UserInputService.InputBegan:Connect(function(a)
    if a.KeyCode == Enum.KeyCode.C and connection_handler then
        connection_handler.remove();
        print('Removed task!');
    end;

    if a.KeyCode == Enum.KeyCode.R and next(m.tasks) ~= nil then
        m:cleanup();
        print('Cleaned up tasks!');
    end;
end);
----------------------------------------

]]
