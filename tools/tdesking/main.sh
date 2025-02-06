#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global
banner(){
  echo "古希腊掌管 Termux Desktop 的神"
}

input(){
  echo "1) 安装 xfce4"
  echo "2) 安装 mate"
  echo "3) 安装 lxqt"
  echo "4) 部署 tx11"
  echo "5) 部署 vncserver"
  echo "6) 安装常用软件"
  echo "7) 解决 Android 12 signal 9 问题"
}
banner
input