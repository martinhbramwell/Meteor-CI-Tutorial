---
name: TryJSDocFromTheCommandLinea
.left-column[
  ### Command Line jsDoc (Step #1)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line

In a directory you specify, JSDoc creates a documentation web site like this :
```ruby
yourself@YourVM:~/projects/yourproject$ tree -L 2 ./packages/${PKG_NAME}
./packages/yourpackage
├── docs
│   ├── files.html
│   ├── index.html
│   └── symbols
│       ├── _global_.html
│       └── src
├── package.js
      :  etc
      :  etc
```
##### Commands
```terminal
jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
tree -L 2 ./packages/${PKG_NAME}
```
continued ...
<!-- Code for this begins at line #455-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part05_AutomaticDocumentationInTheCloud.sh#L26" target="_blank">Code for this step.</a>] ]
]
