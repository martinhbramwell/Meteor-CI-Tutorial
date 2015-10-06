layout: false
.left-column[
  ### PART G Introduction

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Production Logging

In, 'Part06_CloudContinuousIntegration.sh' we got most of our intended toolkit functioning without actually doing any Meteor development.

The next step is mainly about the inner workings of packages, but the goal is to get rid of those pernicious ```console.log()``` statements.

We look at scaleable logging: run-time logs that track critical server-side activity at appropriate levels of detail.  "Bunyan" emits machine readable, JSON format logs that you can archive, for example in MongoDB, and analyze later for any kind of development, production or business purpose.

Now run ...
```terminal
./Part07_ProductionLogging.sh
```



<!-- B -->]
---
.left-column[
  ### Console.log is bad!
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Observe ordinary console logging.

Run the command ```meteor test-packages```. In a browser open [localhost:3000](http://localhost:3000/)

To the file ```packages/${PKG_NAME}/${PKG_NAME}-tests.js``` add the following
```javascript
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    test.equal(true, true);
    console.log('ººº Yoo Hoo ººº');              //  ADD! <--
});
```
then save it and observe the command line logs and the browser console.  Here we see one of the advantages of TinyTest in the browser: quickly seeing TDD results in a tight loop.

However, *esLint* rightfully flags ```console.log()``` as **a bad thing!**  Writing out text is the only feature it shares with serious logging tools.

<!-- B -->]
---
.left-column[
  ### NPM module
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add the NPM logger module Bunyan to your package.

Meteor supports 'npm' modules with the package NPM. 

Edit ```'${PKG_NAME}-tests.js'``` again adding :

```const Bunyan = require('bunyan');```

```javascript
/**
 * Tinytest unit tests
 * @namespace Tinytest
 */
const Bunyan = require('bunyan');  //  ADD! <--
```

... save, start up Meteor and observe the command line logs and the browser console. The NodeJS command on its own, **will not work**. We need ```require``` from the Npm package, so try ```const Bunyan = Npm.require('bunyan'); ```  instead.

We now need to fix ```"Error: Cannot find module 'bunyan'"!```



<!-- B -->]
---
.left-column[
  ### Specify Npm modules
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We have to specify every Npm requirement explicitly.

The Meteor package ```Npm``` preloads any NodeJS modules specified in a package.js file. To solve ```"Error: Cannot find module 'bunyan'"``` type errors we need to specify dependencies individually with ```Npm.depends({});```.

Add the indicated block to the file ```'package.js'```

```javascript
Package.onTest(function onTest(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}');
  api.addFiles('${PKG_NAME}-tests.js');
});

Npm.depends({
  'bunyan': '1.5.1',
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->
<div id="syntaxnote" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('syntaxnote'); return true;"
       href="javascript:HideContent('syntaxnote')">
        <p>Manual substitution :  you will need to replace ${GITHUB_ORGANIZATION_NAME} and ${PKG_NAME} with the names you actually use. </p><p>However, you will find that the substitutions are automated for you in the console output of ./Part07_ProductionLogging.sh</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('syntaxnote'); return true;"
    href="javascript:ReverseContentDisplay('syntaxnote')">
    <i>Hover Note</i>
</a>
]
---
.left-column[
  ### Server Only
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Bunyan is for Server Side Logging Only

You will have noticed that the client test results have gone, and the browser console shows ```'Npm' is not defined```.  NodeJS modules need extra packaging to run on the client.  With our focus on CI, we don't need that here.  We'll be testing server side only.  Let's make it explicit.

Edit the ```api.addFiles``` line in ```'package.js'``` to look like this :

```javascript
Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}');
  api.addFiles(['${PKG_NAME}-tests.js'], ['server']); // EDIT! <--
});    // Note the square brackets.   ᗑ ᗑ

Npm.depends({
  'bunyan': '1.5.1',
});
```
. . . save, and observe the command line logs and the browser console.. 

<!-- B -->]
---
.left-column[
  ### Add Bunyan Logging
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Now we can add logging

Edit ```'${PKG_NAME}-tests.js'``` again adding ```const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });``` and ```Logger.info('ººº Yoo Hoo ººº');``` as shown.

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });  //  ADD! <--

Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    Logger.info('ººº Yoo Hoo ººº');                           //  ADD! <--
    console.log('ººº Yoo Hoo ººº');
    test.equal(true, true);
});
```

   ... save, and observe the command line logs and the (empty!) browser console.

<!-- B -->]
---
.left-column[
  ### Goodbye Console
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We can get rid of the console altogether

Edit ```'${PKG_NAME}-tests.js'``` again and delete the line ```console.log('ººº Yoo Hoo ººº');```

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });

Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    Logger.info('ººº Yoo Hoo ººº');
//    console.log('ººº Yoo Hoo ººº');
    test.equal(true, true);
});
```
So, on the server-side, we now have much more control over logging <a href="https://github.com/trentm/node-bunyan#levels" target="_blank">levels</a> and <a href="https://github.com/trentm/node-bunyan#streams-introduction" target="_blank">output destinations</a>.

<!-- B -->]
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


<!-- Code for this begins at line #46 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part07_ProductionLogging.sh#L46" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Refactor Bunyan (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continuing ... we still need to 'wire' ```Logger``` into our package.

In ```package.js``` change this ...
```javascript
api.use('${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}');
api.addFiles(['${PKG_NAME}-tests.js'], ['server']);
```
... to look like this ...
```javascript
api.use('${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}');
api.addFiles(                   //  EDIT! <--
  ['logger.js', '${PKG_NAME}-tests.js'], ['server']
);
api.export('Logger'); // Order matters.  Export **after** adding
```
In a new terminal run, and watch this command when ...
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan
```
... the tests in ```http://localhost:3000/``` rerun.

<!-- B -->]
---
.left-column[
    ### End Of Part #G
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding seven parts completed our exploration of a complete development toolkit for Meteor (<a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/issues" target="_blank">Did we miss something?</a>).

You should now have linting, logging, automated documentation, unit testing, version control, end-to-end testing and continuous integration *in-the-cloud*.

Now we'll look at a more useful package in [Part #H - A Real World Package](./?part=H)



<!-- B -->]
