---
.left-column[
  ### Android Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare Android SDK (Part A)

<a href='http://developer.android.com/sdk/index.html' target='_blank'>Google's documentation</a> for building an APK (Android app PacKage) is enormous and aimed at GUI-users and Android Studio; while <a href='https://github.com/meteor/meteor/wiki/Mobile-Dev-Install:-Android-on-Linux' target='_blank'>Meteor's documentation</a> is, well ... skimpy.  Instead, we're doing continuous integration, so we need Google's <a href='http://developer.android.com/sdk/installing/index.html?pkg=tools' target='_blank'>'command-line-only' tools</a>. To get proficient at it, we also need to learn about <a href='https://circleci.com/docs/android' target='_blank'>the help</a> CircleCI provides, and have some understanding of <a href='https://cordova.apache.org/docs/en/latest/guide/overview/' target='_blank'>Cordova</a>.

Our immediate goal is to get going with the minimum necessary. The basic steps are :
 - get the main package: "Android SDK Tools"
 - set ANDROID_HOME
 - use the main package to install additional tools
 - add the paths of each additional tool to the main PATH so they can find each other.

The dependable path into it all is the ```android --help``` command. For example ```android --help list sdk``` helps you get info about available plugins. 

<!-- B -->]

