---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI configuration file and push to GitHub

The document <a href="https://circleci.com/docs/configuration" target="_blank">Configuring CircleCI</a> provides full details of '```circle.yml```' file preparation.

In this step, we can get a minimal '```circle.yml```' from the example ('```example_circle.yml```') provided with the installer for <a href="https://github.com/warehouseman/meteor-tinytest-runner" target="_blank">warehouseman:meteor-tinytest-runner</a>, we used in <a href="http://localhost:8000/Meteor-CI-Tutorial/index.html?part=C#9" target="_blank">"Part C : Runner for TinyTest"</a>.

#####Commands
```terminal
mv example_circle.yml circle.yml
git add packages circle.yml tests
git commit -am 'Added package and package testing'
git push -u origin master
```


<!-- Code for this begins at line #21 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L21" target="_blank">Code for this step.</a>] ]
]
