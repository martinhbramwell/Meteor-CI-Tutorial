---
layout: false
last_update: 2016-02-09
 .left-column[
  ### Java required
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

#### Java 7 is required by Nightwatch
Java 7 is required by Selenium, which is required by Nightwatch.  Selenium seems to hold the strategic high ground when it comes to remote control of web applications.  Moreover, the Android SDK specifies Oracle JDK, so like it or not, you gotta install Oracle's Java.  Steps performed :
 - Gets the <a href="https://en.wikipedia.org/wiki/Personal_Package_Archive" target="_blank">PPA</a> for <a href="http://www.oracle.com/technetwork/indexes/downloads/index.html?ssSourceSiteId=ocomen" target="_blank">Oracle Java</a>
 - installs it

**Legal Notice** : Normally, the PPA installer will prompt you to accept Oracle's license.  If you run this step . . . **you accept the license agreement, implicitly!**

##### Example Commands
```terminal
  sudo add-apt-repository -y ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get -y install oracle-java7-installer
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L149" target="_blank">Code for this step.</a>] ]
]
