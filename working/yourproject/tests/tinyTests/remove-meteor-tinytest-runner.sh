#!/bin/bash
#
echo "Purging meteor-tinytest-runner from this filesystem."
cd $(dirname $0)
rm -fr ../../example_circle.yml
rm -fr ./runner.js
rm -fr ./install_dependencies.sh
rm -fr ./test-all.sh
rm -fr ./test-package.sh
rm -fr ./remove-meteor-tinytest-runner.sh
[ `ls -1A . | wc -l` -eq 0 ] && rm -fr ../tinyTests
cd ..
[ `ls -1A . | wc -l` -eq 0 ] && rm -fr ../tests
