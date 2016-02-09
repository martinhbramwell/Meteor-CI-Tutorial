---
name: ConfigureCircleCIforNightwatchTesting
last_update: 2016-02-09
 .left-column[
  ### Commit Nightwatch
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

#### Configure CircleCI for Nightwatch Testing

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI.

The Nightwatch runner's ```circle.yml``` can safely overwrite the one for TinyTest.  We still need to do that **and** we need to restore the call to execute ```obtain_managed_packages.sh``` 

First, in the project main directory, make a copy of the ```circle.yml``` augmented for nightwatch, then patch it, adding the call to ```obtain_managed_packages.sh``` as we did earlier, then push it to GitHub and see how it builds in CircleCI.

##### Example Commands
```terminal
cp tests/nightwatch/config/example_circle.yml circle.yml;
git add tests/nightwatch;
git commit -am 'Added Nightwatch testing';
git push
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L459" target="_blank">Code for this step.</a>] ]
]
