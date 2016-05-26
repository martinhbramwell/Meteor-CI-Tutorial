layout: false

 .left-column[
  ### PART C INTRODUCTION

.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Create and Unit Test a Module

These scripts will get you started easily with Meteor module development, testing, logging, documenting, code style linting and continuous deployment.

The previous script, 'Tutorial02_VersionControlInTheCloud.sh', set up a Meteor application with version control in the cloud. 

This one . . .  
```terminal
./Tutorial03_UnitTestAModule.sh
```
. . . prepares a Meteor project with an associated external module, tested with TinyTest, and **stored separately in GitHub**.


<!-- B -->
<div id="pkg2mod" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('pkg2mod'); return true;"
       href="javascript:HideContent('pkg2mod')">
        <p>We use the terms 'package' and 'module' interchangeably.  However, 'package' is Meteor's old name and 'module' is its new name, for replaceable self-sufficient components.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('pkg2mod'); return true;"
    href="javascript:ReverseContentDisplay('pkg2mod')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note ::> 'package or 'module' ??</i>
</a>


]
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

#### Working on your Meteor module.

One disadvantage of keeping modules outside your project directory is that you lose Meteor's automatic refresh on saving changes.

That's easily fixed.  You simply need to establish a symbolic link from your modules directory to the real module :
1. step into the modules directory of your project
2. create a symbolic link

##### Example Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/modules
ln -s ${PACKAGES}/${YOUR_UID}/${MODULE_NAME} ${MODULE_NAME}
```
For editing purposes your module now appears to be part of your project.  But wait!  It won't be "git managed", will it?!



<!-- B -->
<div id="symwarn" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('symwarn'); return true;"
       href="javascript:HideContent('symwarn')">
        <p>The symlink will cause a mild warning during Meteor start up : "The handle(2) returned by watching ${REAL_PACKAGE} is the same with an already watched path(${LINKED_PACKAGE})".</p><p>You can ignore it.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('symwarn'); return true;"
    href="javascript:ReverseContentDisplay('symwarn')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note ::> Spurious warning ??</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L121" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
  ### Prepare SSH directory
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

#### Prepare Deploy Keys for a GitHub Repository.
 
This step is a repeat of the equivalent operation from the previous part.
Names are made to be distinct, deliberately, so *git* meets no ambiguity about connecting local repos to the correct remote repo.

In this step we prepare an aliased key for ```${MODULE_NAME}```.
##### Example Commands
```terminal
ssh-keygen -t rsa -b 4096 -C "github-${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}" -N "" -f "${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}"
printf 'Host github-%s-%s\nHostName github.com\nUser git\nIdentityFile ~/.ssh/%s-%s\n\n' "${GITHUB_ORGANIZATION_NAME}" "${MODULE_NAME}"  "${GITHUB_ORGANIZATION_NAME}" "${MODULE_NAME}" >> config
ssh-add ${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}
```


<!-- B -->
<div id="pubkey" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('pubkey'); return true;"
       href="javascript:HideContent('pubkey')">
        <p>If a file '~/.ssh/${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}.pub' already exists, then this command group will do nothing.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('pubkey'); return true;"
    href="javascript:ReverseContentDisplay('pubkey')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note ::> Non-destructive !</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L131" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
  ### Package Version Control
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor module.

Another consequence of keeping modules outside your project directory is the need for a separate version control repository for each one.

The resulting modularity is benefical and the multiplication of git commands can be mitigated by using <a href="https://git-scm.com/book/en/v2/Git-Tools-Submodules" target="_blank">git submodules</a> *("Submodules allow you to keep a Git repository as a subdirectory of another Git repository.")*.

That's beyond the scope of this tutorial.  However, we must, in any case, repeat the earlier steps to create [remote](./toc.html?part=B#9) and [local](./toc.html?part=B#11) repositories -- this time for ```${MODULE_NAME}```.

**Be sure to prepare a GitHub repo called ```${MODULE_NAME}``` with its own deploy key in the same way you did for ```${PROJECT_NAME}```**

Continues . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L146" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
  ### Package Version Control
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

#### Controlling Versions of your Meteor module
. . . continued.

##### Example Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add ${MODULE_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}:${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}.git
git push -u ${MODULE_NAME}_origin master
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L172" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
  ### Test a Meteor Package
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

#### TinyTest a module.

Meteor makes unit testing of modules very easy. One command and we see test results each time we save a file.

In the accompanying script, the ampersand ```"&"``` causes Meteor package testing to start up as a background process.  In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

##### Example Commands
```terminal
meteor test-packages &
tree
```
To stop Meteor and move on to the next step in the tutorial script, after you have confirmed that it ran successful tests, just hit ```<enter>```.
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L232" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
  ### Runner for TinyTest
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

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser, but -- that's useless for continuous deployment!  We must have test results on the command line. The Selenium wrapper <a href='https://github.com/warehouseman/meteor-tinytest-runner' target='_blank'>warehouseman:meteor-tinytest-runner</a> does that for us.

In this step we :
1. Get the installer for the test runner and then run it *(Note that it deletes itself after preparing everything for immediate use)*
3. Run all tests

##### Example Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.bin
./meteor-tinytest-runner.bin
./tests/tinyTests/test-all.sh
```
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L259" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
    ### End Of Part #C
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

Toegether, the preceding three parts will have left you with a minimal module, version managed apart from the app, but testable inside the app. 

The next section will guide you through preparations for ensuring coding standards conformance. 

[Part #D - Code Quality - Coding Style and Linting](./toc.html?part=D)


<!-- B -->]
