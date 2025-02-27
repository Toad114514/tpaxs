# ../global 定义说明
## 变量
### ${R} ${G} ${Y} ${B} ${P} ${C}
***一些颜色，从左到右分别为红、绿、黄、蓝、紫、青***
### ${BOLD}
***粗体、主要是高亮***
### ${RES}
***重置颜色以及任何其他终端状态***
### ${tps_version}
***tPaxs 版本***
### ${users}
***用户名***
### ${LANGUAGE}
***tPaxs 语言设定值，返回 `$work_path/config/lang` 下的内容，借此可为工具搞 i18n 功能***
### ${work_path}
***tPaxs 工作目录，永远都是 `$PREFIX/lib/tpaxs`***

## 函数
### apt_echo <包名>
***输出带颜色的 apt install -y <包名> 并自动使用 apt 安装，用于为用户展示要安装的内容，实际用处应该很少吧***
### tps_info <内容>
***输出一串格式化的信息 Debug***
格式如下：\[IFO\] \[hh:mm:ss\] \<内容\>，用于更好的给开发者可视化调试信息
### tps_err
***上同***
格式如下：\[ERR\] \[hh:mm:ss\] \<内容\>
### tps_warn
***上同***
格式如下：\[WRM\] \[hh:mm:ss\] \<内容\>
### tps_done
***上同***
格式如下：\[OK \] \[hh:mm:ss\] \<内容\>

## 未测试的函数
### iniRead
*参数：\[file] \[section] \[key]*
读取某ini文件 section 里 key 对应的值
### iniWrite
*参数：\[file] \[section] \[key] \[val]*
写入/修改某ini文件 section 里的 key 对应的值