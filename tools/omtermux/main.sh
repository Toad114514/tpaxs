#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

omt_path=$work_path/tools/omtermux
source $omt_path/banner.sh

start_omz(){
  echo "正在安装 omz，请稍候..."
  apt_echo zsh
  # case $(read -p "使用国内源加速还是使用Github？[github/gitee]")
  # git clone https://github.com/oh-my-zsh/oh-my-zsh
  # cd oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

check_omz(){
  sleep 1
  if [ -d $HOME/.oh-my-zsh ];then
    echo "${Y}oh-my-zsh 还没有安装，你要安装吗？${RES}"
    read -p "[y/n]: " sel
    case $sel in
      "y") start_omz ;;
      "n") exit 1 ;;
    esac
  fi
}

p10k_ins(){
  case $(read -p "使用 Github 源还是 Gitee 源？（国内建议使用 Gitee 源，默认为 Gitee）[github/gitee]: ") in
    "github") ROOT_DOMAIN="github.com" ;;
    "gitee") ROOT_DOMAIN="gitee.com" ;;
  esac
  git clone https://${ROOT_DOMAIN}/romkatv/powerlevel10k --depth 1 $HOME
  echo "source $HOME/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
  echo "powerlevel10k配置完毕。接下来您需要重新打开 Termux 来继续配置主题。（等下脚本将帮助您退出 Termux，如果发现闪退请不要害怕，这是正常现象。"
  sleep 3
  kill -9 $(pgrep com.termux)
}

main(){
  printf "欢迎使用 oh-my-termux!\n"
  check_omz
  echo " 1. 安装 Powerlevel10k 主题"
  echo " 2. 安装命令自动补全插件"
  echo " 3. 安装命令高光插件"
  echo " 99. 退出"
  case $(read -p "omz_install: ") in
    "1") p10k_ins ;;
    "99") exit 0 ;;
  esac
}

banner
main