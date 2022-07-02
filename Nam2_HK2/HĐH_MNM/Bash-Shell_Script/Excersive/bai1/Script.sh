#!/bin/bash

file=$1 # get data

# hàm kiểm tra sinh viên có đi học hay không
kiemtrasinhvien() {
    if [ $2 = $5 ]; then
        echo "$1 $2 $3 $4"
    fi
}

# # hàm thống kê sinh viên đi học theo giờ x
thongketheogio() {
    data=`echo $4 | awk 'BEGIN{FS=":"}{print $1}'`
    if [ $data -ge $5 ]; then
        echo "$1 $2 $3 $4"
    fi
}


# ================================================== #
# Main
echo "Nhap vao ten: "; read name
echo "Nhap vao gio: "; read hour


# xu li
echo "Danh sach sinh vien di hoc (theo ten)"
while read line; do
    kiemtrasinhvien ${line} ${name}
done < ${file}

echo "Danh sach sinh vien di hoc (theo gio x)"
while read line; do
    thongketheogio ${line} ${hour}
done < ${file}