#!/usr/bin/env bash

languages=`echo "python c cpp rust bash" | tr ' ' '\n'`
core_utils=`echo "xargs cd mv rm grep sed tr awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "Query: " query

if printf $languages | grep -qs $selected; then
    bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
else
    bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
