---
name: CreateLocalGitHubRepository
.left-column[
  ### Local GitHub Repo
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

**This step is NOT idempotent.**  If you have already pushed to GitHub you might get errors. If so, eliminate the project from GitHub and run this step again. *Also note : SSH may ask you to confirm GitHub's PK fingerprint.**
#####Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add origin git@github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
git push -u origin master
```

<!-- Code for this begins at line #277 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L277" target="_blank">Code for this step.</a>] ]
]
