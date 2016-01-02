---
last_update: 2015-12-18
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

We create a ```tools/android``` directory to hold them, and we call them at the right time from our ```circle.yml``` file.  We also create an *ANDROID_HOME* environment variable, in the ```machine: >> environment:``` section (<a href="https://circleci.com/docs/configuration#environment" target="_blank">as explained in the documentation</a>).

##### Example Commands
```ruby
cd ${PROJECT_NAME}/tools/android >/dev/null;
https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/MobileCI/android/install-android-dependencies.sh;
```

Continued . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L314" target="_blank">Code for this step.</a>] ]
]
