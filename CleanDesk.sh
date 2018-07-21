#!/bin/zsh
#
# FileName: 	CleanDesk
# CreatedDate:  2018-07-12 15:05:43 +0900
# LastModified: 2018-07-19 17:28:28 +0900
#

# variable
local -A opthash
period="7d"
error_message="usage: ./CleanDesk.sh [-p]\n\nMove unused files to trash\n\noptional arguments:\n  -p\tChoice period(default: 7 days)\n"

# option
zparseopts -D -A opthash -- p:
if [[ -n "$@" ]]; then
    echo ${error_message}
    exit 1
fi
if [[ -n "${opthash[(i)-p]}" && `echo ${opthash[-p]} | grep -c "^[1-9][0-9]*[dm]$"` != 0 ]]; then
    period=${opthash[-p]}
fi

# convert period
if [[ `echo ${period} | grep -c "d$"` == 1 ]]; then
    period="`echo ${period} | sed -e "s/d$//"` days"
else
    period="`echo ${period} | sed -e "s/m$//"` month"
fi

# make .Trash directory
mkdir -p $HOME/.Trash

# get list of except files
ExceptList=(  )
if [[ -f $(cd $(dirname $0) && pwd)/Except.txt ]]; then
    ExceptList=( ${(@f)"$(<$(cd $(dirname $0) && pwd)/Except.txt)"} )
fi

# get list of files generated more than a month ago
MonthAgoDate=`date -d ''"${period}"' ago' "+%Y%m%d"`
RmData=`ls -cl --time-style=+%Y%m%d $HOME/Desktop | awk 'NR>1 && $6<='"$MonthAgoDate"'{for(i=1;i<7;i++)$i="";print}'`
RmList=( ${(@f)${RmData}} )

# remove file
for name in $RmList;
do
    name=`echo $name | sed -e "s/^\ *//"`
    # Exception handling
    if [[ ! -n ${ExceptList[(re)$name]} ]]; then
        mv $HOME/Desktop/$name $HOME/.Trash
    fi
done

return
