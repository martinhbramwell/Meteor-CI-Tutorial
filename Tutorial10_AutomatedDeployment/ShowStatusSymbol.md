---
last_update: 2016-01-29
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

Now we'll get a CircleCI ```pass``` <img src='./fragments/failing.svg' /> or ```fail``` <img src='./fragments/failing.svg' /> badge on the README.md file of our package.  Even though we build the umbrella project that contains our package, not the package itself, we can still put the project status badge on the package README. To show it works, we'll deliberately fail a test, and see what happens to the badge.  We'll fix it before we run our final build and deploy.

One more thing ... we'll add the build number to the app just before building, so we can see the installed version number in mobile devices. 

##### Example Commands
```http
Build by [CircleCI](https://circleci.com) :: [![Circle CI](https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.svg?style=shield)](https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME})
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L485" target="_blank">Code for this step.</a>] ]
]
