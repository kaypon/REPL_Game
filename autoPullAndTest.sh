#!/bin/bash


while [ 1 ]; do
	git fetch --all
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
		mkdir testfolder
		cd testfolder
		touch newfile1.txt
		touch newfile2.txt
		git status
		git remote -v
		git log
		echo done
	fi
	sleep 10
done

