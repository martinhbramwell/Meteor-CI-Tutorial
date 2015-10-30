---
name: Check Meteor Works

.left-column[
  ### Check Meteor Works
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Check the meteor project will work

This script will now stop any currently running Meteor process and start a new one for ```${PROJECT_NAME}```, cleanly.

**When prompted**, test Meteor with this link in a browser, <a href='http://localhost:3000/' target='_blank'>http://localhost:3000/</a>

When you hit ```<Enter>```, to continue to the next step, Meteor will be killed automatically.

#####Commands
```terminal
A_METEOR_PID=$(ps aux | grep meteor | grep tools/main.js | awk '{print \$2}')
echo $A_METEOR_PID;
```

<!-- Code for this begins at line #120 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L120" target="_blank">Code for this step.</a>] ]
]
