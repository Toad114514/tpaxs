#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global
source $work_path/tools/tdesking/scripts.sh

tdking_path=$work_path/tools/tdesking
bin_path=$PREFIX/usr/bin
banner(){
  echo "古希腊掌管 Termux Desktop 的神"
}

# INSTALL
install_xfce4(){
  read -p "你想要安装${Y}精简版本${RES}吗？[y(es)/n(o)/e(xit)]" select
  case "$select" in
    "n" | "no")
      pkg list-installed|grep xfce4 &>/dev/null
      if [ ! $? -eq 0 ];then
        apt_echo xfce4
        tps_done "xfce4 安装完成"
        sleep 2
      else
        tps_done "你已经安装了 xfce4，不必再继续安装"
        sleep 2
      fi
    ;;
    "y" | "yes") install_xfce4_mini ;;
    * | "e" | "exit") : ;;
  esac
}

install_xfce4_mini(){
  apt_echo "xfwm4 xfce4-panel xfdesktop4 xfce4-session xfce4-settings xfconf"
  tps_done "xfce4 精简版安装完成"
  sleep 2
}

install_mate(){
  apt_echo "macro mate-*"
  tps_done "mate 安装完成"
  sleep 2
}

install_lxqt(){
  apt_echo lxqt
  tps_done "lxqt 安装完成"
  sleep 2
}

tx11_legacy(){
  read -p "使用传统绘图吗？（兼容老年机例如oppoa5，设置将应用到全部已创建脚本）[y(es)/n(o)]: " sel
  case $sel in
    "y" | "yes")
      if [ -f $bin_path/xfce4 ];then
        sed -i '2s/.*/termux-x11 :0 -legacy' $bin_path/xfce4
      fi
      if [ -f $bin_path/mate ];then
        sed -i '2s/.*/termux-x11 :0 -legacy' $bin_path/mate
      fi
      if [ -f $bin_path/lxqt ];then
        sed -i '2s/.*/termux-x11 :0 -legacy' $bin_path/lxqt
      fi
    "n" | "no")
      if [ -f $bin_path/xfce4 ];then
        sed -i '2s/.*/termux-x11 :0' $bin_path/xfce4
      fi
      if [ -f $bin_path/mate ];then
        sed -i '2s/.*/termux-x11 :0' $bin_path/mate
      fi
      if [ -f $bin_path/lxqt ];then
        sed -i '2s/.*/termux-x11 :0' $bin_path/lxqt
      fi
  esac
}

tx11(){
  pkg list-installed|grep termux-x11-nightly &>/dev/null
  if [ ! $? = 0 ];then
    apt_echo termux-x11-nightly
  fi
  echo "${G}Termux-x11 settings"
  echo "${RES}1) 使用传统绘图 (兼容老年机)"
  echo "99) 返回"
  read -p "选择：" sel
  case $sel in
    "1") tx11_legacy ;;
    "99") : ;;
  esac
}

input(){
  echo "1) 安装 xfce4"
  echo "2) 安装 mate"
  echo "3) 安装 lxqt"
  echo "4) 部署 tx11"
  echo "5) 部署显卡加速 virglrender"
  echo "6) 安装常用软件"
  echo "7) 解决 Android 12 signal 9 问题"
  echo "8) 一条龙服务"
  echo "9) 创建启动脚本"
  echo "10) 查看帮助"
  echo "99) 退出"
  read -p "请做出你的选择：" select
}

onedragon(){
  echo "One-Dragon 一条龙服务"
  echo "===================="
  echo "你要装："
  echo "1) 安装 xfce4"
  echo "2) 安装 mate"
  echo "3) 安装 lxqt"
  echo "99) 不用搞了"
  read -p "请做出你的选择：" select
  local leave=0
  case $select in
    "1") install_xfce4 ;;
    "2") install_mate ;;
    "3") install_lxqt ;;
    "4") leave=1 ;;
  esac
  if [ $leave -eq 0 ];then
    startup
    echo "====================="
    echo "One-Dragon 一条龙服务"
    echo "   已完成任务，正在返回..."
    echo "====================="
  fi
}

banner
while [ 1 ]
do
input
case $select in
    "1") install_xfce4 ;;
    "2") install_mate ;;
    "3") install_lxqt ;;
    "4") tx11 ;;
    "5") echo "不打算搞" ;;
    "6") echo "我还没有做好" ;;
    "7") echo "我还没有做好" ;;
    "8") onedragon ;;
    "9") startup ;;
    "99") echo "期待你的下次使用" && break;;
esac
done