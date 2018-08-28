#!/bin/bash

while [ 1 ]; do
	git fetch origin
	sleep 10
	status=$(git status)
	
	if [[ $status = *"up-to-date"* ]]; then
		echo repo is up-to-date
	else
		echo ----------------
		echo starting process
		echo ----------------
		sleep 5
		echo pulling master
		sleep 5
		git pull origin master
		sleep 5
	fi
	sleep 10
done

