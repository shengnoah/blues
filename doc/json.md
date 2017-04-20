作者：糖果

一般的Python的WEB框架，都可以的指定返回JSON数据，基本的原理，还是通过指定返回JSON格式的字符串，并且设定HTTP返回时header的Content-Type属性为application/json，来实现返回JSON数据的目地。

而在Openresty+Lua的框架模式下，不用同时指返回的header类，直接在路由对应的匿名函数中，指定返回一个table类型的即可， 在web框架部分区分判断，如果用户返回的是table类型的数据，直接就用cjson这种库，把table数据渲染成JSON返回。


依Blues演示框架为例：

```lua
        app.run = function()
                fun = Route:run(app.router)
                if fun then
                    local ret = fun(app.req, app.id)
                    local rtype = type(ret)
                    if rtype == "table"  then
                        json = require "cjson"
                        ngx.header['Content-Type'] = 'application/json; charset=utf-8'
                        ngx.say(json.encode(ret))
                    end 
                end 

        end 
```

显然，这里只是对返回值的类型是“talbe”的做了处理，也可以对返回类型是“string”或是其它类型的数据做处理。


```lua
        app.run = function()
                fun = Route:run(app.router)
                if fun then
                    local ret = fun(app.req, app.id)
                    local rtype = type(ret)
                    if rtype == "table"  then
                        json = require "cjson"
                        ngx.header['Content-Type'] = 'application/json; charset=utf-8'
                        ngx.say(json.encode(ret))
                    end
                    if rtype == "string"  then
                        ngx.header['Content-Type'] = 'text/plain; charset=UTF-8'
                        ngx.say(ret)
                    end
                end
                le('Application.app.run')
        end
```

没有把这种分类型处理，单独封装成一个方法，简单用这段代码说明问题。

上面是框架中的代码实现，再来看看如何在测试项目中驱动这个功能。


```lua
require "log"
local HiLog = require "HiLog"
local utils = require "utils.utils"
local Application = require "orc"
app = Application.new()


app:get("/json", function(request,id)
    return {k='key', v='value'}    
end)

app:get("/string", function(request,id)
    return "Waterfall"
end)

return app.run()
```

这样以来，我们就可以快速的用Openresty + Lua构建超级微级的路由系统，管理渲染JSON数据，构建一个简单的JSON数据请求服务。



### 如何读取HTTP的Body数据。

我们通过curl向openresty服务器端请求rest，采用GET请求方式，提交一个json,然后路由到对应的匿名函数，通过request.params.body直接取得json数据主体，解析成table变量，放回渲染。
下面：


```
curl -X GET  http://0.0.0.0/blues -d  '{"key":"value"}'
```


```lua
app:get("/blues", function(request,id)
    local ret = request.params.body
    local json = require "cjson"
    local util = require "cjson.util"
    local t = json.decode(ret)
    ngx.say(util.serialise_value(t))
    return ret
end)
```


结果：
```
{
  ["key"] = "value"
}
{"key":"value"}
```



```lua
app:get("/blues", function(request,id)
    local ret = request.params.body
    local json = require "cjson"
    local t = json.decode(ret)
    return t
end)
```

结果：
```
{"key":"value"}
```






[Blues](https://github.com/shengnoah/Blues)

[Waterfall](https://github.com/shengnoah/Waterfall)
