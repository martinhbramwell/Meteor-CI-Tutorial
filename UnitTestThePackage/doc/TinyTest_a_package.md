---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### TinyTest a package.

Meteor makes unit testing packages very easy. A single command and we have  unit tested our package.

Meteor will start up as a background process in TinyTest mode.

In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

#####Commands
```terminal
meteor test-packages &
tree
```
To stop Meteor, hit ```<enter>``` after you have confirmed that it ran successful tests.
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L354" target="_blank">Code for this step.</a>] ]
]
