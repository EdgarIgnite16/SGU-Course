echo "Nhap ten file"; read name
touch $name

if [ $? -eq 0 ]; then
    echo "Tao file thanh cong"
else
    echo "Tao file that bai"
fi

echo "Hay nhap noi dung"
while true; do
    read a
    if [ "$a" = "finished" ]; then
        break
    else
        echo $a >> $name
    fi
done

exit 0
