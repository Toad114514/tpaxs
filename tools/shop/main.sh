#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

multi(){
  echo "==========================="
  echo "     ${Y}多媒体${RES}"
  echo "==========================="
  echo " 1) ffmpeg: 多功能媒体处理库"
  echo " 2) mpv: 专业的视频查看器"
  echo " 3) jp2a: 图片转 ascii 工具"
  echo " 4) go-musicfox: 终端下的网易云音乐播放器"
  echo " 5) mpd: 简易的音乐播放器Deamon"
  echo "==========================="
  read -p "sel/multimedia: " sel
  case $sel in
    "1") ins ffmpeg ;;
    "2") ins mpv ;;
    "3") ins jp2a ;;
    "4") ins go-musicfox ;;
    "5") ins mpd ;;
  esac
}

x11(){
  echo "==========================="
  echo "     ${Y}X11/Freedesktop${RES}"
  echo "==========================="
  echo " 1) audacious: Linux 音乐播放器"
  echo " 2) gimp: 高级图片编辑器"
  echo " 3) vlc: VideoLan 非盈利组织的多媒体播放器"
  echo " 4) firefox: 网络浏览器"
  echo " 5) pcmanfm: 简易的文件管理器"
  echo " 6) pcmanfm-qt: 上面文件管理器的 Qt 版本"
  echo " 7) glmark2: GPU 跑分工具"
  echo " 8) vim-gtk: 图形化 vim"
  echo " 9) xclock: X 时钟"
  echo "==========================="
  read -p "sel/x11: " sel
  case $sel in
    "1") ins audacious ;;
    "2") ins gimp ;;
    "3") ins vlc ;;
    "4") ins firefox ;;
    "5") ins pcmanfm ;;
    "6") ins pcmanfm-qt ;;
    "7") ins glmark2 ;;
    "8") ins vim-gtk ;;
    "9") ins xorg-xclock ;;
    *) : ;;
  esac
}

dev(){
  echo "==========================="
  echo "     ${Y}Deploments${RES}"
  echo "==========================="
  echo " 1) Nano: 经典便携式 GNU 编辑器"
  echo " 2) vim: 强大可扩展的终端编辑器，vi 前身"
  echo " 3) neovim: vim 但是你可以给他装插件！"
  echo " 4) cmake: 友好的编译配置生成工具"
  echo " 5) python3: 友好简单的高级编程语言开发环境，初学者入坑代码必学"
  echo "==========================="
  read -p "sel/dev: " sel
  case $sel in
    "1") ins nano ;;
    "2") ins vim ;;
    "3") ins neovim ;;
    "4") ins cmake ;;
    "5") ins python3 ;;
    *) : ;;
  esac
}

ins(){
  apt_echo $1
  echo "$1 安装完成，按下回车继续..."
  echo "Press ${Y}<Enter>${RES} to continue..."
  read
  clear
}

title(){
  clear
  echo "   应用商店"
  echo "======================"
  echo " 1) 多媒体"
  echo " 2) 开发"
  echo " 3) X11/FreeDesktop"
  echo " 4) 游戏"
  echo " 5) 终端程序"
  echo " 6) 其他"
  echo "======================"
  echo " 如果你不小心点进某个分类想退出，只需输入序号以外的内容即可。"
  echo "======================"
  echo " 99) 退出"
}

while [ 1 ]
do
  title
  read -p "输入：" sel
  clear
  case $sel in
    "1") multi ;;
    "2") dev ;;
    "3") x11 ;;
    "4") game ;;
    "99") exit 0 ;;
    *) : ;;
  esac
done