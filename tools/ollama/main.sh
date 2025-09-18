#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

# ollama 源码路径
#ollama_path=$PREFIX/opt/ollama
ollama_path=$HOME/ollama
# ollama 仓库地址
ollama_repo=https://github.com/ollama/ollama.git

state(){
  case $LANGUAGE in
    "zh-CN") printf "ollama 状态: " ;;
    "en-US"|*) printf "ollama state: " ;;
  esac
  if [ -f $ollama_path/ollama ];then
    case $LANGUAGE in
      "zh-CN") printf "${G}已完成编译 |" ;;
      "en-US" | *) printf "${G} Compiled |" ;;
    esac
    case $LANGUAGE in 
    "zh-CN")
    if [ ! -z "$(pgrep ollama)" ];then
      printf "${G} 服务已启动\n"
    else
      printf "${R} 服务未启动\n"
    fi
    ;;
    "en-US" | *)
    if [ ! -z "$(pgrep ollama)" ];then
      printf "${G} Server is started\n"
    else
      printf "${R} Server not start\n"
    fi
    ;;
    esac
  else
    case $LANGUAGE in 
      "zh-CN") printf "${R}未编译\n" ;;
      "en-US") printf "${R}No compile" ;;
    esac
  fi
  printf "${RES}"
}

osetup(){
  tps_info "克隆仓库...(如果克隆速度慢，您可以在 ${work_path}/tools/ollama/main.sh 的第8行修改其他ollama仓库地址)"
  git clone $ollama_repo --depth=1 $ollama_path
  cd $ollama_path
  tps_info "初始化 ollama 编译环境..."
  go generator .
  tps_info "编译 ollama..."
  go build .
  tps_info "创建软链接"
  ln -sf ./ollama $PREFIX/bin/ollama
  tps_info "尝试修复依赖"
  chmod +x ./ollama
  tps_done "您的 ollama 已完成安装！稍后会跳回主菜单！请重新打开本工具，会自动启动 ollama 服务！"
  sleep 1
}

ollama_setup(){
  echo "确认在 ${G}$ollama_path${RES} 文件夹下编译安装 ollama 吗？"
  read -p "[y/n]: " sel
  case $sel in
    "y") osetup ;;
    "n") : ;;
  esac
}

startrun(){
case "$1" in
  "1") ollama run deepseek-r1:1.5b ;;
  "2") ollama run deepseek-r1 ;;
  "3") ollama run liama3.2 ;;
  "4") ollama run liama3.2:1b ;;
esac
}

ollama_start(){
  if [ -z "$(pgrep ollama)" ];then
    tps_err "ollama 服务未运行，请先运行 ollama 服务。"
  else
    ollama_startlist
  fi
}

ollama_startlist(){
  case $LANGUAGE in
  "zh-CN")
  echo "[       请选择你的AI大模型        ]"
  echo "=============================="
  echo "1. Deepseek-R1 模型 (1.5B) ${G}[烂机子适用]${RES}"
  echo "2. Deepseek-R1 模型 (7B) ${G}[游戏机适用]${RES}"
  echo "3. liama 3.2 模型 (3B)"
  echo "4. liama 3.2 模型 (1B)"
  read -p "选择对应序号：" sel
  tps_info "第一次使用时需要下载对应模型数据，接着便可继续使用，你明白吗？"
  ;;
  "en-US" | *)
  echo "[       Select your AI Model        ]"
  echo "=============================="
  echo "1. Deepseek-R1 (1.5B) ${G}[Low]${RES}"
  echo "2. Deepseek-R1 (7B) ${G}[High]${RES}"
  echo "3. liama 3.2 (3B)"
  echo "4. liama 3.2 (1B)"
  read -p "Select your Model：" sel
  tps_info "To first use model, ollama need to download this model data. This step will consumes a lot of time. Are you know that?"
  ;;
  esac
  read -p "[y/n]: " ok
  case "$ok" in
    "y")
      case $LANGUAGE in
        "zh-CN") echo "弟子明白！" ;;
        "en-US" | *) echo "I know!" ;;
      esac
      sleep 1
      startrun $sel
      ;;
    "n") : ;;
  esac
}

main(){
  state
  echo "====================="
  case $LANGUAGE in
  "zh-CN")
  echo "1. 编译(安装) ollama"
  echo "2. 启动 ollama 服务"
  echo "3. 运行 ollama 模型"
  echo "99. 退出"
  ;;
  "en-US" | *)
  echo "1. Compiles(Install) ollama"
  echo "2. Startup ollama server"
  echo "3. Run ollama model"
  ;;
  esac
  echo "====================="
  case $LANGUAGE in
    "zh-CN") read -p "输入：" sel ;;
    "en-US" | *) read -p "Input: " sel ;;
  esac
}

while [ 1 ]
do
main
case "$sel" in
 "1") ollama_setup ;;
 "2")
   ollama serve &>/dev/null &
   sleep 2
   if [ -z "$(pgrep ollama)" ];then
     tps_err "ollama 服务未正常启动。请退出工具手动在终端运行 ollama serve 排除错误。"
   else
     tps_info "ollama 服务已启动。PID: $(pgrep ollama)"
   fi
   ;;
 "3") ollama_start ;;
 "99")
   pkill ollama
   break
 ;;
esac
done
