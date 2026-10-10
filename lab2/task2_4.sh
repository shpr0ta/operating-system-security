#!/bin/bash
# 2.4 Для *.txt в $HOME: список файлов + суммарный размер (байт, строк)
set -euo pipefail

shopt -s nullglob
files=("$HOME"/*.txt)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
    echo "Нет .txt файлов в $HOME"
    exit 0
fi

echo "=== Файлы .txt в $HOME ==="
printf '%s\n' "${files[@]}"

total_bytes=0
total_lines=0
for f in "${files[@]}"; do
    b=$(wc -c < "$f")
    l=$(wc -l < "$f")
    total_bytes=$((total_bytes + b))
    total_lines=$((total_lines + l))
done

echo "=== Итоги ==="
echo "Всего байт:   $total_bytes"
echo "Всего строк:  $total_lines"
