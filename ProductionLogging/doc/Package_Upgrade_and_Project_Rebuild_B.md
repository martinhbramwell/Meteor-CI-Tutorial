---
.left-column[
  ### Package Upgrade (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Package Upgrade and Project Rebuild (Part B)

Simply committing the changes we made to the package will not change the containing project and so there'll be no rebuild in CircleCI.  However, the command, ```meteor list```, does more than list packages, it reads ```package.js``` files and updates project information accordingly. If we change our package version number and run ```meteor list``` it will update ```.meteor/versions```.  **That** we can commit, and committing will spawn a rebuild.
##### Commands
```terminal
echo ".npm" >> .gitignore
git add .gitignore, logger.js
sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js # Increment version number
meteor list
```
To finish: commit the package, then commit the project and then watch CircleCI for rebuild success.

<!-- Code for this begins at line #80 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part07_ProductionLogging.sh#L80" target="_blank">Code for this step.</a>] ]
]
