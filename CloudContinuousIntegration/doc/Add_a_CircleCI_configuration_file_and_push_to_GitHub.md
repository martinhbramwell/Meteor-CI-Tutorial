---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI configuration file and push to GitHub

On the preliminary commit we did earlier, CircleCI recognized the project's existence but did not know what to do with it.  By logging in to CircleCi with our GitHub credentials, we authorize GitHub to reveal our projects to CircleCI.  By registering a GitHub project with CircleCI, CircleCI and GitHub establish between them a <a href="https://developer.github.com/webhooks/" target="_blank">"webhook"</a> that alerts CircleCI of events such as a new commit.

Now, we have a test runner, and by adding a ```circle.yml``` configuration file and committing the project to GitHub CircleCI will have all it needs to build and test our project.
#####Commands
```terminal
mv example_circle.yml circle.yml
git add packages circle.yml tests
git commit -am 'Added package and package testing'
git push -u origin master
```


<!-- Code for this begins at line #342-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L18" target="_blank">Code for this step.</a>] ]
]
