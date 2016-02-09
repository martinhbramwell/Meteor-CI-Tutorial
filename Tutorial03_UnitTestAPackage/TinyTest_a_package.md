---
last_update: 2016-02-09
 .left-column[
  ### Test a Meteor Package
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### TinyTest a package.

Meteor makes unit testing of packages very easy. One command and we see test results each time we save a file.

In the accompanying script, the ampersand ```"&"``` causes Meteor package testing to start up as a background process.  In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

##### Example Commands
```terminal
meteor test-packages &
tree
```
To stop Meteor and move on to the next step in the tutorial script, after you have confirmed that it ran successful tests, just hit ```<enter>```.
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L224" target="_blank">Code for this step.</a>] ]
]
