layout: false
.left-column[
  ### PART J Introduction

.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Automated Deployment

In this final section of the current version of this tutorial series, we learn about deploying a Meteor application, including building for Android and, *for simplicity*, serving it out of the web hosted application. The volatility of Google's procedures for serving the app from the *Play Store* will quickly make obsolete anything we'd show here, so we won't go into it. 

We use our understanding of manual deployment to complete our CI script to do it all automatically in CircleCI, every time we push a commit to GitHub.

Get started now by running ...
```terminal
./Tutorial10_AutomatedDeployment.sh
```



<!-- B -->]
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

---
.left-column[
  ### Android Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
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
---
.left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Deploy To Meteor Servers

The Meteor tutorial introduces <a href="https://www.meteor.com/tutorials/blaze/deploying-your-app" target="_blank">deployment to Meteor's servers</a> while the reference docs explain in more detail the <a href="http://docs.meteor.com/#/full/meteordeploy" target="_blank">deploy</a> command and the command to <a href="http://docs.meteor.com/#/full/meteorlogs" target="_blank">download a site's log files</a>. To see the others, try: ```meteor <command> --help```, where ```<command>``` is one of ```login```, ```whoami```, ```authorized```, ```logout```, ```claim```, ```list-sites``` as well as ```deploy``` and ```logs```.

**Note** that your Meteor login status survives a reboot of your workstation! Only ```meteor logout``` changes it.

Fow now, as a preliminary step towards deploying automatically from CircleCI, we simply log in and deploy, in order to be sure it all works.

##### Example Commands
```ruby
meteor login;
meteor deploy ${PROJECT_NAME}-${GITHUB_ORGANIZATION_NAME}.meteor.com
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L301" target="_blank">Code for this step.</a>]  ]
]
---
.left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare CircleCI with Android SDK

The next few steps involve additions to our ```circle.yml``` file; in particular a new <a href="https://circleci.com/docs/configuration#deployment" target="_blank">deployment section</a> that CircleCI will only execute if all tests pass. As previously, to keep a clean, readable ```circle.yml``` file we encapsulate most of the work in several bash scripts: <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/install-android-dependencies.sh" target="_blank">install-android-dependencies.sh</a> and <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/build-android-apk.sh" target="_blank">build-android-apk.sh</a>.

We create a ```tools/android``` directory to hold them, and we call them at the right time from our ```circle.yml``` file.  We also create an *ANDROID_HOME* environment variable, in the ```machine: >> environment:``` section (<a href="https://circleci.com/docs/configuration#environment" target="_blank">as explained in the documentation</a>).

##### Example Commands
```ruby
cd ${PROJECT_NAME}/tools/android >/dev/null;
https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/install-android-dependencies.sh;
```

Continued . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L314" target="_blank">Code for this step.</a>]  ]
]
---
.left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare CircleCI with Android Builder

Exposing the *ANDROID_HOME* variable in the build script poses no risks, but we **do** need to deliver secrets to the build if we want to sign our app package or log in to Meteor's servers.  CircleCI allows <a href="https://circleci.com/docs/environment-variables" target="_blank">private variables</a> to be created for each project <a href="https://circleci.com/docs/api#add-environment-variable" target="_blank">via the REST API</a> or on line by the logged in owner.


In this step we append a new ```deployment``` section to our ```circle.yml``` with a call to ```build-android-apk.sh```, as documented <a href="https://circleci.com/docs/configuration#deployment" target="_blank">here</a>.

##### Example Commands
```ruby
export VAR_JSON='{"name":"KEYSTORE_PWD", "value":"${KEYSTORE_PWD}"}';
curl -s -X POST -d ${VAR_JSON} https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/envvar?circle-token=${CIRCLECI_PERSONAL_TOKEN} --header "Content-Type: application/json";
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L394" target="_blank">Code for this step.</a>]  ]
]
---
.left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare Circle CI with Meteor Deployment

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L428" target="_blank">Code for this step.</a>]  ]
]
---
.left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Final Changes

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L476" target="_blank">Code for this step.</a>]  ]
]
---
.left-column[
    ### End Of Part #F
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you!



<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L294" target="_blank">Code for this step.</a>] ]
]
