---
last_update: 2016-05-26
 .left-column[
  ### Package Version Control
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor module.

Another consequence of keeping modules outside your project directory is the need for a separate version control repository for each one.

The resulting modularity is benefical and the multiplication of git commands can be mitigated by using <a href="https://git-scm.com/book/en/v2/Git-Tools-Submodules" target="_blank">git submodules</a> *("Submodules allow you to keep a Git repository as a subdirectory of another Git repository.")*.

That's beyond the scope of this tutorial.  However, we must, in any case, repeat the earlier steps to create [remote](./toc.html?part=B#9) and [local](./toc.html?part=B#11) repositories -- this time for ```${MODULE_NAME}```.

**Be sure to prepare a GitHub repo called ```${MODULE_NAME}``` with its own deploy key in the same way you did for ```${PROJECT_NAME}```**

Continues . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L146" target="_blank">Code for this step.</a>] ]
]
