# Blues
一个基于Openresty的WEB演示框架。


#命令

可以通简单的命令快速的生成Openresty的配置文件和目录结构：

### 1.安装

```
git clone https://github.com/shengnoah/Blues.git
cd Blues
sudo sh install.sh
```

### 2.创建项目

```
orc project blues
orc app blues
orc middleware blues waf
```

### 3.创建应用


```lua
local bjson = require "utils.bjson"
local app = require "blues"

app:get("/blues", function(self)
    ngx.say(self.app_id)
    self.app_id = 6 
    ngx.say(self.app_id)
end)

app:get("/json", function(self)
    local ret = self.request.params.body
    local t = bjson.decode(ret)
    return t    
end)


return app 


```



### 4.启动服务

```
hi start dev
hi stop dev
hi reload dev
```

### 5.启动服务

测试接口：

```
curl -X GET  http://0.0.0.0/blues -d  '{"key":"value"}'
```

返回结果：


```
{"key":"value"}

```

