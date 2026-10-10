# Лабораторная работа №2

Сценарии Bash для работы с файлами, потоками ввода/вывода, обработкой аргументов и опций, а также анализа данных.

## Содержание

- [Структура](#структура)
- [Сценарии](#сценарии)
  - [task2_1.sh](#task2_1sh)
  - [task2_2.sh](#task2_2sh)
  - [task2_3.sh](#task2_3sh)
  - [task2_4.sh](#task2_4sh)
  - [task2_5.sh](#task2_5sh)
  - [task2_6.sh](#task2_6sh)
  - [task2_7.sh](#task2_7sh)
  - [task2_8.sh](#task2_8sh)
  - [task2_9.sh](#task2_9sh)
  - [task2_10.sh](#task2_10sh)
- [Запуск всех примеров](#запуск-всех-примеров)


## Структура

```
lab2/
├── task2_1.sh
├── task2_2.sh
├── task2_3.sh
├── task2_4.sh
├── task2_5.sh
├── task2_6.sh
├── task2_7.sh
├── task2_8.sh
├── task2_9.sh
└── task2_10.sh
```

Сделайте файлы исполняемыми:

```bash
chmod +x lab2/*.sh
```

## Сценарии

### task2_1.sh

Ведёт журнал запусков в `/tmp/run.log`, выводит `Hello, World!` в stdout и количество предыдущих запусков в stderr.

```bash
./task2_1.sh
./task2_1.sh
cat //tmp/run.log
```

### task2_2.sh

Запускает `task2_1.sh` и открывает журнал `/tmp/run.log` в `less`.

```bash
./task2_2.sh
```

### task2_3.sh

Читает stdin построчно и выводит в stderr только строки, содержащие слово `bin` целиком.

```bash
printf 'foo\n/bin/sh\nbinder\nbin here\n' | ./task2_3.sh
```

### task2_4.sh

Для всех `*.txt` в `$HOME` выводит список файлов и суммарный размер в байтах и строках.

```bash
touch ~/a.txt ~/b.txt
./task2_4.sh
```

### task2_5.sh

Ищет дубликаты файлов по содержимому в текущем каталоге (нерекурсивно). Выводит количество и имена файлов группы. Пустые файлы считаются дубликатами.

```bash
mkdir -p /tmp/dup && cd /tmp/dup
echo hi > f1; echo hi > f2; echo yo > f3
/path/to/lab2/task2_5.sh
```

### task2_6.sh

Выводит количество переданных аргументов.

```bash
./task2_6.sh a b c d
```

### task2_7.sh (filter_numbers.sh)

Принимает числа как аргументы:
- делится на 3 — пропускает;
- чётное — пишет в `even.txt`;
- нечётное — пишет в `odd.txt`;
- в конце выводит количество обработанных чисел.

```bash
./task2_7.sh 1 2 3 4 5 6 7 8 9 10
cat even.txt odd.txt
```

### task2_8.sh (smart_calc.sh)

Калькулятор с опциями:
- `-h` — справка;
- `-v` — подробный вывод;
- `-o <file>` — вывод результата в файл.

Операция задаётся первым аргументом: `add`, `sub`, `mul`, `div`, `pow` (или `+ - * / ^`).

```bash
./task2_8.sh add 1 2 3
./task2_8.sh -v mul 2 3 4
./task2_8.sh -o res.txt pow 2 10
./task2_8.sh div 100 5 2
```

### task2_9.sh (analyze_sales.sh)

Принимает CSV с продажами (колонки: `id,product,price,quantity`). Выводит:
1. общую сумму продаж (`price * quantity`);
2. среднюю стоимость продажи;
3. самую дорогую продажу.

Результат сохраняется в `sales_report.txt` через `tee`.

```bash
./task2_9.sh sales.csv
cat sales_report.txt
```

### task2_10.sh

Модификация 2.9:
- `-f csv` — сохраняет отчёт в `sales_report.csv`;
- `-g` — генерирует SQL `INSERT` для PostgreSQL из `sales_report.csv` (таблица `sales_report(metric text, value numeric)`).

```bash
./task2_10.sh -f csv sales.csv
./task2_10.sh -g
```

## Запуск всех примеров

```bash
cd lab2
chmod +x *.sh

./task2_1.sh
./task2_2.sh
printf 'foo\n/bin/sh\nbinder\nbin here\n' | ./task2_3.sh
./task2_4.sh
./task2_6.sh a b c d
./task2_7.sh 1 2 3 4 5 6 7 8 9 10
./task2_8.sh add 1 2 3
./task2_9.sh sales.csv
./task2_10.sh -f csv sales.csv
./task2_10.sh -g
```


