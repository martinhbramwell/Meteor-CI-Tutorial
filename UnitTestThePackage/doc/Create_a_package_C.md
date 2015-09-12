---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Working on your Meteor package.

One disadvantage of keeping packages outside your project directory is that you lose Meteor's automatic refresh on saving changes.

That's easily fixed.  You simply need to establish a symbolic link from your packages directory to the real package :
1. step into the packages directory of your project
2. create a symbolic link

#####Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/packages
ln -s ${PACKAGE_DIRS}/${YOUR_NAME}/${PKG_NAME} ${PKG_NAME}
```
For editing purposes your package now appears to be part of your project.
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L344" target="_blank">Code for this step.</a>] ]
]
