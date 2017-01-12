这是个实验性的工程，源码基本都来源于LOR框架，然后对Bin目录中的代码，进行了符合个人习惯的改动，做出以下的改动，完全是为了让LOR在使用上有一点类似Django的使用习惯，也为了维护OpenResty China符合个人的习惯，但对LOR目录中的代码没有做任何改动，之后LOR新功能加入，还会Merge进来。



#概要

下面是改动的一些概述：


1.将Nginx的配置和工程的配置分开，Nginx的配置是针对Openresty的conf文件,工程的配置文件是针对当前项目业务的。（未完成）

2.将Nginx的启动脚本启动的方式，改回项目命令行操作。（完成）

3.在原有命令行的基础上添加了project,app两个命令，让Project那种纯nginx的conf文件可以单纯生成，而不自动生成LOR框架的例子代码。app命令就是生成定制化的LOR的example代码，这两个命令的定义在build文件夹中。 而之前的new命令的动作与之前保持一致，同时生成con文件和example文件。（完成）


4.实现一个conf和文件夹的模板工厂，可以选定在build文件夹的定制project.lua和app.lua来生成对应的app文件和独立的nginx配置文件生成，可以定制自己工程的目录构成。（完成一个caese）

5.去掉了三个自动生成的shell。（完成）

6.将MidlleWare也自动生成模板。（未完成）

7.Bin和LOR发生依赖的就是lor.version,把这种调用关系，通过一个config.lua的wrapper来发现关联，如果lor的接口发生变更，改config.lua即可，不需要变动bin目录中的代码。（完成）

8.添加了一个middleware命令，用于自动生成模板。




#命令

可以通简单的命令快速的生成Openresty的配置文件和目录结构：


安装[ORC](https://coding.net/u/shengyang/p/orc/git)，然后执行下下面的操作：

1.安装

```
sudo sh install.sh
```

2.生成工程

```
orc project waf
orc app waf
orc middleware waf xss
```

3.控制OpenResty

进入testcase目录

```
orc start dev
orc stop dev
orc reload dev
```