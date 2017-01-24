local colors = require("ansicolors")

sw_pt=1
sw_lp=1
sw_ls=1
sw_le=1
sw_ll=1
sw_lr=1
sw_lm=1


function pt(...)
    if sw_pt == 0 then return end
    local metadata=...
    --print(colors("%{bright}%{cyan}DBG: %{reset}%{magenta}"..tostring(metadata)))
    ngx.say(colors("%{bright}%{cyan}DBG: %{reset}%{magenta}"..tostring(metadata)))
    --print(...)
end

function lp(...)
    if sw_lp == 0 then return end
    pt(...)
end

function pct(...)
    if sw_pt == 0 then return end
    local metadata=...
    print(colors("%{bright}%{cyan}DBG: %{reset}%{magenta}"..tostring(metadata)))
end

function lm(...)
    if sw_lm == 0 then return end
    print(...)
end

function ls(...)
    fn_name=''
    local arg = {...} 
    if type(arg[1]) == 'nil' then
        fn_name=' '
    else
        fn_name=arg[1]
    end
    pt('=============== [s]:'..fn_name..' <-')
end

function le(...)
    if sw_le == 0 then return end
    local arg = {...} 
    if type(arg[1]) == 'nil' then
        fn_name=' '
    else
        fn_name=arg[1]
    end
    pt('=============== [e]:'..fn_name..' <-') 
end

function ll(...)
    var_name = ''
    if sw_ll == 0 then return end
    local arg = {...} 
    if type(arg[1]) == 'nil' then
        var_name=' '
    else
        var_name=arg[1]
    end
    pt('-----'..var_name..'-----')
end


function lr(...)
    --pt(...)
end

