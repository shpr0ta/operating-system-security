#!/bin/bash
# 2.1 Журнал запусков + Hello, World! + счётчик предыдущих запусков
set -euo pipefail

LOG=/tmp/run.log

# создаём файл, если его нет
touch "$LOG"

# количество предыдущих запусков (строк до добавления текущей записи)
prev=$(wc -l < "$LOG")

# добавляем запись о текущем запуске
date '+%Y-%m-%d %H:%M:%S' >> "$LOG"

# stdout
echo "Hello, World!"

# stderr — количество предыдущих запусков
echo "Previous runs: $prev" >&2
