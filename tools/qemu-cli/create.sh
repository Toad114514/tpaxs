#!/data/data/com.termux/files/usr/bin/bash

# qemu-cli 虚拟机创建文件

source $PREFIX/lib/tpaxs/global
qcli_vm_folder=$(cat ${conf_path}/.qcli_vmfolder)

echo "==============================="
echo "接下来我们将会引导你创建一个虚拟机"
echo "虚拟机的文件夹将存储于 $qcli_vm_folder 里面"
echo "==============================="

read -p "您的虚拟机名字叫：" vmName

echo -e "\n选择一个虚拟机型号\n1) q35\n2) pc-i440fx-2.4 ${G}[默认]${RES}"
read -p "输入序号：" machine
case $machine in
  "1") machine="q35" ;;
  "2" | *) machine="pc-i440fx-2.4" ;;
esac

read -p "分配内存大小（单位 MB）：" memory
read -p "CPU核心数（建议只分配一个）：" smp
echo -e "\n硬盘选择\n建一个新的还是使用已有的？\n1) 建一个新的   2) 使用已有的"
read -p "选择...: " sel
case $sel in
  "1")
    read -p "输入硬盘大小（默认单位MB，可向后面添加单位例如G、M、K等）：" img_create_size
    img_path=""
    img_create=1
  ;;
  "2" | *)
    read -p "输入硬盘所在位置" img_path
    img_create=0
  ;;
esac

read -p "设置 CD-ROM 路径（iso镜像位置，留空不设置）：" iso_path

read -p "设置显卡（可选std、vmware等，默认std）：" video
if [ -z $video ];then
  video=std
fi

read -p "输入 vnc 显示端口（默认 5902）：" vncport

echo "${Y}请耐心等待虚拟机创建..."

qvmCreate=${qcli_vm_folder}/${vmName}
if [ -f ${qvmCreate}/${vmName} ];then
  tps_err "${qvmCreate}/${vmName}已有同名文件！"
  err=1
elif [ ! -e ${qvmCreate}/${vmName} ];then
  mkdir ${qcli_vm_folder}/${vmName}
  err=0
elif [ ! -e ${qvmCreate}/${vmName}/qcli_conf.ini ] [ -f ${qvmCreate}/${vmName}/qcli_conf.ini ];then
  read -p "${Y}配置文件已存在。是否覆盖？（默认不覆盖）[y/n]:${RES}" sel
  case $sel in
    "y") err=0 ;;
    "n" | *) err=1 ;;
  esac
else
  err=0
fi

if [ ${err} -eq 0 ];then
  touch ${qvmCreate}/qcli_conf.ini
  if [ -z $img_path ] && [ $img_create -eq 1 ];then
    qemu-img create -f qcow2 ${qvmCreate}/${vmName}.qcow2 ${img_create_size}
    img_path=${qvmCreate}/${vmName}.qcow2
  fi
cat <<EOF >> ${qvmCreate}/qcli_conf.ini
[qcli]
name=${vmName}
machine=${machine}
memory=${memory}
smp=${smp}
hda=${img_path}
cdrom=${cdrom}
vga=${video}
vncport=`expr ${vncport} - 5900`
EOF
  tps_info "您的虚拟机 ${vmName} 创建完成！"
  sleep 1.2
fi


