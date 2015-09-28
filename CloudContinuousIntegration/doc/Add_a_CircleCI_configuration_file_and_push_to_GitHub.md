---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI Configuration File and Push to GitHub

The file <a href="https://circleci.com/docs/configuration" target="_blank">Configuring CircleCI</a> documents how to prepare a '```circle.yml```' file.

In this step, we get a minimal '```circle.yml```' from the example ('```example_circle.yml```') provided with the installer for <a href="https://github.com/warehouseman/meteor-tinytest-runner" target="_blank">warehouseman:meteor-tinytest-runner</a>, that we used in <a href="http://localhost:8000/Meteor-CI-Tutorial/index.html?part=C#9" target="_blank">"Part C"</a>.  It will not succeed, for an obvious reason :
```ruby
$ tests/tinyTests/test-all.sh
grep: packages/yourpackage: No such file or directory
ERROR: Found no packages to test. tests/tinyTests/test-all.sh returned exit code 1
```

#####Commands
```terminal
cp example_circle.yml circle.yml
git add packages circle.yml tests
git commit -am 'Added package and package testing' && git push
```


<!-- Code for this begins at line #21 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L21" target="_blank">Code for this step.</a>] ]
]
