---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line ESLint 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use ESLint on the Command Line

We are ready with ESLint for the command line, and will have it for Sublime Text.  Both have advantages: the command line lists all code quality deficiencies which we need for continuous integration and editor based linting helps ensure code quality as we type.

The result should look like this :
```ruby
packages/yourpackage/yourpackage-tests.js
 3:14 error   Strings must use doublequote                 quotes
 3:25 warning Missing function expression name             func-names
 3:33 error   Unexpected space before function parentheses space-before-function-paren

✖ 3 problems (2 errors, 1 warning)
```
##### Commands
```terminal
cd ~/projects/${PROJECT_NAME}/
eslint ./packages/yourpackage/yourpackage-tests.js
```

<!-- Code for this begins at line #414-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L415" target="_blank">Code for this step.</a>] ]
]
