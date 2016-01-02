---
last_update: 2015-12-18
 .left-column[
  ### Helper File - GitHub "UserKey"
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Build Script Authorization

The function, ```commitDocsToGitHubPages()```, presents us with a problem.

Back in Part #6 we authorized CircleCI to access our GitHub project with a "GitHub User Key" -- now we're going to need it.  Without it, our ```circle.yml``` script will fail when it tries to push our documentation to the *gh-pages* branches of our packages.  As CircleCI's manual page, <a href="https://circleci.com/docs/github-security-ssh-keys" target="_blank">*GitHub security and SSH keys*</a> indicates, we need a heightened privileges "UserKey", in order to push back to GitHub from CircleCI.

Open your project's page, "Checkout keys for ${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}", ensure "${PACKAGE_DEVELOPER} user key" exists and (optionally) delete the redundant deploy key :

```ruby
https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout
``` 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L154" target="_blank">Code for this step.</a>] ]
]
