#!/bin/bash

function logger {
	if [ ! -z "$_procLogger" ]; then 
		echo "$1" >> "$_procLogger";
	else
		echo "$1";
	fi;
}

function createNewInstances {
	local oriNm="$1";
	local tmpNm="$2";
	local season="$3";
	local fileType="$4";
	
	mkdir -p "$path_outbound";
	touch "$path_outbound/log_file.log";
	_procLogger="$path_outbound/log_file.log";
	
	for f in "$path_inbound"/*"$oriNm"*
	do
		local count=0;
		prefix="Episode ";
		suffix=" English Subbedat Gogoanime";
		toCompare="$prefix""$count""$suffix";
		
		tmpFileNm=$(basename "$f");
		fileNm=${tmpFileNm%.*};
		logger "[INFO] File to process: $fileNm";
		logger "[INFO] Initial Key point to refer: $toCompare"
		
		while [ "$fileNm" != *"$toCompare" ]
		do
			let count++;
			toCompare="$prefix""$count""$suffix";
			if [[ "$fileNm" == *"$toCompare" ]]; then
				logger "[RESULT FOUND] File count $count";
				local newNm="$tmpNm ""E$count""S$season""$fileType";
				logger "[INFO] To be rename --> $newNm";
				
				# mv "$f" "$path_outbound/$newNm";
				logger "[INFO] New location moved --> $path_outbound/$newNm";
				logger "";
				
				break
			fi
		done;
	done;
	
	echo "PROCESS COMPLETED";
}
dir=$(pwd)
source "$dir/env.sh"
source "$dir/config.sh"

createNewInstances "$originalFileNm" "$fileNmToChange" "$season" "$fileType";