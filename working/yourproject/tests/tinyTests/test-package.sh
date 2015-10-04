#!/bin/bash

PACKAGE="$1"
if [ -z "${PACKAGE}" ]; then
  echo "ERROR: No package specified."
  exit 1
fi

LOG_DIR="/tmp/meteor-test-runner"
# CirleCI.
if [ -n "${CIRCLE_ARTIFACTS}" ]; then
  LOG_DIR="${CIRCLE_ARTIFACTS}"
fi
LOG_DIR="${LOG_DIR}/${PACKAGE}"
rm -rf ${LOG_DIR}
mkdir -p ${LOG_DIR}

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

run_meteor()
{
  # Keep a copy of Meteor output in a log file.
  ~/.meteor/meteor test-packages --once --driver-package 'test-in-console' -p 4096 ${PACKAGE} | tee ${LOG_DIR}/meteor.log
}

while true; do
  # Spawn the test process.
  echo "  > Spawning test process..."
  # Redirect standard output to file descriptor #3 so we can wait for Meteor to get ready.
  { exec 3< <(run_meteor) ; } 2>/dev/null
  # Wait until Meteor reports that it is 'listening'.
  echo "  > Waiting for Meteor to start..."
  METEOR_STARTED=0
  while read line; do
     case "$line" in
     *listening*)
        echo "  > Meteor seems ready, going to run tests in a moment."
        METEOR_STARTED=1
        sleep 5
        break
        ;;
     *)
        ;;
     esac
  done <&3

  if [ "${METEOR_STARTED}" == "1" ]; then
    break
  fi

  echo "  ? Failed to start Meteor, retrying."
  exec 3<&-
  killall node 2>/dev/null
  wait 2>/dev/null
done

# Drain file descriptor in the background. Otherwise the buffer may fill up and block I/O.
{ while read line; do true; done <&3; } &

# Run the test.
echo "  > Running the test runner..."
node ${SCRIPT_DIR}/runner.js
RESULT=$?

# Close the file descriptor.
exec 3<&-
killall node 2>/dev/null
wait 2>/dev/null
exit $RESULT
