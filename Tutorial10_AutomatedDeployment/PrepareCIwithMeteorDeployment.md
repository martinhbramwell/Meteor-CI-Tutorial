---
last_update: 2016-02-09
 .left-column[
  ### Final Deployment
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial10_AutomatedDeployment/AutomatedDeployment_functions.sh#L438" target="_blank">Code for this step.</a>] ]
]
