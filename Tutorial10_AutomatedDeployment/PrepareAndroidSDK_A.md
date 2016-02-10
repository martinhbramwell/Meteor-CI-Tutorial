---
last_update: 2016-02-09
 .left-column[
  ### Android Deployment
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

#### Prepare Android SDK (Part A)

<a href='http://developer.android.com/sdk/index.html' target='_blank'>Google's documentation</a> for building an APK (Android app PacKage) is enormous and aimed at GUI-users and Android Studio; while <a href='https://github.com/meteor/meteor/wiki/Mobile-Dev-Install:-Android-on-Linux' target='_blank'>Meteor's documentation</a> is, well ... skimpy. We on the other hand, doing continuous deployment, need Google's <a href='http://developer.android.com/sdk/installing/index.html?pkg=tools' target='_blank'>'command-line-only' tools</a>. To get proficient, we also need to learn about <a href='https://circleci.com/docs/android' target='_blank'>the help CircleCI provides</a>, and be aware of <a href='https://cordova.apache.org/docs/en/latest/guide/overview/' target='_blank'>Cordova</a>.

Our immediate goal is to get going with the minimum necessary. The basic steps are :
 - get the main package: "Android SDK Tools"
 - set ANDROID_HOME
 - use the main package to install additional tools
 - add the paths of each additional tool to the main PATH so they can find each other.

The best way to get dependable documentation is ```android --help```. For example ```android --help list sdk``` helps you get info about available plugins.

<!-- B -->]

