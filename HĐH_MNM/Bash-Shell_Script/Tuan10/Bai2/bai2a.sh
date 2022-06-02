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

echo "Cac so nguyen to tu 1 den $n :"
# xử lí số nguyên tố
for ((i=1;i<=$n;i++)); do
    if $(checkPrime $i) ; then
        echo $i 
    fi
done

echo "Cac so chinh phuong tu 1 den $n"
# xử lí số chính phương
for ((i=1;i<=$n;i++)); do
    if $(ktSoChinhPhuong $i)  ; then
        echo $i
    fi
done