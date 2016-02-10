---
last_update: 2016-02-09
 .left-column[
  ### Refactor Bunyan (A)
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

#### Refactor Bunyan Instantiation (Part A)

The file <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/logger.js" target="_blank">logger.js</a> separates Bunyan setup from our tests.

```javascript
const Bunyan = Npm.require('bunyan'); // !
LoggerSpec = {  'name': '${PKG_NAME}'  }  //  <--  FIXME !!
if ( Meteor.settings.LOGDIR && Meteor.settings.LOGDIR.length > 0 ) {
  LoggerSpec.streams = [{'path': Meteor.settings.LOGDIR,}];
};
Logger = Bunyan.createLogger(LoggerSpec);
```
There is a lot going on here.  We create a Logger, but only specify a name (to distinguish it from loggers of other packages).  It writes to ```stdout``` **unless** our application specifies a LOGDIR in <a href="https://themeteorchef.com/snippets/making-use-of-settings-json/" target="_blank">Meteor.settings</a>.

For it to work, we must: get rid of our previous ```Logger``` instantiation, create a ```settings.json``` file and, finally, register <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/logger.js" target="_blank">logger.js</a> in ```package.js```.

Continuing . . .

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial07_ProductionLogging/ProductionLogging_functions.sh#L1" target="_blank">Code for this step.</a>] ]
]
