---
last_update: 2016-02-14
 .left-column[
  ### Final Deployment
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

#### Push Final Changes

Our final operation is simple: add our latest files to our local ```git``` repository and commit everything to GitHub.  GitHub will trigger CircleCI's web hook and CircleCI will then pull and rerun the build, test and deploy sequence.

**Tip** :  Suppose you want to commit some documentation changes without triggering the web hook.  How would you do it?  CircleCI provides for a ```[ci skip]``` annotation in commit messages.  The commit shown below will NOT trigger a build due to the presence of that flag.

##### Example Commands
```terminal
git add ./tools
git commit -am "Added support and scripts for Android APK build and Meteor deploy, but [ci skip]";
git push;
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L559" target="_blank">Code for this step.</a>] ]
]
