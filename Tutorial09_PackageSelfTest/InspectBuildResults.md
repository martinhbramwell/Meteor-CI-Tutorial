---
last_update: 2016-01-04
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

#### Inspect Build Results

Because we created an "API Token" at the start of Section 6 we have the capability to monitor build execution from our development machine.

In this case we will check on the status of the build every 30 seconds, then when it is no longer running we get the build number.  We request the list of artifacts for that specific build and then search the list for the URLs of the artifacts that interest us.

##### Example Commands

```ruby
BUILD_STATUS=$( curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json"  | jq '.[0].status' );
BUILD_NUM=$(curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}?circle-token=${CIRCLECI_PERSONAL_TOKEN}  -H "Accept: application/json"  | jq '.[0].build_num');
NGHTWTCH_RESULT_URL=$(cat /tmp/circleci_artifacts.json | jq '.[] | .url' | grep 'result.json');
wget -qO- ${NGHTWTCH_RESULT_URL//\"/} | bunyan -o short;

```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L257" target="_blank">Code for this step.</a>]  ]
]
