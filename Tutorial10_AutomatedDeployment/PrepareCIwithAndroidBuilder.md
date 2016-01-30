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
