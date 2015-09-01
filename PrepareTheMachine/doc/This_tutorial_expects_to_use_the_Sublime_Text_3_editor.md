---
.left-column[
  ### Install Sublime Text 3 editor. 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### This tutorial uses Sublime Text 3.

It also expects to be run in a virtual machine; for later destruction.  You most likely have your own preferred test editor.  This will show the general principle of simultaneous editor and CI linting.
 
Steps performed :
 - gets the [PPA](https://en.wikipedia.org/wiki/Personal_Package_Archive) for [Sublime Text 3](http://www.sublimetext.com/3)
 - installs it. 
 
If you just want to quickly follow the tutorial then *do* execute this group of commands, otherwise install your usual editor/IDE.  Slimetits ain't bad, tho'.
##### Commands
```terminal
  add-apt-repository -y ppa:webupd8team/sublime-text-3
  apt-get update
  apt-get install -y sublime-text-installer
  pip install -y beautifulsoup4 requests
```

<!-- Code for this begins at line #129-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#129" target="_blank">Code for this step.</a>] ]
]
