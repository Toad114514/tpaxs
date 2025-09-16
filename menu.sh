#!/data/data/com.termux/files/usr/bin/bash
source $PREFIX/lib/tpaxs/global

list(){
  f=$1
    if [ "$f" = "$work_path/tools" ]; then
      :
    else
      if [ ! -f $f/main.sh ];then
        :
      else
        if [ ! -f $f/info.ini ];then
          noini[$indexofini]=$f
          canuse=`expr $canuse + 1`
          indexofini=`expr $indexofini + 1`
        else
          local name=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'name'/{print $2;exit}' $f/info.ini)
          case $LANGUAGE in
            "zh-CN" | "zh_CN")
              local desc=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'desc'/{print $2;exit}' $f/info.ini)
            ;;
            "en-US" | "en_US" | *)
              local desc=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'descEN'/{print $2;exit}' $f/info.ini)
              if [ -z "$desc" ];then
                local desc=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'desc'/{print $2;exit}' $f/info.ini)
              fi
            ;;
          esac   
          local ver=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'ver'/{print $2;exit}' $f/info.ini)
          local coms=$(echo $f|sed 's?/data/data/com.termux/files/usr/lib/tpaxs/tools/??')
          echo "${G}${BOLD}$coms: ${Y}$name${B}[$ver]${RES}"
          echo "   ${desc}"
        fi
      fi
    fi
}

check_run(){
  echo "是否继续运行以下工具？"
  list $1
  read -p "[y/n]: " sel
  case $sel in
    "y") bash $1/main.sh ;;
    "n") : ;;
  esac
}

menu_02(){
   rm -f ${work_path}/config/.tool_list 2>/dev/null
    cd ${work_path}/tools
    let i=01
    for CLIST in $(ls .); do
      if [ ! -f $CLIST/main.sh ];then
        :
      else
        if [ ! -f $CLIST/info.ini ];then
          :
        else
          local NAME=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'name'/{print $2;exit}' $CLIST/info.ini)
          local DESC=$(awk -F "=" '/\['tpaxs'\]/{a=1}a==1&&$1~/'desc'/{print $2;exit}' $CLIST/info.ini)
          [[ ! -d ${CLIST} ]] ||  printf "%s %s " "${CLIST}" "_$((i++))--${CLIST}" >>${work_path}/config/.tool_list
        fi
      fi
    done
    
    SELECT=$("${TUI_BIN:-whiptail}" --title "Tools" --menu \
            "Select..." 0 0 0 \
            $(sed -n p ${work_path}/config/.tool_list 2>/dev/null) \
            "Back" "🌚 戻る" \
            3>&1 1>&2 2>&3)
    
    # rm -rf ${work_path}/config/.tool_list 2>/dev/null
    rm -rf ${work_path}/tools/3
    
    echo $SELECT
    case $SELECT in
      "Back" | 0 | "") exit ;;
      *) check_run ${tool_path}/${SELECT} ;;
    esac
}


while [ 1 ];do
menu_02
done