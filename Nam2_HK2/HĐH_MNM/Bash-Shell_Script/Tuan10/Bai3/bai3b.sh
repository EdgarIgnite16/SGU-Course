#!/bin/bash

n=($#)
a=($*)

for ((i=0;i<$n;i++)); do
    for ((j=$i+1;j<$n-1;j++)); do
        if [ ${a[$i]} -gt ${a[$j]} ]; then
            temp=${a[$i]}
            a[$i]=${a[$j]}
            a[$j]=$temp
        fi
    done
done

echo "Mang sau khi duoc sap xep lai ${a[@]}"
exit 0