#!/bin/bash

# On Mac OS X GNU grep is ggrep.
if hash ggrep 2>/dev/null; then
  GREP='ggrep'
else
  GREP='grep'
fi

# Packages with tests. To ignore a package, place // NOTEST after the onTest definition.
PACKAGES=$( $GREP -PRl 'Package\.(onTest|on_test)(?!.*// NOTEST)' packages | $GREP -Po 'packages/\K.*(?=/)' | sort -u );

if [[ $(wc -l <<< "${PACKAGES}") -lt 3 ]]; then 
  echo "Found no packages to test.";
  exit 1;
fi;

SCRIPT_DIR="$( dirname "${BASH_SOURCE[0]}" )"

# Perform tests.
TESTS_FAILED=0
PACKAGES_FAILED=""
for pkg in ${PACKAGES}; do
  echo ">>> Testing a package '${pkg}'..."
  "${SCRIPT_DIR}/test-package.sh" packages/${pkg} || {
    echo "ERROR: Tests for package '${pkg}' failed."
    TESTS_FAILED=1
    PACKAGES_FAILED="${PACKAGES_FAILED} ${pkg}"
  }
done

if [ "${TESTS_FAILED}" == "1" ]; then
  echo "ERROR: Some of the packages have failing tests:"
  echo "ERROR: ${PACKAGES_FAILED}"
  echo "ERROR: For details see output above."
fi

exit ${TESTS_FAILED}
