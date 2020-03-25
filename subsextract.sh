#!/bin/bash
defaultsub="eng"
if [[ -z ${2} ]] 
then	
	subfolder="subs"
else
	subfolder="${2}"
fi
echo "saving to $subfolder"
file="$1"
task="mkvinfo"
res=$($task "$file" | grep -o 'No EBML head found')

if [ "$res" == "" ];
then
	subsdata=$($task "$file" | grep -i -A 5 -B 2 subtitle)
	if [ "$subsdata" != "" ];
	then
		data=$(echo $subsdata|grep -Eo '(mkvextract: [0-9]*)|(Language: ...)'|grep -Eo '([0-9]*)|([[:alpha:]]{3}$)')		
		lang=${defaultsub}
		for i in $data
		do				
			if [[ -z "${i##*[!0-9]*}" ]]
			then 
				lang=$i	
			else
				if [[ -n $track ]]
					then						
						res=$(mkvextract tracks "$file" ${track}:"${subfolder}/${file:0:-4}.$lang($track).ass")
						if [[ -f "${subfolder}/${file:0:-4}.$lang($track).ass" ]]
						then						
							echo "created: $subfolder/${file:0:-4}.$lang($track).ass"
						else
							echo "failed: $subfolder/${file:0:-4}.$lang($track).ass"
						fi
						lang=${defaultsub}
						track=$i
					else
						track=$i
				fi
			fi			
		done
		res=$(mkvextract tracks "$file" ${track}:"${subfolder}/${file:0:-4}.$lang($track).ass")
		if [[ -f "${subfolder}/${file:0:-4}.$lang($track).ass" ]]
		then						
			echo "created: $subfolder/${file:0:-4}.$lang($track).ass"
		else
			echo "failed: $subfolder/${file:0:-4}.$lang($track).ass"
		fi
	else
		echo "[Error] No subtitles found in $file"
	fi
else
	echo "[Error] $file not an MKV"
fi
