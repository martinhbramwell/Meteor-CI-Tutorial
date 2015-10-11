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

The Nightwatch runner's ```circle.yml``` can safely overwrite the one for TinyTest.  We still need to do that **and** we need to restore the call to execute ```ci_help.sh``` 

First, in the project main directory, make a copy of the ```circle.yml``` augmented for nightwatch, then patch it, adding the call to ```ci_help.sh``` as we did earlier.

##### Commands
```terminal
cp tests/nightwatch/config/example_circle.yml circle.yml;
git add tests/nightwatch;
git commit -am 'Added Nightwatch testing';
git push
```

<!-- Code for this begins at line #165 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L165" target="_blank">Code for this step.</a>] ]
]
