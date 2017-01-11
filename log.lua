sw_pt=1
sw_lp=0
sw_ls=1
sw_le=0
sw_la=1
sw_ll=0

function pt(...)
    if sw_pt == 0 then
        return
    end
    print(...)
end

function lp(...)
    if sw_lp == 0 then
        return
    end
    pt(...)
end

function ls(...)
    fn_name=''
    if type(arg[1]) == 'nil' then
        fn_name=' '
    else
        fn_name=arg[1]
    end
 
    pt('=============== [s]:'..fn_name..' <-')
end

function le(...)
    if sw_le == 0 then
        return
    end

    if type(arg[1]) == 'nil' then
        fn_name=' '
    else
        fn_name=arg[1]
    end
    pt('=============== [e]:'..fn_name..' <-') 
end

function ll(...)
    if sw_ll == 0 then
        return
    end
    pt('-------------------------------------------------')
end


function la(...)
    --pt(...)
end

