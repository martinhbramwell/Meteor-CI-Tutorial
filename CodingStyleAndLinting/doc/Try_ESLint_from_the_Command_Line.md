---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line ESLint 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use ESLint on the Command Line

We installed command line ESLint in the first part, and will have it for Sublime Text momentarily.  Both have advantages: editor based linting helps ensure code quality as we type while command line catches quality issues during continuous integration.  A command line result looks like this :
```ruby
/home/yourself/demos/yourproject/yourproject.js
   3:22  error    Strings must use doublequote                  quotes
   6:14  warning  Missing function expression name              func-names
           :        :                :                            :
  20:26  error    Unexpected space before function parentheses  space-before-function-paren

✖ 13 problems (10 errors, 3 warnings)
```
##### Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/
eslint ${PROJECT_NAME}.js
```

<!-- Code for this begins at line #25 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part04_CodingStyleAndLinting.sh#L25" target="_blank">Code for this step.</a>] ]
]
