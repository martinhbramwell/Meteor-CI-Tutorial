---
.left-column[
  ### Runner for TinyTest
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser.  This is useless for continuous integration.

We need to have test results on the command line.

The GitHub repo [warehouseman:meteor-tinytest-runner](https://github.com/warehouseman/meteor-tinytest-runner) has a wrapper tool that drives a browser with Selenium and collects the results in text format.

The installer deletes itself after preparing the files for immediate use.


<!-- Code for this begins at line #311-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L297" target="_blank">Code for this step.</a>] ]
]
