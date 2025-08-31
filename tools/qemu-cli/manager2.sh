#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

# manager2.sh
qcli_path="$tool_path/qemu-cli"
qcli_vm_f="$conf_path/.qcli_vmfolder"

vmf=$(cat ${conf_path}/.qcli_vmfolder)

getp=$1
vm="${vmf}/$1"
vmc="${vm}/qcli_conf.ini"

look(){
  echo "=============≠≠≠≈============="
  echo ""
  local name=$(iniRead "$vmc" qcli name)
  local machine=$(iniRead "$vmc" qcli machine)
  local mem=$(iniRead "$vmc" qcli memory)
  local smp=$(iniRead "$vmc" qcli smp)
  local hda=$(iniRead "$vmc" qcli hda)
  local cdrom=$(iniRead "$vmc" qcli cdrom)
  local vga=$(iniRead "$vmc" qcli vga)
  local port=$(iniRead "$vmc" qcli vncport)
  echo "虚拟机名字：$name"
  echo "机器类型：$machine"
  echo "分配内存：$mem"
  echo "核心数：$smp"
  echo "磁盘A目录：$hda"
  echo "CD-Rom 目录：$cdrom"
  echo "显卡驱动：$vga"
  local vncp=`expr ${port} + 5900`
  echo "VNC 端口：$vncp"
  echo "=============≠≠≠≈============="
  echo "${Y}<Enter>${RES} 返回"
  read tmps
  clear
}
set(){
  local param=$1
  case $param in
    "name")
      local key="name"
      local text="虚拟机名字"
      local hint="none"
      local help="虚拟机名字，主要起标识作用。"
    ;;
    "machine")
      local key="machine"
      local text="机器类型"
      local hint="q35, pc-i440fx-2.4"
    ;;
    "smp")
      local key="smp"
      local text="CPU 核心数量"
      local hint="none"
      local help="分配几颗核心给虚拟机，未开启 KVM 支持下，仅建议分配一个。"
    ;;
    "mem")
      local key="mem"
      local text="内存分配"
      local hint="none"
      local help="分配多少内存给虚拟机，启动时会占用对应大小运存，输入时默认单位为MB。"
    ;;
  esac
  local now=$(iniRead "$vmc" qcli "$key")
  if [ ! -z "$help" ];then
    echo "=============≠≠≠≈============="
    echo "$help"
  fi
  echo "=============≠≠≠≈============="
  echo "${B}您要修改 ${Y}${text} ${B}吗？"
  echo "${B}目前 ${Y}${text} ${B}值为 ${R}${now}${RES}"
  echo "=============≠≠≠≈============="
  read -p "[y(es)/n(o)]: " sel
  case $sel in
    "y"|"yes")
      if [ "$hint" == "none" ];then
        read -p "${Y}输入新的${text}：${RES}" input
      else
        read -p "${Y}输入新的${text}${G}（可输入：${hint}）${RES}：" input
      fi
      iniWrite "$vmc" qcli ${key} ${input}
      # Change directory to New name
      if [ "$key" == "name" ];then
        mv "$vmf/$now" "$vmf/$input"
      fi
      exit
    ;;
    "n"|"no")
      echo "取消输入，返回。"
      sleep 0.9
    ;;
  esac
}

edit(){
  clear
  echo "=============≠≠≠≈============="
  echo "   修改虚拟机参数"
  echo "=============≠≠≠≈============="
  echo "1. 虚拟机名字"
  echo "2. 机器类型"
  echo "3. 分配核心数"
  echo "4. 分配内存"
  echo "=============≠≠≠≈============="
  echo "   挂载目录"
  echo "01. 硬盘1"
  echo "02. CD-Rom"
  echo "=============≠≠≠≈============="
  echo "   外部硬件模拟"
  echo "001. 显示器"
  echo "002. 显示方案"
  echo "=============≠≠≠≈============="
  echo "99. 返回"
  echo "=============≠≠≠≈============="
  read -p "选择一个进行修改... :" sel
  case $sel in
    "1") set "name" ;;
    "2") set "machine" ;;
    "3") set "smp" ;;
    "4") set "mem" ;;
    "99") : ;;
  esac
}

start(){
  local name=$(iniRead "$vmc" qcli name)
  local machine=$(iniRead "$vmc" qcli machine)
  local mem=$(iniRead "$vmc" qcli memory)
  local smp=$(iniRead "$vmc" qcli smp)
  local hda=$(iniRead "$vmc" qcli hda)
  local cdrom=$(iniRead "$vmc" qcli cdrom)
  local vga=$(iniRead "$vmc" qcli vga)
  local port=$(iniRead "$vmc" qcli vncport)
  local vncp=`expr $port + 5900`
  echo "qemu-system-i386 -machine ${machine} -m ${mem} -smp ${smp} -hda ${hda} -cdrom ${cdrom} -vnc $vncp"
  qemu-system-i386 -machine ${machine} -m ${mem} -smp ${smp} -hda ${hda} -cdrom ${cdrom} -vnc $vncp
}

main(){
  vmname=$(iniRead "$vmc" qcli name)
  echo "=========================="
  echo "    管理虚拟机 ${G}${vmname}${RES}"
  echo "=========================="
  echo "  1) 查看参数"
  echo "  2) 修改参数"
  echo "  3) 启动虚拟机"
  echo "  4) 退出"
  echo "=========================="
  read -p "请选择：" sel
  case ${sel} in
    "1") look ;;
    "2") edit ;;
    "3") start ;;
    "4") exit ;;
  esac
}

while [ 1 ];do
  main
done