# hilua
HiLua

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
上面的日志，几乎是整个程序的执行时序，只打开了函数的[s]标记，程序调用开始的标记，而[e]是当前程序结束时应该输出的标记。
