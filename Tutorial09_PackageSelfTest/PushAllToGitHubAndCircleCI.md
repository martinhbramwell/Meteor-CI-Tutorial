---
last_update: 2015-12-18
 .left-column[
  ### The circle.yml File
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Integrating Everything

We have two last pushes to do: the package and its enclosing test/demo project.  However, we have a lot more work for CircleCI to do for us.

We commit the package with a new version number, then the umbrella project referencing the new version.  That triggers CircleCI to launch a new build sequence.  At the moment, it pulls the project and packages together and runs all their tests, but it neither verifies coding style compliance nor regenerates our documentation nor deploys to our public server.

Our focus for this part is going to be on <a href="https://circleci.com/docs/configuration" target="_blank">configuring</a> our ```circle.yml``` file.  We'll verify coding style during CircleCI's ```test``` phase.  We'll publish our documentation and deploy the application itself during the ```deployment``` phase.

Continues ...

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L88" target="_blank">Code for this step.</a>] ]
]
