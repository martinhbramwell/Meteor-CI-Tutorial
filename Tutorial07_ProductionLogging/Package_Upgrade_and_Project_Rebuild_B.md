---
.left-column[
  ### Package Upgrade (B)
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Package Upgrade and Project Rebuild (Part B)

Simply committing the changes we made to the package will not change the containing project and so there'll be no rebuild in CircleCI.  However, the command, ```meteor list```, does more than list packages, it reads ```package.js``` files and updates project information accordingly. If we change our package version number and run ```meteor list``` it will update ```.meteor/versions```.  **That** we can commit, and committing will spawn a rebuild.
##### Example Commands
```terminal
echo ".npm" >> .gitignore
git add .gitignore, logger.js
sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js # Increment version number
meteor list
```
To finish: commit the package, then commit the project and then watch CircleCI for rebuild success.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/modularize/Tutorial07_ProductionLogging/ProductionLogging_functions.sh#L30" target="_blank">Code for this step.</a>] ]
]
