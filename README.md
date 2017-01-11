# hilua
HiLua

下面的日志，几乎是整个程序的执行时序，只打开了函数的[s]标记，程序调用开始的标记，而[e]是当前程序结束时应该输出的标记。
```
=============== [s]:Application.new <-
=============== [s]:route.getInstance <-
=============== [s]:Application.app.get <-
=============== [s]:route.base.register <-
=============== [s]:Application.app.get <-
=============== [s]:route.base.register <-
=============== [s]:Application.app.post <-
=============== [s]:route.base.register <-
=============== [s]:Application.app.post <-
=============== [s]:route.base.register <-
=============== [s]:Application.app.run <-
=============== [s]:route.run <-
=============== [s]:app.app:get <-
```
下面的函数，是从注册匿名函数，到匿名函数执行的时序调用日志与入参数据的类型和内容的打印。
```
=============== [s]:Application.new <-
=============== [s]:route.getInstance <-
post    function: 0xc8e890
router  table: 0xc7a280
id      123
get     function: 0xc8e820
run     function: 0xc8e770
req     table: 0xc8e590
=============== [s]:Application.app.get <-
-----this type-----
table
-----this-----
post    function: 0xc8e890
router  table: 0xc7a280
id      123
get     function: 0xc8e820
run     function: 0xc8e770
req     table: 0xc8e590
-----url-----
/def
-----callback type-----
function
----- -----
=============== [s]:route.base.register <-

-----meta-----
GET
-----callback-----
function: 0xc8ed70
-----this type-----
table
-----this-----
map     table: 0xc7a2d0
id      1
-----baseA type-----
table
-----baseA-----
post    function: 0xc8e890
router  table: 0xc7a280
id      123
get     function: 0xc8e820
run     function: 0xc8e770
req     table: 0xc8e590
-----baseB type-----
table
-----baseB-----
post    function: 0xc8e890
router  table: 0xc7a280
id      123
get     function: 0xc8e820
run     function: 0xc8e770
req     table: 0xc8e590
----- -----
=============== [s]:Application.app.run <-
=============== [s]:route.run <-
-----router-----
/def
function: 0xc8ed70
=============== [s]:app.app:get <-
test def
```
以上的数据其实很多都程序单体函数程序的数据，而从路由业务的角度来着，我们最应该关注监控的数据，是路由map中别注册进入的函数。
加入了lm的日志输出方法，会将当前路由表显示出来，日志格式如下，而在register时输出的是路由表态变化的过程。

```
DBG: =============== [s]:Application.app.run <-
DBG: =============== [s]:route.run <-
DBG: -----MAP.GET-----
1       /testcase
2       function: 0x1ee1650
1       /def
2       function: 0x1edce10
DBG: -----MAP.POST-----
1       /post
2       function: 0x1ef07e0
1       /post1
2       function: 0x1eebd40
1       /log
2       function: 0x1ef1ee0
DBG: -----router-----
DBG: /post
DBG: function: 0x1ef07e0
DBG: /post1
DBG: function: 0x1eebd40
DBG: /log
DBG: function: 0x1ef1ee0
DBG: =============== [e]:route.run.POST <-
log
DBG: =============== [e]:Application.app.run <-
```
带“DBG：”字样的是有颜色输出，最后在route.run.POST时序结束后，调用了一个新注册的POST方法”log“,对应的路由也是'/log',这样一来log日志就被分成了3大类：
### 1.时序日志。
### 2.函数单体形参，retuan的，入力出力数据日志。
### 3.路由表日志。

```lua
app:post("/log", function(request,id)
        lm("log")
end)
```
