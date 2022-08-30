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


                                                                                                                                                          ]]

local library = {};
shared.file = nil;

function createFile(args)
    assert(type(args) == "table" and args ~= nil, "The argument table MUST be a table, got " .. tostring(args));
    
    local filename = args.filename;
    assert(type(filename) == "string" and filename ~= nil, "The file name argument MUST be a string, got ".. tostring(filename));

    writefile(filename .. '.log', '');
    shared.file = (filename .. '.log');
end;

function library:deleteFile(args)
    assert(type(args) == "table" and args ~= nil, "The argument table MUST be a table, got " .. tostring(args));
    
    local file = args.filename or args.file;
    
    delfile(file .. '.log')
end;

function library:Log(args)
    assert(type(args) == "table" and args ~= nil, "The argument table MUST be a table, got " .. tostring(args));

    local logType = args.type or args.logtype or args.logType;
    assert(type(logType) == "string" and logType ~= nil, "The log type MUST be a string, got " .. tostring(logType));
    assert(logType:upper() == "DEBUG" 
    or logType:upper() == "INFO" 
    or logType:upper() == "ERROR"
    or logType:upper() == "WARN"
    or logType:upper() == "WARNING", "Invalid log type, must be DEBUG or INFO or ERROR or WARN(ING), got " .. tostring(logType));

    local logText = args.text or args.logText or args.logtext;
    assert(type(logText) == "string" and logText ~= nil, "The log text MUST be a string, got " .. tostring(logText));

    local logAction = args.action or args.logAction or args.logaction;
    assert(type(logAction) == "string" and logAction ~= nil, "The log action MUST be a string, got ".. tostring(logAction));

    local file_name = args.filename or args.name or args.fileName;

    local logDebugText = ('%s [%s] %s'):format(tostring(os.date("%X")), logType:upper(), logText .. '\n');
    if (logAction == 'appendfile' or logAction == 'write' or logAction == 'file') 
    then
        assert(type(file_name) == "string" and file_name ~= nil, "The log action MUST be a string, got ".. tostring(logAction));
        
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
