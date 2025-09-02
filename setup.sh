R=$(printf '\033[31m')
G=$(printf '\033[32m')
Y=$(printf '\033[33m')
B=$(printf '\033[34m')
P=$(printf '\033[35m')
C=$(printf '\033[36m')
RES=$(printf '\033[m')
B=$(printf '\033[1m')

setup_banner(){
  clear
  echo "  _   ____                
 ${R}| |_|  _ \ __ ___  _____ 
 ${G}| __| |_) / _\` \ \/ / __|
 ${B}| |_|  __/ (_| |>  <\___\\
  ${Y}\__|_|   \__,_/_/\_\___/"
  echo "tPaxs 安装向导"
}

apt_echo(){
  echo ${R}apt ${B}install ${Y}$1
  apt install $1
}

tpaxs_path=$PREFIX/lib/tpaxs
install_path=$(pwd)

langs(){
  case $(whiptail --title "选择语言" --menu "Select your language" 30 40 10 \
     "1" "默认检测 $(getprop persist.sys.locale)" \
     "2" "zh_CN (简体中文)" \
     "3" "en_US (English)" \
     "4" "ja_JP (日本語)" 3>&1 1>&2 2>&3) in
     "1") LANGUAGE=$(getprop persist.sys.locale) ;;
     "2") LANGUAGE="zh-CN" ;;
     "3") LANGUAGE="en-US" ;;
     "4") LANGUAGE="ja-JP" ;;
     *) LANGUAGE="zh-CN" ;;
  esac
}

set(){
  case $(whipstail --title "是否使用 termux-api 进行工具提醒？" --menu "如果您的设备已安装了 termux-api，且之后想要被完成的任务提醒的话，请选择是，否则选择否，如果不确定请选择no。" 30 40 10 \
    "1" "yes" \
    "2" "no" 3>&1 1>&2 2>&3) in
    "1")
      echo 1 > $tpaxs_work/config/notifications
      apt_echo termux-api
    ;;
    "2") echo 0 > $tpaxs_work/config/notifications ;;
  esac
}

setup(){
  # Depends Check
  echo "${G}正在检查并安装对应软件包依赖...${RES}"
  pkg list-installed|grep whiptail &>/dev/null
  if [ ! $? -eq 0 ];then
    apt_echo whiptail
  fi
  pkg list-installed|grep aria2 &>/dev/null
  if [ ! $? -eq 0 ];then
    apt_echo aria2
  fi
  pkg list-installed|grep curl &>/dev/null
  if [ ! $? -eq 0 ];then
    apt_echo curl
  fi
  pkg list-installed|grep wget &>/dev/null
  if [ ! $? -eq 0 ];then
    apt_echo wget
  fi
  langs
  echo "${G}获取外部权限...${RES}"
  termux-setup-storage
  echo "${B}选择仓库拉取地址"
  
  echo "${G}获取仓库...${RES}"
  echo "选择从哪里 clone 仓库"
  echo "在国内的用 gitee，国外用 github"
  case $LANGUAGE in
    "zh-CN") echo "${Y}根据语言设置，默认使用 gitee${RES}" ;;
    "en-US") echo "${Y}According to the language setting, it is used github by default${RES}"
  esac
  read -p "[${R}gitee${RES}/${Y}github${RES}]" sel
  case $sel in
    "gitee") git clone https://gitee.com/toadstool/tpaxs --depth=1 $PREFIX/lib/tpaxs ;;
    "github") git clone https://github.com/toad114514/tpaxs --depth=1 $PREFIX/lib/tpaxs ;;
    *)
      case $LANGUAGE in
        "zh-CN") git clone https://gitee.com/toadstool/tpaxs --depth=1 $PREFIX/lib/tpaxs ;;
        "en-US" | *) git clone https://github.com/toad114514/tpaxs --depth=1 $PREFIX/lib/tpaxs ;;
      esac
  esac
  mkdir $tpaxs_path/config
  # bash
  echo "${G}创建软链接...${RES}"
  ln -sf $tpaxs_path/main.sh $PREFIX/bin/tpaxs
  ln -sf $tpaxs_path/main.sh $PREFIX/bin/tps
  ln -sf $tpaxs_path/main.sh $PREFIX/bin/t
  ln -sf $tpaxs_path/update.sh $PREFIX/bin/tupdate
  chmod +x $tpaxs_path/main.sh
}

config(){
  echo $LANGUAGE > $tpaxs_path/config/lang
}

setup_info(){
  echo "Welcome to tPaxs Setup Wizard"
  case $LANGUAGE in
    "zh-CN") read -p "${R}你想要${G}现在安装tPaxs吗？[${Y}Y${RES}/${B}N${RES}]" select ;;
    "en-US"|*) read -p "${R}Do you want to${G}install tPaxs now？[${Y}Y${RES}/${B}N${RES}]" select ;;
  esac
  case "$select" in
   "Y" | "y" | *) setup ;;
   "N" | "n")
     echo "放弃。"
     exit 1
     ;;
   esac
}

setup_banner
setup_info
config
set
echo "
 ====================
 ${G}tPaxs 安装完成！${RES}
 使用 tpaxs 可进入工具框架
 也可以使用简写 tps或者t 命令
 ====================
 祝您使用愉快！
 ====================

"
exit 0