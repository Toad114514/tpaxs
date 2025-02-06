tps_err(){
  datas=$(date "+%H:%M:%S")
  echo "${R}${BOLD}[ERR]${RES}${C} [${datas}]${RES}: $1"
}
tps_warm(){
  datas=$(date "+%H:%M:%S")
  echo "${Y}${BOLD}[WRM]${RES}${C} [${datas}]${RES}: $1"
}
tps_info(){
  datas=$(date "+%H:%M:%S")
  echo "${B}${BOLD}[IFO]${RES}${C} [${datas}]${RES}: $1"
}
tps_done(){
  datas=$(date "+%H:%M:%S")
  echo "${G}${BOLD}[OK]${RES}${C} [${datas}]${RES}: $1"
}
