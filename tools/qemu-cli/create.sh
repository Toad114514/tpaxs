#!/data/data/com.termux/files/usr/bin/bash

# qemu-cli 虚拟机创建文件

source $PREFIX/lib/tpaxs/global
qcli_vm_folder=$(cat $tool_path/qemu-cli/.vmfolder)

echo "==============================="
echo "接下来我们将会引导你创建一个虚拟机"
echo "虚拟机的文件夹将存储于 $qcli_vm_folder 里面"
echo "==============================="

read -p "您的虚拟机名字叫：" vmName

echo -e "\n选择一个虚拟机型号\n1) q35\n2) pc-i440fx-2.4 ${G}[默认]${RES}"
read -p "输入序号：" machine
case $machine in
  "1") machine="q35"
  "2" | *) machine="pc-i440fx-2.4"
esac

read -p "分配内存大小（单位 MB）：" memory
read -p "CPU核心数（建议只分配一个）：" smp
echo -e "\n硬盘选择\n建一个新的还是使用已有的？\n1) 建一个新的 [未完成]   2) 使用已有的"
read -p "选择...: " sel
case $sel in
  # "1" | *) bash "$tool_path/qemu-cli/img.sh" ;;
  "2" | *)
    read -p "输入硬盘所在位置" img_path
  ;;
esac

read -p "设置 CD-ROM 路径（iso镜像位置，留空不设置）：" iso_path
echo "${Y}请耐心等待虚拟机创建..."