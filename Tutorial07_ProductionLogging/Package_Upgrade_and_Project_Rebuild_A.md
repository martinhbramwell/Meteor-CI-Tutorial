---
last_update: 2016-02-13
 .left-column[
  ### Package Upgrade (A)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Package Upgrade and Project Rebuild (Part A)

To complete this section, we need to correctly commit our changes and spawn a rebuild in CircleCI.  In the following steps, we're going to see how to : 
1. Add ```logger.js``` and ```setting.json``` to git version control
1. Create a ```.gitignore``` file to keep Bunyan's generated module ```.npm``` out of version control
1. Increment the package version number
1. Update the app to pick up the version change
1. Commit the package
1. Commit the project

Continues . . . 

<!-- B -->]
