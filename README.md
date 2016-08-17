用lua实现的简单的开发人员发布补丁包工具

流程:
使用svn命令更新资源和其他开发人员的代码
将目标资源和代码拷贝到当前目录的input目录
根据内外网决定是否需要将lua编译成luac
生成manifest
将资源和manifest上传到服务器
生成apk安装包
将安装包以及版本备份提交到svn

环境要求
lua + lfs + md5
建议使用luarockets安装lfs和md5库

分为内网和外网
外网中间多一步编译为luac

备注
需要自己生成一个config.lua定义好NeiwangIp WaiwangIp NeiwangPass WaiwangPass
