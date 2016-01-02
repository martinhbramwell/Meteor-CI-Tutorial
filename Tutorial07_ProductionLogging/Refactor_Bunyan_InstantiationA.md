---
last_update: 2016-01-02
 .left-column[
  ### Refactor Bunyan (A)
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

#### Refactor Bunyan Instantiation (Part A)

<a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/logger.js" target="_blank">Download</a> the file ```'logger.js'``` that separates out Bunyan setup. When it is registered in ```package.js```, logs will be saved to a server-side file under ```/var/log/meteor```.
```javascript
const Bunyan = Npm.require('bunyan');
Logger = Bunyan.createLogger({
  'name': '${PKG_NAME}',          # EDIT <--
  'streams': [{
    'path': '/var/log/meteor/ci4meteor.log',
  }],
});
```
Remove Bunyan instantiation from ```'${PKG_NAME}-tests.js'```
```javascript
// const Bunyan = Npm.require('bunyan');
// const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    :
```

You'll get an error ```Logger is not defined```, however ...

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial07_ProductionLogging/ProductionLogging_functions.sh#L1" target="_blank">Code for this step.</a>] ]
]
