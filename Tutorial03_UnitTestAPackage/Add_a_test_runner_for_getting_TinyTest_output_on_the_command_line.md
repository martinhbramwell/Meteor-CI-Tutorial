---
last_update: 2016-02-05
 .left-column[
  ### Runner for TinyTest
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser, but -- that's useless for continuous integration!  We must have test results on the command line. The Selenium wrapper <a href='https://github.com/warehouseman/meteor-tinytest-runner' target='_blank'>warehouseman:meteor-tinytest-runner</a> does that for us.

In this step we :
1. Get the installer for the test runner and then run it *(Note that it deletes itself after preparing everything for immediate use)*
3. Run all tests

##### Example Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.bin
./meteor-tinytest-runner.bin
./tests/tinyTests/test-all.sh
```
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L251" target="_blank">Code for this step.</a>] ]
]
