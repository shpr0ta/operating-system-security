#!/bin/bash
# 2.9 analyze_sales.sh
# Принимает CSV с продажами, выводит:
#   1) общую сумму продаж (sum price*quantity)
#   2) среднюю стоимость продажи
#   3) самую дорогую продажу
# Результат дублируется в sales_report.txt через tee
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") sales.csv" >&2
    exit 1
fi

csv="$1"
[ -f "$csv" ] || { echo "Файл не найден: $csv" >&2; exit 1; }

awk -F, 'NR > 1 {
    amount = $3 * $4
    total += amount
    count++
    if (amount > max) max = amount
}
END {
    if (count == 0) {
        print "Нет данных" > "/dev/stderr"
        exit 1
    }
    printf "Общая сумма продаж:    %.2f\n", total
    printf "Средняя стоимость:     %.2f\n", total / count
    printf "Самая дорогая продажа: %.2f\n", max
}' "$csv" | tee sales_report.txt
