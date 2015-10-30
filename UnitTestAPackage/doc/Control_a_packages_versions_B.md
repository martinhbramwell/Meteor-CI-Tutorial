---
.left-column[
  ### Package Version Control
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor package
. . . continued.

##### Example Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add ${PKG_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}:${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git
git push -u ${PKG_NAME}_origin master
```

<!-- Code for this begins at line #183 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L183" target="_blank">Code for this step.</a>] ]
]
