#!/bin/bash
kiemtraso() {
	num=$($1/2)
    num=$($num*2)
	if [ “$num” -eq “$1” ]; then
		return 1
	else
		return 2
	fi
}
