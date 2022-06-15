#!/bin/bash
echo "run code coverage"
DIR=$(pwd)
RAW_FILES=$(find $DIR -type f -name "default.profraw" -exec ls {} \;)
llvm-profdata merge -sparse -o one.profdata $RAW_FILES
llvm-cov show -format=html -output-dir ./report -use-color ./app/bin/basic_test -instr-profile one.profdata
llvm-cov show -format=html -ignore-filename-regex=".*/googletest/*.cc" -ignore-filename-regex=".*/googletest/*.h" -output-dir ./ut_report -use-color ./test/bin/runUnitTests -instr-profile one.profdata