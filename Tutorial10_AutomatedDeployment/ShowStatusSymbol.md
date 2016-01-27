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

#### Show Status Symbol

GitHub repositories often sport "status badges" that indicated the status of the most recent build on a given continuous integration service. Now we'll look at how to get a CircleCI pass <img src='./fragments/failing.svg' /> or fail <img src='./fragments/failing.svg' /> badge on the README.md file of our package.  Remember however that we don't build the package, we build the umbrella project that contains the package.  Nevertheless, we can put the badges anywhere; so we can put the project status badge on the package README.

To show it works, we'll deliberately fail a test, and see what happens to the badge.  We'll fix it before we run our final build and deploy.  One more thing ... we'll add the build number to the app just before building, so we can see the installed version number in mobile devices. 


##### Example Commands
```terminal
git add ./tools
git commit -am "Added support and scripts for Android APK build and Meteor deploy, but [ci skip]";
git push;
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L476" target="_blank">Code for this step.</a>] ]
]
