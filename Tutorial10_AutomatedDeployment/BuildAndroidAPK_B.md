---

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

####  Building the Android Package File (Part B)

With the preparatory steps done we can address the steps to take each time the app is changed :

 1. Use Meteor's <a href="http://docs.meteor.com/#/full/meteorbuild" target="_blank">build</a> command to build the APK, specifying the URI of the hosting server.
 2. Use the JDK's <a href="http://www.wewerehere.my/how-to-sign-and-verified-apk-file-to-google-store/" target="_blank">jarsigner</a> command to claim ownership of the app and prevent impersonation
 3. Use Android SDK's <a href="http://developer.android.com/tools/help/zipalign.html" target="_blank">zipalign</a> command to maintain compatibility with the unzip utility in Android phones.
 4. Stuff the signed and aligned APK into the project's *./public* directory

With that finished, we're ready to submit our app to Meteor's servers . . .
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L175" target="_blank">Code for this step.</a>] ]
]
