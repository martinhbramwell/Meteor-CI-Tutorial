---
last_update: 2016-02-05
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

####  Building the Android Package File (Part A)

Building the APK requires four steps each time, with three preparatory steps the first time:

1. Use the JDK's <a href="https://coronalabs.com/blog/2014/08/26/tutorial-understanding-android-app-signing/" target="_blank">keytool</a> to create a key pair with which to sign your app package
2. Add 'android' platform to your Meteor project
3. Add a template with the download link.

Fortunately Meteor's ```isCordova``` attribute makes it very easy to avoid the embarrassment of a mobile app displaying a download link for itself.  Adding the template file <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/getAPK.html" target="_blank">getAPK.html</a> and its helper <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/getAPK.js" target="_blank">getAPK.js</a>, to the project root directory is all that's required.  Don't forget to specify the APK's name in the template file.

```javascript
{{#unless isMobile}}
  ≺a target='_blank' href='./${PROJECT_NAME}.apk'≻
    Download the Android app.
       :
```

Continued . . .

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L127" target="_blank">Code for this step.</a>] ]
]
