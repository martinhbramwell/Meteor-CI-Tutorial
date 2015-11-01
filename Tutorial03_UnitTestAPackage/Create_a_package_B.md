---
.left-column[
  ### Create Meteor Packages
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
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

##### Example Commands
```terminal
cd ~/${PARENT_DIR}/packages/${YOUR_UID}
meteor create --package ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}
cd ~/${PARENT_DIR}/${PROJECT_NAME}
meteor add ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}
meteor list
```
Your package will be part of your project's run time, but not part of it at edit time. That's next . . .

<!-- Code for this begins at line #35 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L12" target="_blank">Code for this step.</a>] ]
]
