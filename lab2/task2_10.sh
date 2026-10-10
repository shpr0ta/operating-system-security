#!/bin/bash
# 2.10 analyze_sales.sh с опциями -f csv и -g
# -f csv  -> сохранить отчёт как sales_report.csv
# -g      -> сгенерировать SQL INSERT'ы из sales_report.csv
set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") [-f csv] [-g] sales.csv

  -f csv   отчёт в формате CSV (sales_report.csv)
  -g       сгенерировать SQL INSERT'ы из sales_report.csv
           (таблица sales_report(metric text, value numeric))
EOF
}

format="text"
gen_sql=0

while getopts ":f:g" opt; do
    case "$opt" in
        f) format="$OPTARG" ;;
        g) gen_sql=1 ;;
        \?) echo "Неизвестная опция: -$OPTARG" >&2; usage; exit 1 ;;
        :)  echo "Опция -$OPTARG требует аргумент" >&2; usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# ---- режим только -g: читаем готовый sales_report.csv ----
if [ "$gen_sql" -eq 1 ] && [ $# -eq 0 ]; then
    [ -f sales_report.csv ] || { echo "sales_report.csv не найден" >&2; exit 1; }
    awk -F, 'NR > 1 {
        gsub(/"/, "", $1); gsub(/"/, "", $2)
        printf "INSERT INTO sales_report (metric, value) VALUES ('\''%s'\'', %s);\n", $1, $2
    }' sales_report.csv
    exit 0
fi

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

csv="$1"
[ -f "$csv" ] || { echo "Файл не найден: $csv" >&2; exit 1; }

read -r total avg max <<< "$(awk -F, 'NR > 1 {
    a = $3 * $4
    t += a; c++
    if (a > m) m = a
}
END {
    if (c == 0) { print "0 0 0"; exit }
    printf "%.2f %.2f %.2f", t, t/c, m
}' "$csv")"

if [ "$format" = "csv" ]; then
    {
        echo "metric,value"
        echo "total_sales,$total"
        echo "average_sale,$avg"
        echo "max_sale,$max"
    } | tee sales_report.csv
else
    {
        echo "Общая сумма продаж:    $total"
        echo "Средняя стоимость:     $avg"
        echo "Самая дорогая продажа: $max"
    } | tee sales_report.txt
fi

# ---- если -g указан вместе с -f csv: сразу сгенерировать SQL ----
if [ "$gen_sql" -eq 1 ] && [ "$format" = "csv" ]; then
    awk -F, 'NR > 1 {
        gsub(/"/, "", $1); gsub(/"/, "", $2)
        printf "INSERT INTO sales_report (metric, value) VALUES ('\''%s'\'', %s);\n", $1, $2
    }' sales_report.csv
fi
