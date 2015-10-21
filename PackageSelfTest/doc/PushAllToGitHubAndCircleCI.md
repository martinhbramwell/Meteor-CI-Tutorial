---
.left-column[
  ### The circle.yml File
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### One Final Push

Well, in fact, we have three last pushes to do: the package, its documentation and the enclosing test/demo project.

Also, we are not finished <a href="https://circleci.com/docs/configuration" target="_blank">configuring</a>  our ```circle.yml``` file.  It pulls the project and packages together and runs all their tests, but it neither verifies coding style compliance nor regenerates our documentation nor deploys to our public server.

We'll verify coding style during CircleCI's ```test``` phase.

We'll publish our documentation and deploy the application itself during the ```deployment``` phase.

Continues ...

<!-- Code for this begins at line #84 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L84" target="_blank">Code for this step.</a>] ]
]
