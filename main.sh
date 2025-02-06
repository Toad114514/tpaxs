#!/data/data/com.termux/files/usr/bin/bash

source $PREFIX/lib/tpaxs/global

tps_banner(){
  echo "  _   ____                
 ${R}| |_|  _ \ __ ___  _____ 
 ${G}| __| |_) / _\` \ \/ / __|
 ${B}| |_|  __/ (_| |>  <\___\\
  ${Y}\__|_|   \__,_/_/\_\___/"
  echo
  echo "${B}${BOLD}tPaxs ${R}Dev ${version}${RES} By Toad114514"
  case $LANGUAGE in
    "zh-CN")
      echo "全自动 Termux 部署/配置/运行工具框架"
      echo "输入 help 查看 tPaxs 提供的全部功能"
      echo "exit 或者 quit 都可以退出 tpaxs"
    ;;
    "en-US" | *)
      echo "Automatic Termux build/config and running tools framework"
      echo "input 'help' to show all useful tools from tpaxs"
      echo "'exit' or 'quit' can exit tpaxs"
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
    echo "${Y}注意：$work_path/tools 目录不存在，尝试创建...${RES}"
    mkdir $work_path/tools
    if [ $? -ne 0 ];then
      echo "${R}错误：$work_path/tools 无法创建。请手动创建并重新启动 tpaxs。${RES}"
      exit 91
    fi
  fi
}

help_find(){
  echo "tPaxs 提供的所有功能"
  echo "${G}绿色部分为对应启动命令 ${Y}黄色名称 ${B}蓝色版本${RES}"
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
          local coms=$(echo $f|sed 's?/data/data/com.termux/files/usr/lib/tpaxs/tools/??')
          echo "${G}${BOLD}$coms: ${Y}$name ${B}[$ver]${RES}"
          echo "   $desc"
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

command_input(){
  case $1 in
    "help") help_find ;;
    "exit" | "quit") exit_look ;;
    *) opentools $1 ;;
  esac
}


tps_banner
tps_check
sleep 1
while [ 1 ]
do
  read -p "${G}${users}&${BOLD}/tpaxs ${G}$: ${RES}" command
  command_input $command
done