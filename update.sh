#!/data/data/com.termux/files/usr/bin/bash

source $PREFIX/lib/tpaxs/global

echo "  _   ____                
 ${R}| |_|  _ \ __ ___  _____ 
 ${G}| __| |_) / _\` \ \/ / __|
 ${B}| |_|  __/ (_| |>  <\___\\
  ${Y}\__|_|   \__,_/_/\_\___/"
echo
echo "${B}${BOLD}tPaxs ${R}Dev ${tps_version}${RES} By Toad114514"
echo "更新向导"

sleep 1

remoteu(){
  echo "注意事项："
  echo "如果中间出现非网络原因的错误信息时，请尝试输入 ${Y}mv \$PREFIX/lib/tpaxs_backup \$PREFIX/lib/tpaxs${RES} 恢复原先的 tpaxs 版本。"
  echo "================================="
  echo "${G}请选择一个远程仓库进行更新...${RES}"
  echo "${R}1) ${Y}Github (https://github.com/toad114514/tpaxs) ${G}[国外源，需翻墙]${RES}"
  echo "${R}2) ${Y}Gitee (https://gitee.com/toadstool/tpaxs) ${G}[国内源，无需翻墙]${RES}"
  case $LANGUAGE in
    "zh-CN") echo "根据语言设定，默认选择 ${Y}Gitee${RES}" ;;
    "en-US" | *) echo "${Y}Github${RES} is selected by default depending on the language setting" ;;
  esac
  read -p "请选择：" sel
  case $sel in
    "1") repo=origin ;;
    "2") repo=gitee ;;
    *)
      case $LANGUAGE in
        "zh-CN") repo=gitee ;;
        "en-US" | *) repo=origin ;;
      esac
    ;;
  esac
  
  tps_info "正在检查远程仓库更新..."
  cd $PREFIX/lib/tpaxs
  if ! git fetch ${repo};then
    tpa_err "很抱歉，我们无法连通对应的远程仓库，更新失败。"
  else
    lcommit=$(git rev-parse HEAD)
    rcommit=$(git rev-parse "${repo}/dev")
    if [ "$lcommit" = "$rcommit" ];then
      tps_info "您的 tPaxs 目前是最新提交版本！无需更新"
    else
      echo -e "\n===============================\n${Y}更新到 ${G}${rcommit} ${Y}提交后的所有提交内容：${RES}"
      git --no-pager log --pretty=format:"%h - %an, %ar : %s" "$lcommit..$rcommit"
      echo -e "\n==============================="
      read -p $'\n是否确认更新？(y/n) ' confirm
      if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        tps_info "已取消更新。"
      else
        tps_info "开始更新 tPaxs..."
        bakpath=$PREFIX/lib/tps_bak
        rm -rf ${bakpath}
        cp -r ${work_path} ${bakpath}
        rm -rf ${work_path}
        cd ..
        case $repo in
          "origin") 
            git clone https://github.com/toad114514/tpaxs $PREFIX/lib/tpaxs
            gitback=$?
          ;;
          "gitee")
            git clone https://gitee.com/toadstool/tpaxs $PREFIX/lib/tpaxs
            gitback=$?
          ;;
        esac
        if [ ! $gitback -eq 0 ];then
          tps_err "很抱歉，拉取仓库时出现问题。已停止更新。"
          cp -r ${bakpath} ${work_path}
        else
          tps_done "拉取成功！正在尝试移动文件"
          mv ${bakpath}/config ${work_path}/config
          if [ ! $? -eq 0 ];then
            tps_err "很抱歉，config文件夹移动失败，tpaxs虽然能正常工作，但旧版本存档将消失。"
            tps_err "请尝试自己移动文件夹并解决问题："
            tps_err "  mv ${bakpath}/config ${work_path}/config"
          fi
          tps_done "更新完成！"
          echo "${G}您的 tPaxs 已更新完成到目前提交 $rcommit！${RES}"
          echo "tPaxs 将退出，您只需要重新打开termux并输入 tpaxs 即可食用！"
          sleep 0.5
          exit 0
        fi
      fi
    fi
  fi
}

echo "==================================="
echo "${G}tPaxs${RES} Update"
echo "==================================="
echo "请选择更新方案"
echo "1) 更新到仓库最近提交"
echo "99) 退出"
echo "==================================="
read -p "选择... :" sel
case ${sel} in
  "1") remoteu ;;
  "99") : ;;
esac