---

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

#### Create a Meteor module development directory.

If you aim for "module only applications", if modules are to be reusable, your modules need independent version control, and to reside in a directory outside of the project, that you specify with Meteor's shell variable ```MODULE_DIRS```.

To create self-sufficient modules, begin by defining ```MODULE_DIRS``` as a permanent fixture of your user profile, pointing to the place where you will keep your modules.

##### Example Commands
```terminal
export MODULES=~/${PARENT_DIR}/modules;
export MODULE_DIRS=${MODULES}/thirdparty:${MODULES}/${YOUR_UID};
mkdir -p ${MODULES}/${YOUR_UID}; mkdir -p ${MODULES}/thirdparty;
export HAS_MODULE_DIRS=$(grep MODULE_DIRS ~/.profile | grep -c ${MODULES} ~/.profile);
[[ ${HAS_MODULE_DIRS} -lt 1 ]] && echo -e "\n#\nexport MODULE_DIRS=${MODULE_DIRS}" >> ~/.profile;
source ~/.profile;
```
Continued . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L4" target="_blank">Code for this step.</a>] ]
]
