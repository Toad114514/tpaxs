#!/data/data/com.termux/files/usr/bin/bash

startup(){
  echo "建立哪个桌面环境的启动脚本？"
  pkg list-installed|grep xfce4 &>/dev/null
  if [ $? -eq 0 ];then
    echo "1) xfce4"
  pkg list-installed|grep mate &>/dev/null
  if [ $? -eq 0 ];then
    echo "2) mate"
  pkg list-installed|grep lxqt &>/dev/null
  if [ $? -eq 0 ];then
    echo "3) lxqt"
  read -p "选择：" sel
  case $sel in
    "1")
      pkg list-installed|grep xfce4 &>/dev/null
      if [ ! $? -eq 0 ];then
        echo "无效选项。"
        sleep 0.8
      else
        pkg list-installed|grep vlrglrender &>/dev/null
        if [ $? -eq 0 ];then
          echo "检测到你已经安装好了 virglrender，是否需要使用？"
          read -p "[y(es)/n(o)]: " sel
          case $sel in
            "y" | "yes")
              read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
              case $sel in
                "y" | "yes")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 xfce4 script by toad\ntermux-x11 :0 -legacy-drawing &\nvirgl_test_server_android &\nDISPLAY=:0 startxfce4")
                  echo $write > $PREFIX/bin/xfce4
                  chmod +x $PREFIX/bin/xfce4
                  echo "脚本创建完成！在终端输入 xfce4 启动"
                  sleep 0.8
                  ;;
                "n" | "no")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 xfce4 script by toad\ntermux-x11 :0 &\nvirgl_test_server_android &\nDISPLAY=:0 startxfce4")
                  echo $write > $PREFIX/bin/xfce4
                  chmod +x $PREFIX/bin/xfce4
                  echo "脚本创建完成！在终端输入 xfce4 启动"
                  sleep 0.8
                  ;;
              esac
            "n" | "no")
              read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
              case $sel in
                "y" | "yes")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 xfce4 script by toad\ntermux-x11 :0 -legacy-drawing &\n\nDISPLAY=:0 startxfce4")
                  echo $write > $PREFIX/bin/xfce4
                  chmod +x $PREFIX/bin/xfce4
                  echo "脚本创建完成！在终端输入输入 xfce4 启动"
                  sleep 0.8
                  ;;
                "n" | "no")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 xfce4 script by toad\ntermux-x11 :0 &\n\nDISPLAY=:0 startxfce4")
                  echo $write > $PREFIX/bin/xfce4
                  chmod +x $PREFIX/bin/xfce4
                  echo "脚本创建完成！在终端输入 xfce4 启动"
                  sleep 0.8
                  ;;
              esac
        else
          read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
            case $sel in
              "y" | "yes")
                echo "正在生成脚本..."
                write=$(printf "# termux-x11 xfce4 script by toad\ntermux-x11 :0 -legacy-drawing &\n\nDISPLAY=:0 startxfce4")
                echo $write > $PREFIX/bin/xfce4
                chmod +x $PREFIX/bin/xfce4
                echo "脚本创建完成！在终端输入 xfce4 启动"
                sleep 0.8
                ;;
              "n" | "no")
                echo "正在生成脚本..."
                write=$(printf "# termux-x11 xfce4 script by toad\ntermux-x11 :0 &\n\nDISPLAY=:0 startxfce4")
                echo $write > $PREFIX/bin/xfce4
                chmod +x $PREFIX/bin/xfce4
                echo "脚本创建完成！在终端输入 xfce4 启动"
                sleep 0.8
                ;;
            esac
        fi
      fi
    "2")
      pkg list-installed|grep mate &>/dev/null
      if [ ! $? -eq 0 ];then
        echo "无效选项。"
        sleep 0.8
      else
        pkg list-installed|grep vlrglrender &>/dev/null
        if [ $? -eq 0 ];then
          echo "检测到你已经安装好了 virglrender，是否需要使用？"
          read -p "[y(es)/n(o)]: " sel
          case $sel in
            "y" | "yes")
              read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
              case $sel in
                "y" | "yes")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 mate script by toad\ntermux-x11 :0 -legacy-drawing &\nvirgl_test_server_android &\nDISPLAY=:0 mate-session")
                  echo $write > $PREFIX/bin/mate
                  chmod +x $PREFIX/bin/mate
                  echo "脚本创建完成！在终端输入 mate 启动"
                  sleep 0.8
                  ;;
                "n" | "no")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 mate script by toad\ntermux-x11 :0 &\nvirgl_test_server_android &\nDISPLAY=:0 mate-session")
                  echo $write > $PREFIX/bin/mate
                  chmod +x $PREFIX/bin/mate
                  echo "脚本创建完成！在终端输入 mate 启动"
                  sleep 0.8
                  ;;
              esac
            "n" | "no")
              read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
              case $sel in
                "y" | "yes")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 mate script by toad\ntermux-x11 :0 -legacy-drawing &\n\nDISPLAY=:0 mate-session")
                  echo $write > $PREFIX/bin/mate
                  chmod +x $PREFIX/bin/mate
                  echo "脚本创建完成！在终端输入 mate 启动"
                  sleep 0.8
                  ;;
                "n" | "no")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 mate script by toad\ntermux-x11 :0 &\n\nDISPLAY=:0 mate-session")
                  echo $write > $PREFIX/bin/mate
                  chmod +x $PREFIX/bin/mate
                  echo "脚本创建完成！在终端输入 mate 启动"
                  sleep 0.8
                  ;;
              esac
        else
          read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
            case $sel in
              "y" | "yes")
                echo "正在生成脚本..."
                write=$(printf "# termux-x11 mate script by toad\ntermux-x11 :0 -legacy-drawing &\n\nDISPLAY=:0 mate-session")
                echo $write > $PREFIX/bin/mate
                chmod +x $PREFIX/bin/mate
                echo "脚本创建完成！在终端输入 mate 启动"
                sleep 0.8
                ;;
              "n" | "no")
                echo "正在生成脚本..."
                write=$(printf "# termux-x11 mate cript by toad\ntermux-x11 :0 &\n\nDISPLAY=:0 mate-session")
                echo $write > $PREFIX/bin/mate
                chmod +x $PREFIX/bin/mate
                echo "脚本创建完成！在终端输入 mate 启动"
                sleep 0.8
                ;;
            esac
        fi
      fi
    "3")
      pkg list-installed|grep lxqt &>/dev/null
      if [ ! $? -eq 0 ];then
        echo "无效选项。"
        sleep 0.8
      else
        pkg list-installed|grep vlrglrender &>/dev/null
        if [ $? -eq 0 ];then
          echo "检测到你已经安装好了 virglrender，是否需要使用？"
          read -p "[y(es)/n(o)]: " sel
          case $sel in
            "y" | "yes")
              read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
              case $sel in
                "y" | "yes")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 lxqt script by toad\ntermux-x11 :0 -legacy-drawing &\nvirgl_test_server_android &\nDISPLAY=:0 startlxqt")
                  echo $write > $PREFIX/bin/lxqt
                  chmod +x $PREFIX/bin/lxqt
                  echo "脚本创建完成！在终端输入 lxqt 启动"
                  sleep 0.8
                  ;;
                "n" | "no")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 lxqt script by toad\ntermux-x11 :0 &\nvirgl_test_server_android &\nDISPLAY=:0 lxqt")
                  echo $write > $PREFIX/bin/lxqt
                  chmod +x $PREFIX/bin/lxqt
                  echo "脚本创建完成！在终端输入 lxqt 启动"
                  sleep 0.8
                  ;;
              esac
            "n" | "no")
              read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
              case $sel in
                "y" | "yes")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 lxqt script by toad\ntermux-x11 :0 -legacy-drawing &\n\nDISPLAY=:0 startlxqt")
                  echo $write > $PREFIX/bin/lxqt
                  chmod +x $PREFIX/bin/lxqt
                  echo "脚本创建完成！在终端输入 lxqt 启动"
                  sleep 0.8
                  ;;
                "n" | "no")
                  echo "正在生成脚本..."
                  write=$(printf "# termux-x11 lxqt script by toad\ntermux-x11 :0 &\n\nDISPLAY=:0 startlxqt")
                  echo $write > $PREFIX/bin/lxqt
                  chmod +x $PREFIX/bin/lxqt
                  echo "脚本创建完成！在终端输入 lxqt 启动"
                  sleep 0.8
                  ;;
              esac
        else
          read -p "是否使用传统绘图模式？（老年机/渣机需要使用）[y(es}/n(o)]: " sel
            case $sel in
              "y" | "yes")
                echo "正在生成脚本..."
                write=$(printf "# termux-x11 lxqt script by toad\ntermux-x11 :0 -legacy-drawing &\n\nDISPLAY=:0 startlxqt")
                echo $write > $PREFIX/bin/lxqt
                chmod +x $PREFIX/bin/lxqt
                echo "脚本创建完成！在终端输入 lxqt 启动"
                sleep 0.8
                ;;
              "n" | "no")
                echo "正在生成脚本..."
                write=$(printf "# termux-x11 lxqt cript by toad\ntermux-x11 :0 &\n\nDISPLAY=:0 startlxqt")
                echo $write > $PREFIX/bin/lxqt
                chmod +x $PREFIX/bin/lxqt
                echo "脚本创建完成！在终端输入 lxqt 启动"
                sleep 0.8
                ;;
            esac
        fi
      fi
  esac
}