---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line ESLint 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use ESLint on the Command Line

In a terminal session execute these commands:
```terminal
cd ~/projects/${PROJECT_NAME}/
eslint ./packages/yourpackage/yourpackage-tests.js
```

The result should look like this :
```ruby
packages/yourpackage/yourpackage-tests.js
 3:14 error   Strings must use doublequote                 quotes
 3:25 warning Missing function expression name             func-names
 3:33 error   Unexpected space before function parentheses space-before-function-paren

✖ 3 problems (2 errors, 1 warning)
```

<!-- B -->]
