---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### TinyTest a package.

Meteor makes unit testing of packages very easy. One command and we see test results each time we save a file.

In the accompanying script, the ampersand ```"&"``` causes Meteor package testing to start up as a background process.  In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

#####Commands
```terminal
meteor test-packages &
tree
```
To stop Meteor and move on to the next step in the tutorial script, after you have confirmed that it ran successful tests, just hit ```<enter>```.
<!-- Code for this begins at line #197 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L197" target="_blank">Code for this step.</a>] ]
]
