#!/data/data/com.termux/files/usr/bin/bash

LIB_FILESELECT_STATE=""

bak=$IFS;IFS=$'\n'
dir=$1
declare dirlist
# form=0
# for x in $(find $dir -maxdepth 1);do
    # dirlist[$form]=$x
    # echo ${dirlist[$form]}
    # form=`expr $form + 1`
# done

sel=0
offset=0
while [ 1 ];do
    clear
    echo "   选择一个文件"
    echo "====================="
    echo " |_ 所在文件夹路径: $dir"
    xdfor=0
    xd=0
    dirlist=($(ls $dir))
    dirnum=`expr ${#dirlist[*]} - 1`
    dirnumo=`expr $dirnum - 5`
    if [ $sel -gt 5 -a $sel -lt $dirnumo ];then
      offset=`expr $sel - 5`
    fi
    while(( $xd<=10 ));do
      xdfor=`expr $xd + $offset`
      if [ $sel -eq $xdfor ];then
        echo "  > |_ ${dirlist[$xdfor]}"
      else
        echo "  |_ ${dirlist[$xdfor]}"
      fi
      let xd++
      if [ $dirnum -lt 10 ];then
        if [ $xd -gt $dirnum ];then
          break
        fi
      fi
    done
    # echo "$dirlist"
    echo "====================="
    echo "     选择了第 $sel / $dirnum 项"
    echo " w/s: 上下选择 i/k: 上下翻页"
    echo " c: 确认/进入文件夹 b: 返回上一层级"
    echo " g: 退出选择"
    echo "====================="
    read -rsn1 key
    case $key in
      "w") sel=`expr $sel - 1` ;;
      "s") sel=`expr $sel + 1` ;;
      "i") sel=`expr $sel - 10` ;;
      "k") sel=`expr $sel + 10` ;;
      "b")
        dir="$dir/.."
        sel=0
        offset=0
      ;;
      "c") 
        if [ -d "$dir/${dirlist[$sel]}" ];then
          dir="$dir/${dirlist[$sel]}"
          sel=0
          offset=0
        else
          LIB_FILESELECT_STATE="$dir/${dirlist[$sel]}"
          break
        fi
      ;;
      "g") LIB_FILESELECT_STATE="TPS_FSELECT_EXITED";exit 127 ;;
    esac
    if [ $sel -lt 0 ];then sel=0; fi
    if [ $sel -gt $dirnum ];then sel=$dirnum;fi
done

IFS=$bak
# echo "$LIB_FILESELECT_STATE"