---
.left-column[
  ### Configure git for GitHub
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure git for use with GitHub.

In this step we set up the local git tool kit to communicate correctly with GitHub, per <a href='https://help.github.com/articles/set-up-git/' target='_blank'>their getting started guide</a>.

Steps performed :
 - identify user name
 - identify user email
 - use simple push


##### Example Commands
```terminal
git config --global user.name "${YOUR_FULLNAME}"
git config --global user.email "${YOUR_EMAIL}"
git config --global push.default simple
```

<!-- Code for this begins at line #41 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L41" target="_blank">Code for this step.</a>] ]
]
