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
                table.remove(self.tasks, task_id);
            elseif self.tasks[task_id].Remove then
                self.tasks[task_id]:Remove();
                table.remove(self.tasks, task_id);
            elseif self.tasks[task_id].Destroy then
                self.tasks[task_id]:Remove();
                table.remove(self.tasks, task_id);
            end;

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
