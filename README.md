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
