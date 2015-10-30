---
.left-column[
  ### Install Sublime Text 3 editor
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### This tutorial uses Sublime Text 3.

It also expects to be run in a virtual machine; for later destruction.  While you likely have your own preferred text editor, this will introduce the general idea of in-editor linting, which you can then adapt to your own taste.
 
Steps performed :
 - gets the <a href='https://en.wikipedia.org/wiki/Personal_Package_Archive' target='_blank'>PPA</a> for <a href='http://www.sublimetext.com/3' target='_blank'>Sublime Text 3</a>
 - installs it. 
 
If you just want to quickly follow the tutorial then *do* execute this group of commands, otherwise install your usual editor/IDE.  Slimetits ain't bad, tho'.
##### Commands
```terminal
add-apt-repository -y ppa:webupd8team/sublime-text-3
apt-get update
apt-get install -y sublime-text-installer
pip install -y beautifulsoup4 requests
```

<!-- Code for this begins at line #152 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part01_PrepareTheMachine.sh#L152" target="_blank">Code for this step.</a>] ]
]
