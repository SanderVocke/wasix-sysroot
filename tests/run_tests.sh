#!/bin/bash
WD=$(pwd)
TESTS=
STATUS=0
FAILED_TESTS=""
PASSED_TESTS=""

if [ ! -z "${@:1}" ]; then
    TESTS=${@:1}
else
    TESTS=$(cd $WD/tests && ls -d */)
fi

for test in $TESTS; do
    mkdir -p $WD/test-builds/${test}
    cd $WD/test-builds/${test}
    cmake --fresh -DCMAKE_MAKE_PROGRAM=make -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN -DCMAKE_SYSROOT=/opt/wasix-sysroot $WD/tests/${test}
    cmake --build . --target all
    bash $WD/tests/${test}/test.sh
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
        PASSED_TESTS="$PASSED_TESTS $test"
    else
        FAILED_TESTS="$FAILED_TESTS $test"
        STATUS=1
    fi
done

echo "Passed tests: $PASSED_TESTS"
echo "Failed tests: $FAILED_TESTS"
exit $STATUS
