---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line jsDoc (Step #1)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line

In a terminal session execute these commands:
```terminal
cd ~/projects/${PROJECT_NAME}/
jsdoc -d=./packages/skeleton/doc ./packages/skeleton
tree -L 3 ./packages/skeleton
```
The result should look like this :
```ruby
yourself@YourVM:~/projects/yourProj$ tree -L 3 ./packages/skeleton
./packages/skeleton
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
continued ...
<!-- B -->]
