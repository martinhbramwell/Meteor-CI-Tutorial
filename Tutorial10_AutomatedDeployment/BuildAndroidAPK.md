---
.left-column[
  ### Android Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

####  Building the Android Package File

Building the APK requires five steps each time, and two preparatory steps the first time:
 0. Preparation
     - Use the JDK's ```keytool``` to create a key pair with which to sign your app package
     - add 'android' platform to your Meteor project
 1. Use Meteor's ```build``` command to build the APK, specifying the URI of the hosting server.
 2. Use the JDK's ```jarsigner``` command to claim ownership of the app and prevent impersonation
 3. Use Android SDK's ```zipalign``` command to maintain compatibility with the unzip utility in Android phones.
 4. Stuff the signed and aligned APK into the project's *./public* directory
 5. Add a single-line template with the download link.

When that's finished, we'll be ready to publish our web app to Meteor's servers . . .
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L126" target="_blank">Code for this step.</a>] ]
]
