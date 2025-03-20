#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

omt_path=$work_path/tools/omtermux
source $omt_path/banner.sh

ins_omz(){
  echo "正在安装 omz，请稍候..."
  git clone https://github.com/oh-my-zsh/oh-my-zsh
  cd oh-my-zsh
}

check_omz(){
  sleep 1
  if [ -d $HOME/.oh-my-zsh ];then
    echo "${Y}oh-my-zsh 还没有安装，你要安装吗？${RES}"
    read -p "[y/n]: " sel
    case $sel in
      "y") start_omz ;;
      "n") echo "goodbye" ;;
    esac
  fi
}

main(){
  printf "欢迎使用 oh-my-termux!\n"
  check_omz
}

banner
main