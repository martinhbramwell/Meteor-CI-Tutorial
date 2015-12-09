---
.left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI Configuration File and Push to GitHub

The documentation page "<a href="https://circleci.com/docs/configuration" target="_blank">Configuring CircleCI</a>" shows how to prepare a '```circle.yml```' file.

In this step, we get a minimal '```circle.yml```' from the example ('```example_circle.yml```') provided with the installer for <a href="https://github.com/warehouseman/meteor-tinytest-runner" target="_blank">warehouseman:meteor-tinytest-runner</a>, that we used in <a href="http://localhost:8000/Meteor-CI-Tutorial/index.html?part=C#9" target="_blank">"Part C"</a>.  It will not succeed, for an obvious reason :
```ruby
$ ./tests/tinyTests/test-all.sh
grep: packages/yourpackage: No such file or directory
ERROR: Found no packages to test. tests/tinyTests/test-all.sh returned exit code 1
```

##### Example Commands
```terminal
cp example_circle.yml circle.yml
git add circle.yml tests
git commit -am 'Added circle.yml and unit testing' && git push
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L310" target="_blank">Code for this step.</a>] ]
]
