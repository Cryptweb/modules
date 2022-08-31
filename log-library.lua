--[[ 

                        This is a logging/debugging library made by Cryptweb/worldwide/Evan/sovw (most of my names and alias lol)
                                    
                                                               Q: What is this used for?
                                          A: This can be used for a lot of stuff, for example: debugging your script 
                                                      and finding out which part you are crashing at.

                                                                Q: How is this useful?
                                         A: This is useful, because your script crashes and you will not be able 
                                                             to see your printing result.

                                                              Q: Thx for saving my life
                                                                        A: Np

                                                                       Actions:
                                                                     write, print

                                                                        Types:
                                                               DEBUG, WARN, INFO, ERROR

                                                                        Usage:
-- // Set-up
local log_library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cryptweb/modules/main/log-library.lua"))();
local script_name = 'script_name'

-- // Calling the 'Log' function
log_library:Log({ type = "DEBUG", text = "Initializing...", action = "write", name = script_name }); -- // Writes to file in workspace folder
log_library:Log({ type = "DEBUG", text = "Initializing...", action = "print" }); -- // name (file name) is not necessary while calling the print function (shouldn't be used for debugging)

-- // Deleting the log file (if the debugging was successful)
log_library:delete(script_name);
                                                                                                                                                          ]]

local library = {};
shared.file = nil;

function createFile(args)
    assert(type(args) == "table" and args ~= nil, "Invalid argument #1 to 'createFile' (table expected, got " .. tostring(type(args)) .. ')');
    
    local filename = args.filename;
    assert(type(filename) == "string" and filename ~= nil, "Invalid argument #1 to 'args' (string expected, got " .. tostring(type(filename)) .. ')');

    writefile(filename .. '.log', '');
    shared.file = (filename .. '.log');
end;

function library:delete(name)
    delfile(name .. '.log');
end;

function library:Log(args)
    assert(type(args) == "table" and args ~= nil, "Invalid argument #1 to 'Log' (table expected, got " .. tostring(type(args)) .. ')');

    local logType = args.type or args.logtype or args.logType;
    assert(type(logType) == "string" and logType ~= nil, "Invalid argument #1 to 'args' (string expected, got " .. tostring(type(logType)) .. ')');
    assert(logType:upper() == "DEBUG" 
    or logType:upper() == "INFO" 
    or logType:upper() == "ERROR"
    or logType:upper() == "WARN"
    or logType:upper() == "WARNING", "Invalid argument #2 to 'args' (valid argument expected, got " .. tostring(logType:upper()) .. ')');

    local logText = args.text or args.logText or args.logtext;
    assert(type(logText) == "string" and logText ~= nil, "Invalid argument #3 to 'args' (string expected, got " .. tostring(type(logText)) .. ')');

    local logAction = args.action or args.logAction or args.logaction;
    assert(type(logAction) == "string" and logAction ~= nil, "Invalid argument #4 to 'args' (string expected, got " .. tostring(type(logAction)) .. ')');

    local file_name = args.filename or args.name or args.fileName;

    local logDebugText = ('%s [%s] %s'):format(tostring(os.date("%X")), logType:upper(), logText .. '\n');
    if (logAction == 'appendfile' or logAction == 'write' or logAction == 'file') 
    then
        assert(type(file_name) == "string" and file_name ~= nil, "Invalid argument #5 to 'args' (string expected, got " .. tostring(type(file_name)) .. ')');
        
        if (not isfile(file_name .. '.log')) then 
            createFile({ filename = file_name }); 
        end;
        
        repeat wait() until isfile(file_name .. '.log');
        appendfile((file_name .. '.log'), logDebugText);
    elseif (logAction == 'print')
    then
        if (logType:upper() == 'DEBUG') then
            print(logDebugText);
        elseif (logType:upper() == 'INFO') then
            print(logDebugText);
        elseif (logType:upper() == 'WARN' or logType:upper() == 'WARNING') then
            warn(logDebugText);
        elseif (logType:upper() == 'ERROR') then
            error(logDebugText);
        end
    else
        return warn(("%s [%s] %s"):format(tostring(os.date("%X")), "WARNING", "Invalid action type!\n Valid types:\n file\n print"));
    end;
end;

return library;
