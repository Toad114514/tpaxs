#!/data/data/com.termux/files/usr/bin/bash
bak=$IFS
jishu=0
IFS=$'\n'

path=""
subpath_add="true"
while [ 1 ];do
  case $subpath_add in
    "true") sub="是" ;;
    "false") sub="否" ;;
  esac
  clear
  echo "   nomedia Generate   "
  echo "  防止手机扫描你的图片音频视频"
  echo "================================="
  echo " [1] 修改位置: $path"
  echo " [2] 包含子目录？$sub"
  echo " [3] 开始添加 .nomedia"
  echo "================================="
  echo "     输入对应序号以继续"
  read -rsn1 key
  case $key in
    "1") read -p "请输入需要添加 .nomedia 的文件夹完整目录\n::" path ;;
    "2") if [ $subpath_add == "true" ];then subpath_add="false";else subpath_add="true";fi ;;
    "3") break ;;
  esac
done

if [ $subpath_add == "true" ];then
for x in $(find $path -type d)
do
	jishu=`expr $jishu + 1`
	touch "$x/.nomedia"
	echo "Created $x/.nomedia"
done
else
    jishu=1
    touch "$path/.nomedia"
    echo "Created $path/.nomedia"
fi

echo "$jishu Diretories has created .nomedia."
IFS=$bak
