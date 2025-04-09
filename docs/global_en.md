# ../global Definition Description  
[中文](global.md) [English](global_en.md)<br>
## Variables  
### ${R} ${G} ${Y} ${B} ${P} ${C}  
*Colors, from left to right: Red, Green, Yellow, Blue, Purple, Cyan*  
### ${BOLD}  
*Bold text (highlighted)*  
### ${RES}  
*Reset colors and any other terminal states*  
### ${tps_version}  
*Current tPaxs version*  
### ${users}  
*Username used when executing tpaxs*  
### ${LANGUAGE} and ${LANG}  
*tPaxs language setting. Returns the content from `$work_path/config/lang`, enabling i18n functionality for the tool.*  
### ${work_path}  
*tPaxs working directory, always `$PREFIX/lib/tpaxs`*  
### ${tool_path}  
*tPaxs tools directory, always `$PREFIX/lib/tpaxs/tools`*  
### ${conf_path}
*tPaxs configuration directory, which can be used to place configuration files for tools, always `$PREFIX/lib/tpaxs/config`*

## Functions  
### apt_echo \<package name\>  
*Outputs a colored `apt install -y <package name>` command and automatically executes `apt install -y <package name>`. Used to elegantly display installation steps to users.*  
### tps_info \<content\>  
*Outputs formatted informational debug messages.*  
Format: `[IFO] [hh:mm:ss] <content>`, designed to help developers visualize debugging information.  
### tps_err  
*Same as above.*  
Format: `[ERR] [hh:mm:ss] <content>`  
### tps_warn  
*Same as above.*  
Format: `[WRM] [hh:mm:ss] <content>`  
### tps_done  
*Same as above.*  
Format: `[OK ] [hh:mm:ss] <content>`  

## File Read/Write Library  
### iniRead  
*Parameters: [file] [section] [key]*  
Reads the value corresponding to the key in a section of an INI file.  
### iniWrite  
*Parameters: [file] [section] [key] [val]*  
Writes or modifies the value of a key in a section of an INI file.