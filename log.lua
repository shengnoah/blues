sw_lp=0
sw_ls=1
sw_le=1
sw_la=1

function lp(...)
    if sw_lp == 0 then
        return
    end
    print(...)
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
