---
.left-column[
  ### Runner for TinyTest
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser, but -- that's useless for continuous integration!  We must have test results on the command line. The Selenium wrapper <a href='https://github.com/warehouseman/meteor-tinytest-runner' target='_blank'>warehouseman:meteor-tinytest-runner</a> does that for us.

In this step we :
1. Get the installer for the test runner and then run it *(Note that it deletes itself after preparing everything for immediate use)*
3. Run all tests

##### Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.run
./meteor-tinytest-runner.run
./tests/tinyTests/test-all.sh
```
<!-- Code for this begins at line #228 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L228" target="_blank">Code for this step.</a>] ]
]
