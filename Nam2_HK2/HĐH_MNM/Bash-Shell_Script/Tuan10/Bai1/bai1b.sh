#!bin/bash

checkPrime() {
    for ((i=2;i<$1;i++)); do
        if [ $[$1%$i] -eq 0 ]; then
            return 1
        fi
    done 
    return 0
}

ktSoChinhPhuong() {
    for ((i=1;i<=$1;i++)); do
        if [ $[$i*$i] -eq $1 ]; then
            return 0
        fi
    done
    return 1
}

# xử lí số nguyên tố
if [ $1 -gt 2 ]; then
    if [ $(checkPrime $1) ]; then
        echo "$1 la phai so nguyen to"
    else
        echo "$1 khong phai so nguyen to"
    fi
fi

# xử lí số chính phương
if [ $1 -lt 2 ]; then
    echo "$1 khong phai so chinh phuong!"
    exit 1
else
    if [ $(ktSoChinhPhuong $1) ]; then
        echo "$1 la phai so chinh phuong"
    else
        echo "$1 khong phai chinh phuong"
    fi
fi