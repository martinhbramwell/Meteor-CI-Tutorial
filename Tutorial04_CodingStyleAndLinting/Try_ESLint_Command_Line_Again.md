---
.left-column[
  ### Command Line ESLint
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Test again for code-quality defects

Return to the command line and rerun . . . 
```terminal
eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
```
. . . as you did for the earlier step ["Command Line ESLint"](#UseESLintOnTheCommandLine).

Great!  All clean!

**Note 2015/09/27** - The current version mishandles ```.eslintignore``` when there are symlinks, resulting in the false warning "File ignored because of your .eslintignore file. Use --no-ignore to override"
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/modularize/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L12" target="_blank">Code for this step.</a>] ]
]
