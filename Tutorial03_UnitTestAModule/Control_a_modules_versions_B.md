---

 .left-column[
  ### Package Version Control
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor module
. . . continued.

##### Example Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add ${MODULE_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}:${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}.git
git push -u ${MODULE_NAME}_origin master
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L172" target="_blank">Code for this step.</a>] ]
]
