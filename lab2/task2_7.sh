#!/bin/bash
# 2.7 filter_numbers.sh
# - делится на 3 -> пропускаем (даже если чётное)
# - чётное       -> even.txt
# - нечётное     -> odd.txt
# В конце — количество обработанных чисел (все аргументы).
set -euo pipefail

> even.txt
> odd.txt

count=0
for num in "$@"; do
    count=$((count + 1))

    # деление на 3 — пропускаем
    if [ $((num % 3)) -eq 0 ]; then
        continue
    fi

    if [ $((num % 2)) -eq 0 ]; then
        echo "$num" >> even.txt
    else
        echo "$num" >> odd.txt
    fi
done

echo "Обработано чисел: $count"
