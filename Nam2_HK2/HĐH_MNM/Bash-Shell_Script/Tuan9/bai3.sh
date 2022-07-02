#!/bin/bash
echo "Nhap x "; read x
echo "Nhap y "; read y
echo "x + y = `expr $x + $y`"
echo "x - y = `expr $x - $y`"
echo "x * y = `expr $x \* $y`"
echo "x % y = `expr $x % $y`"
