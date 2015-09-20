---
layout: false
.left-column[
  ### Java required
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Java 7 is required by Nightwatch. 
Java 7 is required by Selenium which is required by Nightwatch.  Selenium seems to hold the strategic high ground when it comes to testing web applications, so like it, or not, you gotta install Java.

Steps performed :
 - Gets the <a href="https://en.wikipedia.org/wiki/Personal_Package_Archive" target="_blank">PPA</a> for <a href="http://www.oracle.com/technetwork/indexes/downloads/index.html?ssSourceSiteId=ocomen" target="_blank">Oracle Java</a>
 - installs it

**Legal Notice** : Normally, the PPA installer will prompt you to accept Oracle's license.  If you run this step . . . **you accept the license agreement, implicitly!**

##### Commands
```terminal
  add-apt-repository -y ppa:webupd8team/java
  apt-get update
  apt-get -y install oracle-java7-installer
```
<!-- Code for this begins at line #57 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part01_PrepareTheMachine.sh#L57" target="_blank">Code for this step.</a>] ]
]
