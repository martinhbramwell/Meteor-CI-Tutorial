#!/bin/bash
#

set -e
#
source ./udata.sh

echo "~/${PARENT_DIR}/${PROJECT_NAME}/packages";

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages >/dev/null;

    rm -f dummy/ci/per*;
    rm -f ./perf*;

  popd >/dev/null;

