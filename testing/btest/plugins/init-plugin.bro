# @TEST-EXEC: ${DIST}/aux/bro-aux/plugin-support/init-plugin Demo Foo
# @TEST-EXEC: make BRO=${DIST}
# @TEST-EXEC: BRO_PLUGIN_PATH=`pwd` bro -NN Demo::Foo >>output
# @TEST-EXEC: echo === >>output
# @TEST-EXEC: BRO_PLUGIN_PATH=`pwd` bro -r $TRACES/port4242.trace >>output
# @TEST-EXEC: TEST_DIFF_CANONIFIER= btest-diff output
