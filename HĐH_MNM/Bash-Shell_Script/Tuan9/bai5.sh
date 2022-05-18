#!/bin/bash
sum=0
echo "Nhap n: "; read n

for (( i = 1; i <= $n; i++ ))
do
    sum=`expr $sum + $i`
done

echo "Result: $sum"
