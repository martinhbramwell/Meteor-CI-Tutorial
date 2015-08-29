---
name: Check Meteor Works

.left-column[
  ### Check Meteor Works
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Check the meteor project will work

If Meteor is not already running, it will start up ```${PROJECT_NAME}``` now.

If Meteor IS already running, you will need to stop it.

**When prompted**, test meteor in a browser.

[http://localhost:3000/](http://localhost:3000/)

When you continue to the next step Meteor will be killed automatically.
#####Commands
```terminal
A_METEOR_PID=$(ps aux | grep meteor | grep tools/main.js | awk '{print $2}')
echo $A_METEOR_PID
```

<!-- -->]
