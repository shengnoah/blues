function lp(...)
    --info = debug.getinfo(1)['name']
--[[
    info = debug.getinfo(1)
    for k,v in pairs(info) do
        print(k,v)
    end
--]]
end

function ls(...)
    fn_name=''
    if type(arg[1]) == 'nil' then
        fn_name=' '
    else
        fn_name=arg[1]
    end
 
    print('=============== [s]:'..fn_name)
end

function le(...)
    if type(arg[1]) == 'nil' then
        fn_name=' '
    else
        fn_name=arg[1]
    end
    print('=============== [e]:'..fn_name)
end

function ll(...)
    print('---------------')
end


function la(...)
    print(...)
end
