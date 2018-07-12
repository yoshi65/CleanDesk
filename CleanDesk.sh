#!/bin/zsh
#
# FileName: 	CleanDesk
# CreatedDate:  2018-07-12 15:05:43 +0900
# LastModified: 2018-07-12 18:22:49 +0900
#

# make .Trash directory
mkdir -p $HOME/.Trash

# get list of except files
ExceptList=(  )
if [[ -f `pwd`/Except.txt ]]; then
    ExceptList=( ${(@f)"$(<`pwd`/Except.txt)"} )
fi

# get list of files generated more than a month ago
MonthAgoDate=`date -d '1 month ago' "+%Y%m%d"`
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
