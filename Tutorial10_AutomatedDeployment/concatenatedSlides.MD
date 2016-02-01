layout: false
last_update: 2016-01-02
 .left-column[
  ### PART J Introduction

.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
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

#### Prepare Android SDK (Part A)

<a href='http://developer.android.com/sdk/index.html' target='_blank'>Google's documentation</a> for building an APK (Android app PacKage) is enormous and aimed at GUI-users and Android Studio; while <a href='https://github.com/meteor/meteor/wiki/Mobile-Dev-Install:-Android-on-Linux' target='_blank'>Meteor's documentation</a> is, well ... skimpy. We on the other hand, doing continuous integration, need Google's <a href='http://developer.android.com/sdk/installing/index.html?pkg=tools' target='_blank'>'command-line-only' tools</a>. To get proficient, we also need to learn about <a href='https://circleci.com/docs/android' target='_blank'>the help CircleCI provides</a>, and be aware of <a href='https://cordova.apache.org/docs/en/latest/guide/overview/' target='_blank'>Cordova</a>.

Our immediate goal is to get going with the minimum necessary. The basic steps are :
 - get the main package: "Android SDK Tools"
 - set ANDROID_HOME
 - use the main package to install additional tools
 - add the paths of each additional tool to the main PATH so they can find each other.

The best way to get dependable documentation is ```android --help```. For example ```android --help list sdk``` helps you get info about available plugins.

<!-- B -->]

---
last_update: 2016-01-05
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L178" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-24
 .left-column[
  ### Final Deployment
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

#### Deploy To Meteor Servers

The Meteor tutorial introduces <a href="https://www.meteor.com/tutorials/blaze/deploying-your-app" target="_blank">deployment to Meteor's servers</a> while the reference docs explain in more detail the <a href="http://docs.meteor.com/#/full/meteordeploy" target="_blank">deploy</a> command and the command to <a href="http://docs.meteor.com/#/full/meteorlogs" target="_blank">download a site's log files</a>. To see the others, try: ```meteor <command> --help```, where ```<command>``` is one of ```login```, ```whoami```, ```authorized```, ```logout```, ```claim```, ```list-sites``` as well as ```deploy``` and ```logs```.

**Note** that your Meteor login status survives a reboot of your workstation! Only ```meteor logout``` changes it.

For now, as a preliminary step towards deploying automatically from CircleCI, we simply log in and deploy, in order to be sure it all works.

##### Example Commands
```ruby
meteor login;
meteor deploy ${PROJECT_NAME}-${GITHUB_ORGANIZATION_NAME}.meteor.com
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L300" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-24
 .left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare CircleCI with Android SDK

The next few steps involve additions to our ```circle.yml``` file; in particular a new <a href="https://circleci.com/docs/configuration#deployment" target="_blank">deployment section</a> that CircleCI will only execute if all tests pass. As previously, to keep a clean, readable ```circle.yml``` file we encapsulate most of the work in several bash scripts: <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/install-android-dependencies.sh" target="_blank">install-android-dependencies.sh</a> and <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/build-android-apk.sh" target="_blank">build-android-apk.sh</a>.

We create a ```tools/android``` directory to hold them, and we call them at the right time from our ```circle.yml``` file.

##### Example Commands
```ruby
cd ${PROJECT_NAME}/tools/android >/dev/null;
https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/install-android-dependencies.sh;
```

Continued . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L313" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-30
 .left-column[
  ### Final Deployment
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare CircleCI with Android Builder

The ```machine:  >>  environment:``` section in circle.yml files is okay for non-sensitive variables, but we **must** be able to deliver secrets to the build, if we want to sign our app package or log in to Meteor's servers.  CircleCI allows <a href="https://circleci.com/docs/environment-variables" target="_blank">private variables</a> to be created for each project <a href="https://circleci.com/docs/api#add-environment-variable" target="_blank">via the REST API</a> or on line by the logged in owner.


In this step we append a new ```deployment``` section to our ```circle.yml``` with a call to ```build-android-apk.sh```, as documented <a href="https://circleci.com/docs/configuration#deployment" target="_blank">here</a>.

##### Example Commands
```ruby
export VAR_JSON='{"name":"KEYSTORE_PWD", "value":"${KEYSTORE_PWD}"}';
curl -s -X POST -d ${VAR_JSON} https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/envvar?circle-token=${CIRCLECI_PERSONAL_TOKEN} --header "Content-Type: application/json";
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L389" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-30
 .left-column[
  ### Final Deployment
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

#### Prepare Circle CI with Meteor Deployment

You need to be logged into Meteor's servers to deploy to them.  In this step we bring in two scripts that do this: <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/meteor/meteorAutoLogin.exp" target="_blank">meteorAutoLogin.exp</a> and <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/meteor/deploy-to-server.sh" target="_blank">deploy-to-server.sh</a>.  ```meteorAutoLogin.exp``` is not a shell script, it is an ```expect``` script, that handles Meteor's log in sequence using secret variables we write our CircleCI project settings.

To our ```circle.yml``` we add a call to load and run the procedure ```DeployToMeteorServer``` and an environment variable,required by the script, for the Meteor URL : ```TARGET_SERVER_URL:```.

##### Example Commands
```terminal
export HEADER_JSON="--header \"Content-Type: application/json\"";
export VAR_JSON="'{\"name\":\"METEOR_UID\", \"value\":\"${METEOR_UID}\"}'";
eval curl -s -X POST ${HEADER_JSON} -d ${VAR_JSON} https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/envvar?circle-token=${CIRCLECI_PERSONAL_TOKEN};
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L433" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-01
 .left-column[
  ### One Last Thing
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

#### Show Status Symbol

The presence or lack of build status badges on the main README pages of project repositories testify to their level of development sophistication.

Our nest task is to get a CircleCI ```fail``` <img src='./fragments/failing.svg' /> or ```pass``` <img src='./fragments/passing.svg' /> badge on the README.md file of our package.  Even though we build the umbrella project that contains our package, not the package itself, we can still put the project status badge on the package README.

To show it works, we'll deliberately fail a test, and see what happens to the badge.  We'll fix it before we run our final build and deploy.

##### Example Commands
```http
Build by [CircleCI](https://circleci.com) :: [![Circle CI](https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.svg?style=shield)](https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME})
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L485" target="_blank">Code for this step.</a>] ]
]
---

 .left-column[
  ### One Last Thing
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

#### Version Monitor Template

Every piece of software needs to be able to report its version.  To do this in a simple way, we modify one file and add three more to our package: 
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/versionMonitor.html" target="_blank">versionMonitor.html</a> A Meteor (SpaceBars) template containing links to the main project artifact versions.
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/versionMonitor.js" target="_blank">versionMonitor.js</a> A helper script that delivers the version information for the template.
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/versionMonitor.sh" target="_blank">versionMonitor.sh</a> A build time shell script that patches versioning information into the helper script
 - <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/perform_ci_tasks_T10_10.sh" target="_blank">perform_ci_tasks.sh</a> We modify this file adding one new command to the existing three to be performed when it is our package's turn in the build process :

##### Example Commands
```terminal
source ./tools/versionMonitor.sh;
PatchVersionMonitorHelper;
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L506" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-01
 .left-column[
  ### Final Deployment
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

#### Push Final Changes

Our final operation is simple: add our latest files to our local ```git``` repository and commit everything to GitHub.  GitHub will trigger CircleCI's web hook and CircleCI will then pull and rerun the build, test and deploy sequence.

**Tip** :  Suppose you want to commit some documentation changes without triggering the web hook.  How would you do it?  CircleCI provides for a ```[ci skip]``` annotation in commit messages.  The commit shown below will NOT trigger a build due to the presence of that flag.

##### Example Commands
```terminal
git add ./tools
git commit -am "Added support and scripts for Android APK build and Meteor deploy, but [ci skip]";
git push;
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L554" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-26
 .left-column[
    ### End Of Part #J
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you for following this tutorial!

Please watch for the **bonus video**, coming soon, that shows how to avoid the slow Android emulator and debug directly in an <a href="http://www.android-x86.org/" target="_blank">Android x86</a> guest OS in a <a href="http://wiki.qemu.org/KVM" target="_blank">Qemu/KVM</a> virtual machine at equivalent speed to debugging in a physical device.


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L293" target="_blank">Code for this step.</a>] ]
]
