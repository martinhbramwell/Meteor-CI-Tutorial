---
name: UseESLintOnTheCommandLine
last_update: 2016-02-09
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

#### Use ESLint on the Command Line

We installed command line ESLint in the first part, and will have it for Sublime Text momentarily.  Both have advantages: editor based linting helps ensure code quality as we type, while command line linting catches quality issues during continuous deployment.  A command line result looks like this :
```ruby
/home/yourself/demos/yourproject/yourproject.js
   3:22  error    Strings must use doublequote                  quotes
   6:14  warning  Missing function expression name              func-names
           :        :                :                            :
  20:26  error    Unexpected space before function parentheses  space-before-function-paren

✖ 13 problems (10 errors, 3 warnings)
```
##### Example Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/
eslint ${PROJECT_NAME}.js
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L1" target="_blank">Code for this step.</a>] ]
]
