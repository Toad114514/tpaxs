#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global
github_address='https://github.com'


banner(){
  echo "Metasploit Framework 6 Install Wizard"
  echo "Metasploit 安装向导"
}
startup_ok(){
  echo "===================================="
  echo "这将${Y}全新安装 Metasploit 6${RES}，你确定吗？"
  echo "=============== [${Y}y(es) ${RES}/ ${R}n(o)${RES}] ====="
  read -p "INPUT: " sel
}

alldone(){
  sleep 1
  echo "================================"
  echo "Metasploit 安装完成！"
  echo "你的 msf6 安装位置：$msf_path"
  echo "启动 msf6 命令行：${Y}msfconsole${RES}"
  echo "请开始你的高级渗透罢（喜"
  echo "================================"
  exit 0
}

start_ins(){
  tps_info "开始安装 msf6..."
  tps_info "安装必要依赖......."
  pkg update -y
  pkg upgrade -y -o Dpkg::Option::="--force-confnew"
  apt_echo "autoconf apr apr-utils bison binutils clang coreutils curl findutils libgmp libffi libpcap libsqlite libgrpc libtool libxml2 libxslt ncurses ncurses-utils make openssh readline git wget unzip tar zip termux-tools termux-elf-cleaner pkg-config ruby -o Dpkg::Option::='--force-confnew'"
  if [ ! $? = 0 ];then
    tps_err "apt 发生错误，请检查错误然后继续。"
  else
    tps_ok "依赖安装完成"
    echo "========================"
    echo "准备下载 msf6......"
    echo "由于需要从 github 克隆仓库，${R}可能需要搭梯${RES}"
    echo "没有魔法/克隆速度慢的可以修改 $work_path/tools/msf_ins/main.sh 中的第3行"
    echo "${B}github_address='https://github.com'${RES}"
    echo "修改成 ${B}github_address='https://kkgithub.com'${RES}"
    echo "这将会使用 kkgithub 镜像源克隆仓库"
    echo "修改后请重新启动该脚本"
    echo "========================="
    sleep 1
    tps_info "开始 clone"
    git clone ${github_address}/rapid7/metasploit-framework --depth=1 $msf_path
    if [ ! $? = 0 ];then
      tps_err "git clone 失败，请查看上方日志，排除错误后再重启该脚本。"
    else
      tps_info "开始安装 msf6..."
      cd $msf_path
      gem install bundle
      if [ ! $? = 0 ];then
        tps_err "无法安装 bundle，请检查错误并重启该脚本"
      else
        gem install nokogiri -v $(cat Gemfile.lock|grep -i nokogiri|sed 's/nokogiri [\(\)]/(/g'|cut -d ' ' -f 5|grep -oP "(.).[[:digit:]][\w+]?[.].") -- --with-cflags="-Wno-implicit-function-declaration -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types" --use-system-libraries
        if [ ! $? = 0 ];then
          tps_err "无法安装 nokogiri，请检查错误并重启该脚本"
        else
          bundle install
          gem install actionpack
          bundle update actionpack
          bundle update --bundle
          bundle install -j$(nproc --all)
          tps_info "正在添加链接..."
          ln -sf $msf_path/msfconsole $PREFIX/bin/msfconsole
          ln -sf $msf_path/msfvenom $PREFIX/bin/msfvenom
          ln -sf $msf_path/msfrpcd $PREFIX/bin/msfrpcd
          termux-elf-cleaner $PREFIX/lib/ruby/gems/*/gems/pg-*/lib/pg-ext.so
          tps_done "msf6 安装完成！"
          alldone
        fi
      fi
    fi
  fi
}

rmfolder(){
  rm -rf $msf_path
  mkdir $msf_path
}

check_folder(){
  if [ ! -z $(ls -A "$msf_path") ];then
    echo "======================================"
    echo "${R}$msf_path 文件夹内仍有文件/文件夹/隐藏文件！"
    tree $msf_path
    echo "如果继续安装则将会清除该文件夹及上方全部文件"
    echo "${Y}你确定要继续安装吗${B}（可以先备份里面文件然后继续）${RES}"
    echo "=============== [${Y}y(es) ${RES}/ ${R}n(o)${RES}] ====="
    read -p "INPUT: " sel
    case $sel in
      "y" | "yes")
        rmfolder
        start_ins
      ;; 
      "n" | "no") echo "用户已取消安装。" ;;
    esac
  else
    start_ins
  fi
}

settings(){
  echo "======================================"
  echo "请输入${B}要安装 msf6 的文件夹路径${RES}"
  echo "默认为 ${Y}$PREFIX/opt/metasploit-framework${RES}"
  echo "======================================"
  read -p "INPUT: " sel
  if [ -z $sel ];then
    msf_path=$PREFIX/opt/metasploit
  else
    msf_path=$sel
  fi
  check_folder
}

banner
startup_ok
case $sel in
  "y" | "yes") setting ;;
  "n" | "no") echo "goodbye!" ;;
esac