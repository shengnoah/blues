在日常WEB框架的使用中，浏览器用户提交的HTTP请求数据，作为后台程序的输入源，程序员难免要与其数据打交道，而对于这些来源数据解析的细节工作，主要是由WEB框架程序来完成的， 我们基于Openresty和Lua语言为基础，构建了一个叫Blues的WEB框架，下面的代码展示的就是，如何在[Blues](https://github.com/shengnoah/Blues)框架中，使用[LazyTable](http://moonscript.cn/moonscript%E8%AF%AD%E6%B3%95/moonscript-lazy-table/)结构机制，通过Openresty的API，取得WEB服务请求者的Request信息：


Request.lua是Blues框架代码的一部分，主要用于处理用户的来源请求的数据，在request.lua中，我们引用了nginx.lua这个lazytable库，request.lua如果作为一个代理类的话，nginx.lua这个就是请求数据的主要取得者，整体上nginx.lua这个文件采用的设计模式就是LazyTable样式的。Request文件就是一个简单的lua table变量实例的定义，table中的成员变量就是Nginx的各种和Request Header相关的API取回的数据。


request.lua

```lua
local params = require "nginx"


function Request:getInstance()


        local name = "request"
        local instance = { 
                        url="/request",
                        getName = function()
                                lp("CRequest!")
                        end 
                        }   


        instance.uri = "candy lab"
        instance.params = params
        setmetatable(instance, { __index = self,
                                 __call = function()
                                                lp("Initial Instance")
                                        end 
                                 })  
        return instance
end
```


app.lua是用户调用Blues框架的客户端程序，严格的说不算是Blues框架的代码，app.lua中的代码主要是框架用户的具体的业务代码，下面的代码展示的只是，如何把框架提供的params数据都遍历一次。

app.lua

```lua
app:get("/blues", function(request,id)
    for k,v in pairs(request.params) do
        ngx.say(k)
    end 
    return {k='key', v='value'}
end)
```

框架使用的客户端程序，直接通过读取request的成员变量params，而params的所有成员数据都是从nginx.lua中ngx_request这个变量中的各种nginx API调用返回的，下面的程序展示的就是一个可扩展的LazyTable结构，如果框架用户想增加取得对Request数据的项目请求，扩展ngx_request这个结构，用相应的API向Nginx取得即可：

nginx.lua

```lua
local ngx_request = { 
  headers = function()
    return ngx.req.get_headers()
  end,
  cmd_meth = function()
    return ngx.var.request_method
  end,
  cmd_url = function()
    return ngx.var.request_uri
  end,
}

local lazy_tbl
lazy_tbl = function(tbl, index)
  return setmetatable(tbl, {
    __index = function(self, key)
      local fn = index[key]
      if fn then
        do  
          local res = fn(self)
          self[key] = res 
          return res 
        end 
      end 
    end 
  })  
end
return ngx_request
```

通过上面最开始的代码，我们可以发现，实际上nginx.lua定义了Lazy Table函数，但lazy_tbl函数的并没有被执行， 这意为着，如果想取得header中的对应数据，要在客户端程序中，按下面的方法取得request数据：

```lua
app:get("/blues", function(request,id)
    --下面遍历出所有request.params变量中的key字符和对应的函数。
    for k,v in pairs(request.params) do
        ngx.say(k)
    end 
    --调用其中一个key为"cmd_url"函数, 返回请求的url
    local ret = (request.params['cmd_url'])()
    return ret
end)
```


上面这种写法显然不方便，所有我们在框架级别解决这个问题,在nginx.lua中加入build_request这个函数，我们是在build_request中调用lazy_tbl，并return返回的，这样会生成一个新的table实例，在这个实例中key所对应的数据就是直接我们想取得的用户数据。

nginx.lua

```lua
local build_request
build_request = function(unlazy)
        ret = lazy_tbl({}, ngx_request)
        for k in pairs(ngx_request) do
             local _ = ret[k]
        end 
        return ret 
end
```

把之前直接返回：“return ngx_request”这句，替换成“return build_request("") ”，生成了一个新的table，之后对request.param的成员引用，变成了下面的样式：

```lua
app:get("/blues", function(request,id)
    --直接用"."运算符把值取出来，不用加调用key所对应的函数。
    local ret = request.params.cmd_url
    return ret
end)
```

上面就是LazyTable在Blues框架的一个具体的应用实例，关于Lazy Table in LUA的更多说明可参考这篇文章：[Lua的LazyTable实现](http://moonscript.cn/moonscript%E8%AF%AD%E6%B3%95/moonscript-lazy-table/)。


在文章的最后向大家介绍几个Lua的WEB框架：Lapis,LOR,vanilla。LOR和vanilla是国内的工程师开发的。这篇文章的主要灵感来源于leafo老师的lapis，leafo老师也是lua的作者之一，Moonscript的作者。

PS:转载到其它平台请注明作者姓名及原文链接，请勿用于商业用途。

[糖果实验室](http://www.candylab.net)

http://www.candylab.net

