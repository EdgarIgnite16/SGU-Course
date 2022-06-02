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

echo "Nhap mot so"; read n
echo "Ban da nhap so $n"

# xử lí số nguyên tố
if [ $n -gt 2 ]; then
    if $(checkPrime $n); then
        echo "$n la phai so nguyen to"
    else
        echo "$n khong phai so nguyen to"
    fi
fi

# xử lí số chính phương
if [ $n -lt 2 ]; then
    echo "$n khong phai so chinh phuong!"
    exit 1
else
    if $(ktSoChinhPhuong $n); then
        echo "$n la phai so chinh phuong"
    else
        echo "$n khong phai chinh phuong"
    fi
fi