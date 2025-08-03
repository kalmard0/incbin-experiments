#!/bin/bash
set -euo pipefail
readonly TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT
echo "Temp directory: $TMP_DIR"

echo "Blob size: $(stat -c %s blob.data) bytes"

echo -n "gcc version: "
gcc -dumpversion
echo -n "clang version: "
clang --version | head -n 1 | cut -d ' ' -f 3

cp incbin.c main.c blob.data "$TMP_DIR"
pushd "$TMP_DIR" > /dev/null
mkdir gcc clang

echo "Compiling gcc incbin"
(time gcc -o gcc/incbin.o -c incbin.c) 2>&1

echo "Compiling clang incbin"
(time clang -o clang/incbin.o -c incbin.c) 2>&1
clang -o gcc/main main.c gcc/incbin.o

clang -o clang/main main.c clang/incbin.o
popd > /dev/null

echo "Running gcc version"
$TMP_DIR/gcc/main
echo "Running clang version"
$TMP_DIR/clang/main
echo "DONE"