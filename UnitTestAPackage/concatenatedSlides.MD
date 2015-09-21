layout: false
.left-column[
  ### PART C INTRODUCTION

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Create and Unit Test a Package

These scripts will get you started easily with Meteor package development, testing, documenting, code style linting and continuous integration.

The previous script, 'Part02_VersionControlInTheCloud.sh', set up a Meteor application with version control in the cloud. 

This one . . .  
```terminal
./Part03_UnitTestAPackage.sh
```
. . . prepares a Meteor project with an associated external package tested with TinyTest and stored separately in GitHub.



<!-- B -->]
---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor package development directory.

If you aim for "package only applications", if packages are to be reusable, your packages need independent version control, and hence a directory outside of the project, located by Meteor's shell variable ```PACKAGE_DIRS```.

To create self-sufficient packages, begin by defining it as a permanent fixture of your user profile, pointing to the place where you will keep your packages.
##### Commands
```terminal
export PARENT_DIR=projects;
export PACKAGES=~/${PARENT_DIR}/packages;
export PACKAGE_DIRS=${PACKAGES}/somebodyelse:${PACKAGES}/${YOUR_NAME};
mkdir -p ${PACKAGES}/${YOUR_NAME}; mkdir -p ${PACKAGES}/somebodyelse;
export HAS_PACKAGE_DIRS=$(grep PACKAGE_DIRS ~/.profile | grep -c ${PACKAGES} ~/.profile);
[[ ${HAS_PACKAGE_DIRS} -lt 1 ]] && echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS}" >> ~/.profile;
source ~/.profile;
```
Continued . . . 
<!-- Code for this begins at line #22 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L22" target="_blank">Code for this step.</a>] ]
]
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
meteor create --package ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}
cd ~/${PARENT_DIR}/${PROJECT_NAME}
meteor add ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}
meteor list
```
Your package will be part of your project's run time, but not part of it at edit time. That's next . . .
<!-- Code for this begins at line #33 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L33" target="_blank">Code for this step.</a>] ]
]
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
For editing purposes your package now appears to be part of your project.  But wait!  It won't be "git managed", will it?!
<!-- Code for this begins at line #98 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L98" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Package Version Control
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor package.

Another consequence of keeping packages outside your project directory is the need for a separate version control repository for each one.

The resulting modularity is benefical and the multiplication of git commands can be mitigated by using <a href="https://git-scm.com/book/en/v2/Git-Tools-Submodules" target="_blank">git submodules</a> *("Submodules allow you to keep a Git repository as a subdirectory of another Git repository.")*.

That's beyond the scope of this tutorial.  However, we must, in any case, repeat the earlier steps to create [remote](#CreateRemoteGitHubRepository) and [local](#CreateLocalGitHubRepository) repositories -- this time for ```${PKG_NAME}```.

**Be sure to prepare a GitHub repo called '${PKG_NAME}'**

Continues . . . 
<!-- Code for this begins at line #110 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L110" target="_blank">Code for this step.</a>] ]
]
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
git remote add origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git
git push -u origin master
```

<!-- Code for this begins at line #119 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L119" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### TinyTest a package.

Meteor makes unit testing of packages very easy. A single command and we can see test results every time we save a file.

In the accompanying script, the ampersand ```"&"``` causes Meteor package testing to start up as a background process.  In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

#####Commands
```terminal
meteor test-packages &
tree
```
To stop Meteor after you have confirmed that it ran successful tests, hit ```<enter>```.
<!-- Code for this begins at line #139 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L139" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Runner for TinyTest
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser, but -- that's useless for continuous integration!  We must have test results on the command line. The Selenium wrapper [warehouseman:meteor-tinytest-runner](https://github.com/warehouseman/meteor-tinytest-runner) does that for us.

In this step we :
1. Get the installer for the test runner and then run it *(Note that it deletes itself after preparing everything for immediate use)*
3. Run all tests

##### Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.run
./meteor-tinytest-runner.run
./tests/tinyTests/test-all.sh
```
<!-- Code for this begins at line #168 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L168" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
    ### End Of Part #C
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

Toegether, the preceding three parts will have left you with a minimal package, version managed apart from the app, but testable inside the app. 

The next section will guide you through preparations for ensuring coding standards conformance. 

[Part #D - Code Quality - Coding Style and Linting](./?part=D)



<!-- B -->]
