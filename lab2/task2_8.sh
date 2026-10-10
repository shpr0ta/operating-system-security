#!/bin/bash
# 2.8 smart_calc.sh — getopts + калькулятор
# Опции: -h (справка), -v (verbose), -o <file> (вывод в файл)
# Далее: операция (add|sub|mul|div|pow) и числа
set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") [-h] [-v] [-o file] operation num1 num2 [num3 ...]

Operations:
  add | +   сложение
  sub | -   вычитание
  mul | *   умножение
  div | /   деление
  pow | ^   возведение в степень

Options:
  -h        показать справку
  -v        подробный вывод
  -o file   записать результат в файл
EOF
}

verbose=0
outfile=""

while getopts ":hvo:" opt; do
    case "$opt" in
        h) usage; exit 0 ;;
        v) verbose=1 ;;
        o) outfile="$OPTARG" ;;
        \?) echo "Неизвестная опция: -$OPTARG" >&2; usage; exit 1 ;;
        :)  echo "Опция -$OPTARG требует аргумент" >&2; usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

if [ $# -lt 2 ]; then
    usage
    exit 1
fi

op="$1"; shift

# проверка, что все оставшиеся — целые числа
for n in "$@"; do
    if ! [[ "$n" =~ ^-?[0-9]+$ ]]; then
        echo "Не число: $n" >&2
        exit 1
    fi
done

result="$1"; shift

case "$op" in
    add|+) for n in "$@"; do result=$((result + n)); done ;;
    sub|-) for n in "$@"; do result=$((result - n)); done ;;
    mul|'*') for n in "$@"; do result=$((result * n)); done ;;
    div|/)
        for n in "$@"; do
            if [ "$n" -eq 0 ]; then
                echo "Деление на ноль" >&2
                exit 1
            fi
            result=$((result / n))
        done
        ;;
    pow|'^')
        for n in "$@"; do result=$((result ** n)); done
        ;;
    *)
        echo "Неизвестная операция: $op" >&2
        usage
        exit 1
        ;;
esac

[ "$verbose" -eq 1 ] && echo "Операция: $op, результат: $result" >&2

if [ -n "$outfile" ]; then
    echo "$result" >> "$outfile"
fi

echo "$result"
