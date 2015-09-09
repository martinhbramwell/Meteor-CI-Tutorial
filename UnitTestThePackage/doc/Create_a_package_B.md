---
.left-column[
  ### Create a Meteor Package
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
cd ${PACKAGE_DIRS}/yourself
meteor create --package yourself:yourpackage
cd ~/projects/${PROJECT_NAME}
meteor add yourself:yourpackage
meteor list
```
Your package will be part of your project's run time, but not part of it at edit time. That's next . . .
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L273" target="_blank">Code for this step.</a>] ]
]
