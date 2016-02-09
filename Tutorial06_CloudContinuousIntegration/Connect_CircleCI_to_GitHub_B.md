---
last_update: 2016-02-05
 .left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Connect CircleCI to GitHub (Part B)

. . . continuing.


Our initial build readies us to do two important things :

1. *Obtain an <a href="https://circleci.com/docs/api#getting-started" target="_blank">API Token</a> so we can automate our interactions with CircleCI*  : Open the page <a href="https://circleci.com/account/api" target="_blank">API Tokens</a>, invent a name for the token (eg; who will use it), and click *Create*.  The named token will remain available on that page, any time you need it.

2. *Authorize our ```circle.yml``` scripts to write back into GitHub, with a <a href="https://circleci.com/docs/github-security-ssh-keys" target="_blank">User Checkout Key</a>* : To push changes back to GitHub you must get a *User Key* from : <div style='word-wrap:break-word;'><a href="https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout" target="_blank">https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout</a></div>

Our next task is to commit/push '```circle.yml```', a build definition file.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L267" target="_blank">Code for this step.</a>] ]
]
