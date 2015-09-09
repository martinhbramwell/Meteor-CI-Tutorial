---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line jsDoc (Step #1)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line

JSDoc creates a documentation web site, in a directory you specify, like this :
```ruby
yourself@YourVM:~/projects/yourProj$ tree -L 3 ./packages/yourpackage
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
jsdoc -d=./packages/yourpackage/docs ./packages/yourpackage
tree -L 3 ./packages/yourpackage
```
continued ...
<!-- B -->]
