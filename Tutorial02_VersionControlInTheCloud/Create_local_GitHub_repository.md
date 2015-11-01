---
name: CreateLocalGitHubRepository
.left-column[
  ### Local GitHub Repo
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Create our **local** GitHub repository.
In this step we :
 -  initialize a local .git repository
 -  add all the files to the local repo and commit
 -  establish our GitHub project as the remote repository
 -  push our new files to GitHub

**This step is NOT idempotent.**  If you have already pushed to GitHub you might get errors. If so, eliminate the project from GitHub and run this step again. *Also note : SSH may ask you to confirm GitHub's PK fingerprint.*

##### Example Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add ${PROJECT_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
git push -u ${PROJECT_NAME}_origin master
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L232" target="_blank">Code for this step.</a>] ]
]
