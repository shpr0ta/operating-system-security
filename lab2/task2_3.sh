#!/bin/bash
# 2.3 Читает stdin построчно, строки со словом "bin" целиком -> stderr
set -euo pipefail

while IFS= read -r line; do
    if grep -qw 'bin' <<< "$line"; then
        printf '%s\n' "$line" >&2
    fi
done
