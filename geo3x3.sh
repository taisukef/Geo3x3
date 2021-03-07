#!/bin/bash

geo3x3_encode() {
  local lat=$1
  local lng=$2
  local level=$3
  local res=
  if [ $level -gt 0 ]; then
    if [ `echo "$lng>0" | bc` -eq 1 ]; then
      res=E
    else
      res=W
      lng=`echo "scale=16; $lng+180" | bc`
    fi
    lat=`echo "scale=16; $lat+90" | bc`
    unit=180
    local i
    for ((i=1; i<$level; i++)) do
      unit=`echo "scale=16; $unit/3" | bc`
      local x=`echo "scale=0; $lng/$unit" | bc`
      local y=`echo "scale=0; $lat/$unit" | bc`
      res=$res$(($x+$y*3+1))
      lng=`echo "scale=16; $lng-$x*$unit" | bc`
      lat=`echo "scale=16; $lat-$y*$unit" | bc`
    done
  fi
  echo $res
}

geo3x3_decode() {
  local code=$1
  local clen=${#code}
  if [ $clen -eq 0 ]; then
    echo 0 0 0 180
  else
    local begin=0
    local flg=0
    local c=${code:0:1}
    if [ c = "W" ]; then
      flg=1
      begin=1
    elif [ c = "E" ]; then
      begin=1
    fi
    local lat=0
    local lng=0
    local level=1
    local unit=180
    local i=0
    for ((i=begin; i<$(($clen-1)); i++)) do
      n=$((${code:$i+1:1}-1))
      if [ $n -lt 0 ]; then
        break
      fi
      unit=`echo "scale=16; $unit/3" | bc`
      local x=$((n%3))
      local y=$((n/3))
      lng=`echo "scale=16; $lng+$x*$unit" | bc`
      lat=`echo "scale=16; $lat+$y*$unit" | bc`
      level=$(($level+1))
    done
    lat=`echo "scale=16; $lat+$unit/2-90" | bc`
    lng=`echo "scale=16; $lng+$unit/2" | bc`
    if [ $flg -eq 1 ]; then
      lng=`echo "scale=16; $lng-180" | bc`
    fi
    echo $lat $lng $level $unit
  fi
}

code=`geo3x3_encode 35.65858 139.745433 14`
echo $code

ll=`geo3x3_decode E9139659937288`
echo $ll
