---
.left-column[
  ### Create Meteor Packages
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Working on your Meteor package.

One disadvantage of keeping packages outside your project directory is that you lose Meteor's automatic refresh on saving changes.

That's easily fixed.  You simply need to establish a symbolic link from your packages directory to the real package :
1. step into the packages directory of your project
2. create a symbolic link

##### Example Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/packages
ln -s ${PACKAGES}/${YOUR_UID}/${PKG_NAME} ${PKG_NAME}
```
For editing purposes your package now appears to be part of your project.  But wait!  It won't be "git managed", will it?!



<!-- Code for this begins at line #102 -->
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
    <i>Hover Note</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L77" target="_blank">Code for this step.</a>] ]
]
