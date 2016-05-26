---
last_update: 2016-05-26
 .left-column[
  ### Create Meteor Packages
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

#### Create a "self-sufficient" Meteor module.

... continuing.

Now that Meteor can find your modules, you can create one and install it in your project :
1. step into the directory you created earlier
2. use ```meteor create``` to create your module
3. use ```add``` to add the module to your project
4. use ```list``` to confirm the module was added.

##### Example Commands
```terminal
cd ~/${PARENT_DIR}/modules/${YOUR_UID}
meteor create --package ${GITHUB_ORGANIZATION_NAME}:${MODULE_NAME}
cd ~/${PARENT_DIR}/${PROJECT_NAME}
meteor add ${GITHUB_ORGANIZATION_NAME}:${MODULE_NAME}
meteor list
```
Your module will be part of your project's run time, but not part of it at edit time. That's next . . .

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L24" target="_blank">Code for this step.</a>] ]
]
