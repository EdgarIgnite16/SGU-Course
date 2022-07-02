#!/bin/bash
echo "Nhap so luong phan tu: "; read n
echo "Nhap phan tu cua mang!"
for ((i=0;i<$n;i++)); do
    read a[$i]
done

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