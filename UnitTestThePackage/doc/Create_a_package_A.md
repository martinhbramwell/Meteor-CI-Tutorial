---
.left-column[
  ### Create a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor package.

Meteor makes creating a package very easy, but it's deceptive if you aim for the flexibility of "package only applications".  If packages are to be reusable, they need their own independent version control, which means they need a directory outside of the project, whose location is defined by Meteor's shell variable ```PACKAGE_DIRS```.

To create self-sufficient packages, begin by defining ```PACKAGE_DIRS```, as a permanent fixture of your user profile, pointing to the place where you will keep your packages.
#####Commands
```terminal
export PACKAGE_DIRS=~/projects/packages
mkdir -p ${PACKAGE_DIRS}/yourself
mkdir -p ${PACKAGE_DIRS}/somebodyelse
echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS}" >> ~/.profile
```
Continued . . . 
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L259" target="_blank">Code for this step.</a>] ]
]
