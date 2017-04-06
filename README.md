# Blues
一个基于Openresty的WEB演示框架。




#命令

可以通简单的命令快速的生成Openresty的配置文件和目录结构：


安装[ORC](https://coding.net/u/shengyang/p/orc/git)，然后执行下下面的操作：

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
require "log"
local HiLog = require "HiLog"
local utils = require "utils.utils"
local Application = require "orc"
app = Application.new()


app:get("/blues", function(request,id)
    local ret = request.params.body
    local json = require "cjson"
    local t = json.decode(ret)
    return t
end)
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

