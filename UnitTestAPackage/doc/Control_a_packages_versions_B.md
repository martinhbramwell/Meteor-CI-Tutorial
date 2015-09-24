---
.left-column[
  ### Package Version Control
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor package
. . . continued.

#####Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add ${PKG_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}:${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git
git push -u ${PKG_NAME}_origin master
```

<!-- Code for this begins at line #179 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L179" target="_blank">Code for this step.</a>] ]
]
