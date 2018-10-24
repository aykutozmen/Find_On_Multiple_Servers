#!/bin/bash

echo > ${PWD}/Find_For_Me.log

function Give_Break {
echo
echo "------------------------------------------"
}

if [ ${#} != 1 ]
then
	echo "Parameter missing... You need to give the filename to be searched..."
	exit 1
fi

Server_List=( root@admin1 admin2 db1 db2 fc1 fc2 mail1 mail2 web1 web2 sip1 sip2 tele1 tele2 )

while true
do
read -p "Do you want to send the result to a log file? [y/n]" Answer
case $Answer in
[yY]*)	exec >> ${PWD}/Find_For_Me.log 2>/dev/null
	break
	;;
[nN]*)  exec 2> /dev/null
	break
	;;
*)      echo "Please type y[es] or n[o]..."
	;;
esac
done

for Server in "${Server_List[@]}"
do
echo "Searching '"$1"' on "${Server}"..."
ssh ${Server} << SSH_SESS
find / -iname "*${1}*"
SSH_SESS
Give_Break
done

exit 0

