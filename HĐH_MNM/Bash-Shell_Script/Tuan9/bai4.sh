#!/bin/bash
echo "Nhap x: "; read x
echo "Nhap y: "; read y
if [ $x -eq 0 ]; then
    if [ $y -eq 0 ]; then
        echo "Phuong trinh vo so nghiem"
    else 
        echo "Phuong trinh vo nghiem"
    fi
else 
    res=`echo "scale=2; -$y / $x"| bc`
    echo "phuong trinh co nghiem $res"
fi