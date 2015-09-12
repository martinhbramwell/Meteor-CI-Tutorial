---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a "self-sufficient" Meteor package.

... continuing.

Now that Meteor can find your packages, you can create one and install it in your project :
1. step into the directory you created earlier
2. use ```meteor create``` to create your package
3. use ```add``` to add the package to your project
4. use ```list``` to confirm the package was added.

#####Commands
```terminal
cd ~/${PARENT_DIR}/packages/${YOUR_NAME}
meteor create --package ${PACKAGE_DEVELOPER}:${PKG_NAME}
cd ~/${PARENT_DIR}/${PROJECT_NAME}
meteor add ${PACKAGE_DEVELOPER}:${PKG_NAME}
meteor list
```
Your package will be part of your project's run time, but not part of it at edit time. That's next . . .
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L279" target="_blank">Code for this step.</a>] ]
]
