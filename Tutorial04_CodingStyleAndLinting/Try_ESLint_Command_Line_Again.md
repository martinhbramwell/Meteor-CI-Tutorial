---
last_update: 2016-05-26
 .left-column[
  ### Command Line ESLint
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

#### Test again for code-quality defects

Return to the command line and rerun . . . 
```terminal
eslint ~/${PARENT_DIR}/modules/${USER}/${MODULE_NAME}/${MODULE_NAME}-tests.js
```
. . . as you did for the earlier step ["Command Line ESLint"](#UseESLintOnTheCommandLine).

Great!  All clean!

**Note 2015/09/27** - The current version mishandles ```.eslintignore``` when there are symlinks, resulting in the false warning "File ignored because of your .eslintignore file. Use --no-ignore to override"
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L23" target="_blank">Code for this step.</a>] ]
]
