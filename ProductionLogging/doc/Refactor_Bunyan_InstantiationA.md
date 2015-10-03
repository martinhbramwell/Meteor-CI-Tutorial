---
.left-column[
  ### Refactor Bunyan (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part A)

<a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/logger.js" target="_blank">Download</a> the file ```'logger.js'``` that separates out Bunyan setup. When it is registered in ```package.js```, logs will be saved to a server-side file under ```/var/log/meteor```.
```javascript
const Bunyan = Npm.require('bunyan');
Logger = Bunyan.createLogger({
  'name': 'ci4meteor',
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


<!-- Code for this begins at line #46 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part07_ProductionLogging.sh#L46" target="_blank">Code for this step.</a>] ]
]
