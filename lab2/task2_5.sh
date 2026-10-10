#!/bin/bash
# 2.5 Поиск дубликатов файлов (по содержимому) в текущем каталоге.
# Вывод: сначала количество, затем имена файлов группы.
# Файлы без дубликатов не выводятся. Пустые файлы тоже считаются дубликатами.
set -euo pipefail

declare -A groups

shopt -s nullglob
for f in *; do
    [ -f "$f" ] || continue
    sum=$(md5sum -- "$f" | awk '{print $1}')
    if [ -z "${groups[$sum]:-}" ]; then
        groups[$sum]="$f"
    else
        groups[$sum]="${groups[$sum]} $f"
    fi
done
shopt -u nullglob

for sum in "${!groups[@]}"; do
    files=${groups[$sum]}
    count=$(wc -w <<< "$files")
    if [ "$count" -gt 1 ]; then
        echo "$count $files"
    fi
done
