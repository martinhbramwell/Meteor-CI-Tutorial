---
last_update: 2016-02-09
 .left-column[
  ### One Last Thing
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

#### Show Status Symbol

The presence or lack of build status badges on the main README pages of project repositories testify to their level of development sophistication.

Our nest task is to get a CircleCI ```fail``` <img src='./fragments/failing.svg' /> or ```pass``` <img src='./fragments/passing.svg' /> badge on the README.md file of our package.  Even though we build the umbrella project that contains our package, not the package itself, we can still put the project status badge on the package README.

To show it works, we'll deliberately fail a test, and see what happens to the badge.  We'll fix it before we run our final build and deploy.

##### Example Commands
```http
Build by [CircleCI](https://circleci.com) :: [![Circle CI](https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.svg?style=shield)](https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME})
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L490" target="_blank">Code for this step.</a>] ]
]
