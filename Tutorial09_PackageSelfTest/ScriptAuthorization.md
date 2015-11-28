---
.left-column[
  ### Helper File - Code Linting
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Build Script Authorization

The function, ```commitDocsToGitHubPages()```, presents us with a problem.

When we authorized CircleCI to access our GitHub project, all it got was a deploy key with read-only privileges on that single project.  This will fail when we push our documentation to the *gh-pages* branches of our packages.  As CircleCI's manual page, <a href="https://circleci.com/docs/github-security-ssh-keys" target="_blank">*GitHub security and SSH keys*</a> indicates, we need a heightened privileges "UserKey".

Open your project's config page, "Checkout keys for ${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}", add a user key and (optionally) delete the redundant deploy key :

```ruby
https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout
``` 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L147" target="_blank">Code for this step.</a>] ]
]
