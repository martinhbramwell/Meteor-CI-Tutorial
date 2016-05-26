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
