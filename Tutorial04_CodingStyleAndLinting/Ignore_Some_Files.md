---
last_update: 2016-01-02
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
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Ignore Files

It's worth mentioning how to skip files that esLint should not process.

If esLint finds an ```.eslintignore``` file in the current directory it will not analyze any files or descend into any directories listed in the file.

In later parts of this tutorial we'll have additional files, some of which should not be processed.  We might as well mask them off now . . . 

##### Example commands

```terminal
echo "./docs" > .eslintignore
echo "./backup" >> .eslintignore
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L12" target="_blank">Code for this step.</a>] ]
]
