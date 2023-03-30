#!/usr/bin/env bash

mic(){
	inp=`pamixer --list-sources | awk '/alsa_input/ {printf $1}'`
	mic=`pamixer --source $inp --get-volume-human`
	echo  $mic
}

mic
