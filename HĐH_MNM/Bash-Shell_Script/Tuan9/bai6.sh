#!/bin/bash
clear
echo "Nhap ten thu muc"; read dirName
mkdir $dirName
if test $? -eq 0; then
    echo "Thu muc $dirName da duoc tao thanh cong"
else 
    echo "Thu muc $dirName da duoc tao that bai"
fi