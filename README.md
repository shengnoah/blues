# Blues
一个基于Openresty的WEB演示框架。


#命令

可以通简单的命令快速的生成Openresty的配置文件和目录结构：

### 1.安装

```
git clone https://github.com/shengnoah/blues.git
cd blues
sudo sh install.sh
```

### 2.创建项目

```
hi new blues
```

### 3.创建应用


```lua
local bjson = require "utils.bjson"
local app = require "blues"

app:get("/blues", function(self)
    return "blues"
end)

app:get("/json", function(self)
    local t = bjson.decode(self.req.body)
    return t   
end)

return app 
```



### 4.启动服务

```
hi start 
hi stop 
hi restart 
```

### 5.启动服务

测试接口：

```
curl -X GET  http://0.0.0.0:8888/json -d  '{"key":"value"}'
```

返回结果：


```
{"key":"value"}

```

