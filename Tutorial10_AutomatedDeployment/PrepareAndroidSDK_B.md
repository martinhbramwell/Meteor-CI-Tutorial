---
last_update: 2016-01-02
 .left-column[
  ### Android Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare Android SDK (Part B)

Since Cordova only recently <a href="https://cordova.apache.org/announcements/2015/11/09/cordova-android-5.0.0.html" target="_blank"> announced support for API Level 23</a>, we get <a href="http://developer.android.com/tools/sdk/tools-notes.html" target="_blank">SDK Tools, Revision 23.0.5</a>

The ```android update sdk``` command switch ```--filter``` expects an identifier of a single plugin.   We can get the list of identifier codes with the command... ```android list sdk -a -u --extended``` ...which shows identifiers, eg; *build-tools-23.0.1*. <font size="2">Note that the *numeric* identifiers are NOT reliable.</font>

```ruby
id: 4 or "build-tools-23.0.1"
     Type: BuildTool
     Desc: Android SDK Build-tools, revision 23.0.1
```


##### Example Commands
```ruby
wget -nc http://dl-ssl.google.com/android/repository/tools_r23.0.5-linux.zip
unzip ~/Downloads/tools_r23.0.5-linux.zip;
PATH=$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
android update sdk -u -a --filter <some plugin identifier> };
```
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L36" target="_blank">Code for this step.</a>] ]
]

