---
last_update: 2016-01-02
 .left-column[
  ### Integrating Everything
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Integrating Everything

We have two last pushes to do: the package and its enclosing test/demo project.  However, we want CircleCI to do a lot more work for us.

Up to now, we commit the package with a new version number, then commit the umbrella project referencing the new version.  That triggers CircleCI to launch a new build sequence that pulls the project and packages together and runs all their tests, but it neither verifies coding style compliance nor regenerates our documentation nor deploys to our public server.

Our focus for the rest of this part is going to be on <a href="https://circleci.com/docs/configuration" target="_blank">configuring</a> our ```circle.yml``` file.  We'll verify coding style during CircleCI's ```test``` phase.  We'll publish our documentation and deploy the application itself during the ```deployment``` phase.  For now we'll just commit/push and check it all works.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L65" target="_blank">Code for this step.</a>] ]
]
