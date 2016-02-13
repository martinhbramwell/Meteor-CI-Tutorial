---
last_update: 2016-02-13
 .left-column[
  ### Refactor Bunyan (B)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continued.    Remove Bunyan instantiation from ```'${PKG_NAME}-tests.js'```
```javascript
// const Bunyan = Npm.require('bunyan');
// const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    :
```
Create a ```settings.json``` file in the project root directory :
```javascript
{   "LOGDIR": "/var/log/meteor/ci4meteor.log"  }
```

In future, to save logs to a server-side file under ```/var/log/meteor``` start Meteor with ```meteor --settings settings.json``` and to get prettified logs output on the command line you can use ```meteor --raw-logs | bunyan -o short```.

Unfortunately, however, as it is, we get a ```Logger is not defined``` error, because ```Logger``` must be 'wired' into our package...

<!-- B -->]
