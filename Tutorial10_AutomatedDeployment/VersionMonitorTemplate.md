---

 .left-column[
  ### One Last Thing
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Version Monitor Template

Every piece of software needs to be able to report its version.  To do this in a simple way, we modify one file and add three more to our package: 
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/versionMonitor.html" target="_blank">versionMonitor.html
</a> A Meteor (SpaceBars) template containing links to the main project artifact versions.
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/versionMonitor.js" target="_blank">versionMonitor.js
</a> A helper script that delivers the version information for the template.
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/versionMonitor.sh" target="_blank">versionMonitor.sh
</a> A build time shell script that patches versioning information into the helper script
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/perform_ci_tasks_T10_10.sh" target="_blank">perform_ci_tasks.sh</a> We modify this file adding one new command to the existing three to be performed when it is our package's turn in the build process :

##### Example Commands
```http
source ./tools/versionMonitor.sh;
PatchVersionMonitorHelper;
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L506" target="_blank">Code for this step.</a>] ]
]
