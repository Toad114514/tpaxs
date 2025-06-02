#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global
# QemuCli
# ByToad114
#         Roadmap
#  - 基础的 Qemu 软件包检查与安装
#  - 创建虚拟机
#  - 自定义虚拟机存放位置
#  - 管理及运行
#    - 菜单 (HEAD/repo)
#    - 具体管理/运行 (接下来的实现)

# 更新日志：
#  v0.24 准备开工 manager2.sh
#  v0.23.5 已完成测试 manager.sh，修复基础bug
#  v0.23.2 完工 manager.sh 实现菜单显示
#  v0.23 开工 manager.sh 
#  v0.22 完成 create.sh （基础测试已过）
#  v0.21 开工 create.sh
#  v0.2 自定义 vm 文件夹及提示（还是模仿小鸟游星野的语气呢~）
#  v0.1 完成基础 qemu 安装及检测功能（提示和报错都有模仿星野的说话语气呢~）


qcli_ver="v0.23.5"
qcli_status="dev"
qcli_path="$tool_path/qemu-cli"
qcli_vm_f="$conf_path/.qcli_vmfolder"

check_folder(){
  if [ -e ${qcli_vm_f} ] && [ -f ${qcli_vm_f} ];then
    :
  elif [ -e ${qcli_vm_f} ] && [ -d ${qcli_vm_f} ];then
    echo "${R}呜~~可恶的老师在 $conf_path/ 建了个文件夹叫 .qcli_vmfolder，我要打算在那里写文件的...呜"
    exit 31
  else
    echo "${G}呜嘿~老师还没有选定虚拟机存放的文件夹呢~"
    read -p "${Y}大声告诉我要放到哪里吧~ ${G}[默认选定 $HOME/vm]: ${RES}" folder
    if [ -z "$folder" ];then
      folder=$HOME/vm
    fi
    if [ ! -e "$folder" ];then
      mkdir $folder
      if [ ! $? -eq 0 ];then echo "${R}老师你给的文件夹我创建不了呢... (返回 $?)${RES}";exit 31;fi
    elif [ -f "$folder" ];then
      echo "${R}呜啊~老师太坏了，'$folder' 明明是文件不是文件夹...${RES}"
      exit 31
    fi
    echo "$folder" > "$qcli_vm_f"
    if [ $? -eq 0 ];then
      echo "${G}呜嘿~一切配置都完成了，还是谢谢你啦老师~${RES}"
      sleep 1
    else
      echo "${R}呜...遇到问题写不进去了吗... (返回 $?)${RES}"
      exit 31
    fi
  fi
}

ins_qemu(){
  param=$1
  clear
  echo "================================ ${G}安装 Qemu${RES} ======"
  echo "选择一个 Qemu 软件包来安装，主要区别在于它们模拟的架构关系，架构的选择对应你要安装的系统。例如要装 64 位系统选择 x86-64，32 位则是 i386，请根据您要装的系统选择对应架构。"
  echo "1) qemu-system-i386-headless ${G}(i386 架构)${RES}"
  echo "99) 不安装任何版本的 Qemu [默认选项]"
  echo "================================================="
  read -p "输入序号或对应架构名安装对应 Qemu 软件包：" package
  case $package in
    "1"|"x86-64") 
      apt_echo qemu-system-i386-headless
      apterr=$?
      ;;
    "99" | *)
      case $param in
        "noins")
          echo "${R}由于您没有安装任何的 Qemu 软件包，后端由 Qemu 驱动。没有 Qemu 那前端也没什么用了，故只能结束该脚本。老师下次可不能这样了哦~ ${RES}"
          exit 35
          ;;
        *) : ;;
      esac
    ;;
  esac
  case $param in
    "noins")
      if [ $apterr -eq 0 ]; then
        echo "${G}呜嘿~装好了呢，老师可以重新打开 QemuCli 了呢~"
        exit 0
      else
        echo "${R}apt又不老实了呢... (返回 $apterr)${RES}"
        exit 30
      fi
    ;;
    *)
      if [ $apterr -eq 0 ]; then
        echo "呜嘿~装好了呢，老师可以试试新的架构哦~ [回车返回]"
        read nullfuck
      else
        echo "${R}apt又不老实了呢... (返回 $apterr) [回车返回]${RES}"
        read nullfuck
      fi
    ;;
  esac
}

check(){
  echo "${Y}正在检查您的 Qemu 是否已安装...${RES}"
  pkg list-installed|grep qemu-system &>/dev/null
  if [ ! $? -eq 0 ];then
    ins_qemu noins
  fi
}

main(){
  echo "${R}Qemu${B}cli${RES} ${qcli_ver}"
  echo "非常简单的 Qemu 前端"
  echo "=================================="
  echo "${G} 1)${RES} 创建一个虚拟机"
  echo "${B} 2)${RES} 运行/管理一个虚拟机"
  echo "${C} 3)${RES} 管理 Qemu"
  echo "${Y} 4)${RES} 使用 qemu-img 创建磁盘"
  echo "${R} 99)${RES} 退出 Qemu"
  echo "=================================="
  read -p "输入选项：" sel
  case $sel in
    "1") bash $qcli_path/create.sh ;;
    "2") bash $qcli_path/manager.sh ;; 
    "99") exit 0 ;;
    *) : ;;
  esac
}

check_folder
check
while [ 1 ];do
  main
done