#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

# manager.sh
qcli_path="$tool_path/qemu-cli"
qcli_vm_f="$conf_path/.qcli_vmfolder"

vmf=$(cat ${conf_path}/.qcli_vmfolder)

tps_info "请等待..."

while [ 1 ];do

echo "============================"
echo "全部虚拟机"
echo "============================"
declare -A vmf_list
forina=0
for i in $(find ${vmf} -maxdepth 1 -type d);do
  if [ "${i}" == "${vmf}" ];then
    :
  else
  if [ ! -e ${i}/qcli_conf.ini ];then
    echo "找不到 ${i}/qcli_conf.ini" > "${i}/qclierr.txt"
  else
    if [ -d ${i}/qcli_conf.ini ];then
      echo "${i}/qcli_conf.ini 不是文件" > "${i}/qclierr.txt"
    else
      if [ ! -w ${i}/qcli_conf.ini -o ! -r ${i}/qcli_conf.ini ];then
        echo "${i}/qcli_conf.ini 没有读写权限" > "${i}/qclierr.txt"
      else
        vmname=$(iniRead ${i}/qcli_conf.ini qcli name)
        if [ $? -eq 0 -a ! -z $vmname ];then
          echo "${G}${forina}) ${RES}${vmname}"
          vmf_list[$forina]="${vmname}"
          forina=`expr $forina + 1`
        else
          echo "${i}/qcli_conf.ini 出现问题无法读取，可能不是ini文件或者虚拟机名为空" > "${i}/qclierr.txt"
        fi
      fi
    fi
  fi
  fi
done
forina=`expr $forina - 1`
echo "${R}999)${RES} 退出"
echo "============================"
read -p "选择一个（序号）：" sel
case "$sel" in
  "999") exit 0 ;;
  *)
    seld=$(($sel))
    if [ ! $seld -ge 0 ];then
      echo "无效输入" && sleep 1
    else
      if [ ! $seld -le $forina ];then
        echo "无效输入" && sleep 1
      else
          echo "获取序号 ${sel}: 虚拟机 ${vmf_list[$sel]}"
          bash ${qcli_path}/manager2.sh "${vmf_list[$sel]}"
      fi
    fi
  ;;
esac
done