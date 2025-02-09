#!/data/data/com.termux/files/usr/bin/bash

source $PREFIX/lib/tpaxs/global

tps_banner(){
  echo "  _   ____                
 ${R}| |_|  _ \ __ ___  _____ 
 ${G}| __| |_) / _\` \ \/ / __|
 ${B}| |_|  __/ (_| |>  <\___\\
  ${Y}\__|_|   \__,_/_/\_\___/"
  echo
  echo "${B}${BOLD}tPaxs ${R}Dev ${tps_version}${RES} By Toad114514"
  case $LANGUAGE in
    "zh-CN")
      echo "全自动 Termux 部署/配置/运行工具框架"
      echo "输入 help 查看 tPaxs 框架提供命令"
      echo "输入 ls 查看 tPaxs 提供的全部功能"
    ;;
    "en-US" | *)
      echo "Automatic Termux build/config/running tools framework"
      echo "input 'help' to show all command of tPaxs framework"
      echo "input 'ls' to show all useful tools from tpaxs"
    ;;
  esac
}

# exit
exit_look(){
  echo "Bye Bye!"
  exit 0
}
# testing...
tps_check(){
  if [ ! -d $work_path/tools ]; then
    case $LANGUAGE in
      "zh-CN") echo "${Y}注意：$work_path/tools 目录不存在，尝试创建...${RES}" ;;
      "en-US" | *) echo "${Y}Warning: $work_path/tools is no found and try to create...${RES}" ;;
    esac
    mkdir $work_path/tools
    if [ $? -ne 0 ];then
      case $LANGUAGE in
        "zh-CN") echo "${R}错误：$work_path/tools 无法创建。请手动创建并重新启动 tpaxs。${RES}" ;;
        "en-US" | *) echo "${R}Error: Can't not create $work_path/tools directory. Please create and restart tpaxs manullay.${RES}" ;; 
      esac
      exit 91
    fi
  fi
}

help_find(){
  echo "tPaxs 提供的所有功能"
  echo "${G}绿色部分为对应启动命令 ${Y}黄色是名称 ${B}蓝色是版本 ${R}红色是作者名${RES}"
  echo
  local canuse=0
  local cnotuse=0
  # list
  local indexofini=0
  declare -A noini
  local indexofnomain=0
  declare -A nomain
  for f in $(find $work_path/tools -type d)
  do
    if [ "$f" = "$work_path/tools" ]; then
      :
    else
      if [ ! -f $f/main.sh ];then
        nomain[$indexofnomain]=$f
        cnotuse=`expr $cnotuse + 1`
        indexofnomain=`expr $indexofnomain + 1`
      else
        if [ ! -f $f/info.ini ];then
          noini[$indexofini]=$f
          canuse=`expr $canuse + 1`
          indexofini=`expr $indexofini + 1`
        else
          local name=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'name'/{print $2;exit}' $f/info.ini)
          local desc=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'desc'/{print $2;exit}' $f/info.ini)
          local ver=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'ver'/{print $2;exit}' $f/info.ini)
          local author=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'author'/{print $2;exit}' $f/info.ini)
          local coms=$(echo $f|sed 's?/data/data/com.termux/files/usr/lib/tpaxs/tools/??')
          echo "${G}${BOLD}$coms: ${Y}$name${B}[$ver] by ${R}${author}${RES}"
          echo "   ${desc}"
          canuse=`expr $canuse + 1`
        fi
      fi
    fi
  done
  echo
  echo "${Y}可用功能总共 ${G}$canuse ${Y}个${RES}"
  # list_warning
  for f in ${noini[@]}
  do
    local coms=$(echo $f|sed 's?/data/data/com.termux/files/usr/lib/tpaxs/tools/??')
    tps_warm "找不到 $f 文件夹对应的配置文件，但你仍可使用 $coms 命令"
  done
  for f in ${nomain[@]}
  do
    tps_err "找不到 $f 的主要脚本文件"
  done
}

opentools(){
  local tps_yestofind="false"
  for f in $(find $work_path/tools -type d)
  do
    if [ "$f" = "$work_path/tools" ];then
      :
    else
      local coms=$(echo $f|sed 's?/data/data/com.termux/files/usr/lib/tpaxs/tools/??')
      if [ "$coms" = "$1" ];then
        if [ ! -f $f/main.sh ];then
          tps_err "找不到 $f 的主要脚本文件，无法继续执行 $coms"
          tps_yestofind="91lztdtm"
          break 1
        else
          bash $f/main.sh
          tps_yestofind="91lztdtm"
          break 1
        fi
      fi
    fi
  done
  if [ "$tps_yestofind" = "false" ];then
    tps_err "$work_path/tools/$1: 没有那个目录"
  fi
}

help(){
  case $LANGUAGE in
    "zh-CN")
      echo "tPaxs 框架 ${tps_version}"
      echo "=============================="
      echo "help - 显示框架提供的基础命令"
      echo "ls/list - 列出所有可用的工具功能信息及对应命令"
      echo "exit/quit - 退出 tPaxs 框架"
      echo "=============================="
      echo "tips: 你可以直接在终端运行tPaxs命令或者工具对应命令，如我想要查看工具列表：tpaxs ls"
      ;;
    "en-US" | *)
      echo "tPaxs framework ${tps_version}"
      echo "=============================="
      echo "help - Show all command of framework"
      echo "ls/list - List all available tool feature information and corresponding commands"
      echo "exit/quit - Exit tPaxs framework"
      echo "=============================="
      echo "tips: You can run the tPaxs command or the tool-specific command directly from the terminal, such as if I want to see the list of tools: tpaxs ls"
      ;;
  esac
}

command_input(){
  case $1 in
    "help") help ;;
    "ls" | "list") help_find ;;
    "exit" | "quit") exit_look ;;
    *) opentools $1 ;;
  esac
}


if [ ! -z "$1" ];then
  #echo "tPaxs Framework ${tps_version}"
  case $1 in
    "exit" | "quit") tps_err "你这个喜人发瘟是不是你那个脑压到那条痴线才执行这个命令的哇" && exit 0;;
    *) command_input $1 && exit 0 ;;
  esac
fi
tps_banner
tps_check
sleep 1
while [ 1 ]
do
  read -p "${G}${users}&${BOLD}/tpaxs ${G}$: ${RES}" command
  command_input $command
done
