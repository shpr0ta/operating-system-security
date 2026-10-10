#!/bin/bash
# 2.2 Запуск task2_1.sh и просмотр журнала в less
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

"$SCRIPT_DIR/task2_1.sh"
less /tmp/run.log
