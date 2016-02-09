---
last_update: 2016-01-24
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
