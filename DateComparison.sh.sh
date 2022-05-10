#!/bin/bash 
 
# check whether user had supplied -h or --help . If yes display usage
if [[ ( $@ == "--help") ||  $@ == "-h" ]]
then 
	echo "Usage: $0 [arguments, please specify date here e.g. 2021-04-21 ]"
        echo "Script can take one or two argments as date.  If 2 dates are provided then it will compare those 2 dates and print the differnce in dates"
	exit 0
fi 


if [[ "$1" == "" ]]
then 
  echo " Please provide date as input e.g. 2021-04-21, if  single date is given then it will compare with current date"
  echo " This script can take 2 inputs and those 2 inputs will be 2 diff dates, the script will do the comparision between those 2 dates."
  echo " This script can take 1 input and then it will compare the current date with input date and give the difference of days." 

  exit 0
fi
 

date2format () {
    date --utc --date "$1" +%s
}

dateCompare (){
    case $1 in
        -s)   sec=1;      shift;;
        -m)   sec=60;     shift;;
        -h)   sec=3600;   shift;;
        -d)   sec=86400;  shift;;
        *)    sec=86400;;
    esac
    date1=$(date2format $1)
    date2=$(date2format $2)
    diffSec=$((date2-date1))
    if ((diffSec < 0)); then abs=-1; else abs=1; fi
    echo $((diffSec/sec*abs))
}

# calculate the number of days between 2 dates
    # -s in sec. | -m in min. | -h in hours  | -d in days (default)
#    dateCompare -s "2021-05-01" "2022-04-21"
#    dateCompare -m "2021-05-01" "2022-04-22"
#    dateCompare -h "2021-05-01" "2022-04-22"
#    dateCompare -d "2021-05-01" "2022-04-24"
#    dateCompare  "2021-04-01" "2022-04-24"

echo "This script compare the diff between 2 dates"
#dateCompare  "2021-04-21 09:09:55 Z" "now"
dateCompare "$1" "now" 

