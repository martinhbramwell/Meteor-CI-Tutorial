layout: false
last_update: 2016-02-09
 .left-column[
  ### PART G Introduction

.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Production Logging

In, 'Tutorial06_CloudContinuousIntegration.sh' we got most of our intended toolkit functioning without actually doing any Meteor development.

The next step is mainly about the inner workings of packages, but the goal is to get rid of those pernicious ```console.log()``` statements.

We look at scaleable logging: run-time logs that track critical server-side activity at appropriate levels of detail.  "Bunyan" emits machine readable, JSON format logs that you can archive, for example in MongoDB, and analyze later for any kind of development, production or business purpose.

Now run ...
```terminal
./Tutorial07_ProductionLogging.sh
```



<!-- B -->]
---
last_update: 2016-02-09
 .left-column[
  ### Console.log is bad!
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

#### Observe ordinary console logging.

In our project directory, run the command ```meteor test-packages```, and then in a browser open [localhost:3000](http://localhost:3000/)

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
last_update: 2016-02-09
 .left-column[
  ### NPM module
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

#### Add the NPM logger module Bunyan to your package.

Meteor supports 'npm' modules with the package ```Npm```.

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
last_update: 2016-02-09
 .left-column[
  ### Specify Npm modules
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

#### We have to specify every Npm requirement explicitly.

The Meteor package ```Npm``` preloads any NodeJS modules specified in a package.js file. To solve ```"Error: Cannot find module 'bunyan'"``` type errors we need to specify dependencies individually with ```Npm.depends({});```.

Add the indicated block to the file ```'package.js'```

```javascript
Package.onTest(function onTest(api) {
  api.use('ecmascript');
  api.use('tinytest');
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
        <p>Manual substitution :  you will need to replace ${PKG_NAME} with the name you actually use. </p><p>However, you will find that the substitutions are automated for you in the console output of ./Part07_ProductionLogging.sh</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('syntaxnote'); return true;"
    href="javascript:ReverseContentDisplay('syntaxnote')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note</i>
</a>
]
---
last_update: 2016-02-09
 .left-column[
  ### Server Only
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

#### Bunyan is for Server Side Logging Only

You will have noticed that the client test results have gone, and the browser console shows ```'Npm' is not defined```.  NodeJS modules need extra packaging to run on the client.  With our focus on CI, we don't need that here.  We'll be testing server side only.  Let's make it explicit.

Edit the ```api.addFiles``` line in ```'package.js'``` to look like this :

```javascript
Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.addFiles(['${PKG_NAME}-tests.js'], ['server']); // EDIT! <--
});    // Note the square brackets.   ᗑ ᗑ

Npm.depends({
  'bunyan': '1.5.1',
});
```
. . . save, and observe the command line logs and the browser console.. 

<!-- B -->]
---
last_update: 2016-02-09
 .left-column[
  ### Add Bunyan Logging
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
last_update: 2016-02-09
 .left-column[
  ### Goodbye Console
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

Our output destination will depend on the execution environment. In our CI script we redirect log output to ```${CIRCLE_TEST_REPORTS}```, while for production it should go to a file.  We will now see how to specify the destination at run time.


<!-- B -->]
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
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

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
---
last_update: 2016-02-09
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
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

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

To save logs to a server-side file under ```/var/log/meteor``` start Meteor with ```meteor --settings settings.json```.  To get prettified logs output on the command line you can use ```meteor --raw-logs | bunyan -o short```.

Unfortunately, left as is, we get a ```Logger is not defined``` error, because ```Logger``` must be 'wired' into our package... 

<!-- B -->]
---
last_update: 2016-02-09
 .left-column[
  ### Refactor Bunyan (C)
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

#### Refactor Bunyan Instantiation (Part C)

In ```package.js```, in **both** the ```onUse``` **and** the ```onTest``` sections, the "api" must add ```logger.js``` and export ```Logger```.
```javascript
Package.onUse(function(api) {
       :
  api.addFiles(['logger.js', '${PKG_NAME}.js'], ['server']);
  api.export('Logger');
});
``` 
```javascript
Package.onTest(function(api) {
       :
  api.addFiles(['logger.js', '${PKG_NAME}-tests.js'], ['server']);
  api.export('Logger');
});
```
Rerun the tests while watching a ```tail``` of the log file.
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan -o short
```


<!-- B -->]
---
last_update: 2016-02-09
 .left-column[
  ### Package Upgrade (A)
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

#### Package Upgrade and Project Rebuild (Part A)

To complete this section, we need to correctly commit our changes and spawn a rebuild in CircleCI.  In the following steps, we're going to see how to : 
1. Add ```logger.js``` and ```setting.json``` to git version control
1. Create a ```.gitignore``` file to keep Bunyan's generated module ```.npm``` out of version control
1. Increment the package version number
1. Update the app to pick up the version change
1. Commit the package
1. Commit the project

Continues . . . 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial07_ProductionLogging/ProductionLogging_functions.sh#L45" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-09
 .left-column[
  ### Package Upgrade (B)
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

#### Package Upgrade and Project Rebuild (Part B)

Simply committing the changes we made to the package will not change the containing project and so there'll be no rebuild in CircleCI.  However, the command, ```meteor list```, does more than list packages, it reads ```package.js``` files and updates project information accordingly. If we change our package version number and run ```meteor list``` it will update ```.meteor/versions```.  **That** we can commit, and committing will spawn a rebuild.
##### Example Commands
```terminal
echo ".npm" >> .gitignore
git add .gitignore, logger.js
sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js # Increment version number
meteor list
```
To finish: commit the package, then commit the project and then watch CircleCI for rebuild success.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial07_ProductionLogging/ProductionLogging_functions.sh#L63" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-09
 .left-column[
    ### End Of Part #G
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding seven parts completed our exploration of a complete development toolkit for Meteor (<a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/issues" target="_blank">Did we miss something?</a>).

You should now have linting, logging, automated documentation, unit testing, version control, end-to-end testing and continuous deployment *in-the-cloud*.

Now we'll look at a more useful package in [Part #H - A Real World Package](./?part=H)


<!-- B -->]
