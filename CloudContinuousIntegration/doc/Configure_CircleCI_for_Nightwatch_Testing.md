---
name: ConfigureCircleCIforNightwatchTesting
.left-column[
  ### Commit Nightwatch
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure CircleCI for Nightwatch Testing

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI.

The Nightwatch runner's ```circle.yml``` can safely overwrite the one for TinyTest.  We will still need to do it, **and** we need to restore the code for using ${PKG_NAME} that we applied in the step ["Amend the Configuration and Push Again"](#AmendTheConfigurationAndPushAgain), (again, not forgetting appropriate substitutions).

First get the augmented ```circle.yml``` . . .

##### Commands
```terminal
cp tests/nightwatch/config/example_circle.yml circle.yml;
```

Continued . . .
<!-- Code for this begins at line #147 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L147" target="_blank">Code for this step.</a>] ]
]
