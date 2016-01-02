---
last_update: 2016-01-02
 .left-column[
  ### Helper File - Arbitrary # of Tasks.
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Code Maintenance Helper File (Part C)

We now need to make the package level maintenance script actually do something.

The prepared script, <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_ci_tasks.sh" target="_blank">"perform_ci_tasks.sh"</a>, has 3 functions: 

1)  ```generateDocs()``` simply writes documents locally without trying to publish on GitHub Pages. 

2) ```checkCodeStyle()``` should write it's results to CircleCI's <a href="https://circleci.com/docs/build-artifacts" target="_blank">build artifacts directory</a> specified by <a href="https://circleci.com/docs/environment-variables" target="_blank">the environment variable</a> ```CIRCLE_ARTIFACTS```.  Of course, if we are working locally, that variable will be ```null```.  We have to set it to something, so we simply make it: "```.```".

3) ```commitDocsToGitHubPages()``` is temporarily commented out.

Executing, ```perform_per_package_ci_tasks.sh```, now will show ```esLint``` and ```jsDoc``` completing their respective tasks.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L128" target="_blank">Code for this step.</a>] ]
]
