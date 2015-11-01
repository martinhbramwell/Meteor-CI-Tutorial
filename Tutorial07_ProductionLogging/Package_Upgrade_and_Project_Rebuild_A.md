---
.left-column[
  ### Package Upgrade (A)
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Package Upgrade and Project Rebuild (Part A)

... continuing ... 

Rerun the tests while watching a ```tail``` of the log file.
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan -o short
```

To complete this section, we need to correctly commit our changes and spawn a rebuild in CircleCI.  In the following steps, we're going to see how to : 
1. Add ```logger.js``` to git version control
1. Create a ```.gitignore``` file to keep Bunyan's generated module ```.npm``` out of version control
1. Increment the package version number
1. Update the app to pick up the version change
1. Commit the package
1. Commit the project

Continues . . . 

<!-- Code for this begins at line #75 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part07_ProductionLogging.sh#L75" target="_blank">Code for this step.</a>] ]
]
