layout: false
.left-column[
  ### PART F Introduction

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Cloud Continuous Integration

The script that precedes this one, 'Part05_AutomaticDocumentationInTheCloud.sh', set up semi-automatic published documentation using ```jsDoc``` and ```gh-pages```.

Now, this script . . .  
```terminal
./Part06_CloudContinuousIntegration.sh
```
. . . will move those tasks out of your PC and into CircleCI: a continuous integration server in the cloud.


<!-- B -->]
---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Connect CircleCI to GitHub

A complete introduction to CircleCI is beyond the scopè of this series, however you can learn all the essential elements in the YouTube video: <a href="https://www.youtube.com/watch?v=oIRbUGJKcrs" target="_blank">"Android Continuous Integration with CircleCI"</a>

By <a href="http://imgur.com/z3atLCi.png" target="_blank">signing up to CircleCi</a> with <a href="http://imgur.com/lznvxN5.png" target="_blank">our GitHub account</a>, we <a href="http://imgur.com/e8kT2qL.png" target="_blank">authorize GitHub</a> to <a href="http://imgur.com/NyDT13U.png" target="_blank">reveal our organizations and repositories to CircleCI</a>.  By <a href="http://i.imgur.com/X8ABtsf.png" target="_blank">registering a GitHub repository</a> with CircleCI, <a href="http://imgur.com/6Vw0xnW.png" target="_blank">CircleCI and GitHub establish between them</a> a <a href="https://developer.github.com/webhooks/" target="_blank">"webhook"</a> that alerts CircleCI of events such as a new commit.

Once CircleCI <a href="http://i.imgur.com/DtaBko1.png" target="_blank">has analyzed our repository</a> and <a href="http://i.imgur.com/OuxEBqp.png" target="_blank">has attempted a first build</a>, we can <a href="http://i.imgur.com/QdJ8GF7.png?1" target="_blank">turn to the build results page</a>. However, there will be <a href="http://i.imgur.com/3xO3BWx.png" target="_blank">no results</a> until we describe our build requirements.

Our next task is to commit a build definition file '```circle.yml```'' to GitHub.
<!-- B -->]
---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI Configuration File and Push to GitHub

The file <a href="https://circleci.com/docs/configuration" target="_blank">Configuring CircleCI</a> documents how to prepare a '```circle.yml```' file.

In this step, we get a minimal '```circle.yml```' from the example ('```example_circle.yml```') provided with the installer for <a href="https://github.com/warehouseman/meteor-tinytest-runner" target="_blank">warehouseman:meteor-tinytest-runner</a>, that we used in <a href="http://localhost:8000/Meteor-CI-Tutorial/index.html?part=C#9" target="_blank">"Part C"</a>.  It will not succeed, for an obvious reason :
```ruby
$ tests/tinyTests/test-all.sh
grep: packages/yourpackage: No such file or directory
ERROR: Found no packages to test. tests/tinyTests/test-all.sh returned exit code 1
```

#####Commands
```terminal
cp example_circle.yml circle.yml
git add packages circle.yml tests
git commit -am 'Added package and package testing' && git push
```


<!-- Code for this begins at line #21 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L21" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Amend the Configuration and Push Again

The command failed because we still to reference our package from the ```circle.yml``` file.  We have to add these lines . . .
```ruby
    - mkdir -p ~/packages/yourself;  # ensure dir exists
    - pushd ~/packages/yourself;     
        git clone https://github.com/your0rg/yourpackage;
      popd;
    - pushd ./packages;
        rm -fr yourpackage;
        ln -s ~/packages/yourself/yourpackage yourpackage;
      popd;
```
. . . just after these ones, and then commit and push again.
```ruby
    - ln -s ~/node_modules node_modules
```
#####Commands
```terminal
git commit -am 'clone pkg and link to it' && git push
```


<!-- Code for this begins at line #48 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L48" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Set Up Nightwatch
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare for NightWatch testing.

Nightwatch tests applications end-to-end by directly controlling the browser.  Meteor has full support for TinyTests running as part of Meteor itself, but NightWatch has no such support and runs in its own NodeJS process apart from Meteor's NodeJs process.  It can even run on a different machine.

To install: pull this file out of GitHub
```terminal
wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run
```
then make make it executable and run it.

The installer prepares a Nightwatch test directory and then deletes itself, leaving only what's necessary. It includes a sample ```circle.yml``` that expects the TinyTest runner to have been installed first; it will run TinyTests and Nightwatch tests in CircleCI one after the other.


<!-- Code for this begins at line #76 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L76" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Run NightWatch
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Run NightWatch testing.

Nightwatch and Meteor are separate.

This command group starts Meteor in a background process, and then starts the Nightwatch Test Runner to try the simple sanity check test, "Does the main page have a <body> tag?".


<!-- Code for this begins at line #92 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L92" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Commit Nightwatch
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI.

The Nightwatch ```circle.yml``` includes set up of TinyTest, so it can overwrite the one created earlier.


<!-- Code for this begins at line #124 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L124" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### NPM module
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add an NPM module to your package.

Meteor supports 'npm' modules with the package NPM. 

Edit ```'${PKG_NAME}-tests.js'``` again adding :

```const Bunyan = require('bunyan');```

```javascript
const Bunyan = require('bunyan');  //  ADD! <--
// Write your tests here!
// Here is an example.
Tinytest.add("example", function sanity(test) {
    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```

... save, and observe the command line logs and the browser console. The NodeJS command on its own, **will not work**.  We need the Npm package, so instead try this :

```const Bunyan = Npm.require('bunyan');```



<!-- B -->]
---
.left-column[
  ### Specify Npm modules
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We have to specify every Npm requirement explicitly.

The Npm package preloads NodeJS modules specified in a package.js file. 

Add this block ...

```
Npm.depends({
  "bunyan": "1.4.0",
});
```

at the bottom of the file ```'package.js'```

```javascript
Package.onTest(function(api) {
  api.use('tinytest');
  api.use('${YOUR_NAME}:${PKG_NAME}');
  api.addFiles('${PKG_NAME}-tests.js');
});

Npm.depends({                 //  ADD! <--
  "bunyan": "1.4.0",
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->]
---
.left-column[
  ### Server Only
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Bunyan is for Server Side Logging Only

You will have noticed in the browser that the client tests have disappeared.  The browser console shows 'Npm' is not defined.  NodeJS modules need extra packaging to run on the client.  We don't need that here.

We'll be testing server side only.  Let's make it explicit.

Edit the ```api.addFiles``` line in ```'package.js'```to look like this :

```javascript
Package.onTest(function(api) {
  api.use('tinytest');
  api.use('${YOUR_NAME}:${PKG_NAME}');
  api.addFiles(['${PKG_NAME}-tests.js'], ['server']);  //  EDIT! <--
});

Npm.depends({
  "bunyan": "1.4.0",
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->]
---
.left-column[
  ### Add Bunyan Logging
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Now we can add logging

Edit ```'${PKG_NAME}-tests.js'``` again adding ```const Logger = Bunyan.createLogger({ "name": "ci4meteor" });``` and ```const Logger = Bunyan.createLogger({ "name": "ci4meteor" });``` as shown.

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });  //  ADD! <--

Tinytest.add("example", function sanity(test) {
    Logger.info("ººº Yoo Hoo ººº");                           //  ADD! <--
    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->]
---
.left-column[
  ### Console.log is bad!
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Observe ordinary console logging.

Here we see one of the advantages of TinyTest in the browser: quickly seeing TDD results in a tight loop.

Run the command

```terminal
meteor test-packages
```
then in the browser open [localhost:3000](http://localhost:3000/)

To the file ```packages/${PKG_NAME}/${PKG_NAME}-tests.js``` add the following
```javascript
// Write your tests here!
// Here is an example.
Tinytest.add("example", function sanity(test) {
    console.log("ººº Yoo Hoo ººº"); //  ADD! <--
    test.equal(true, true);
});
```
then save it and observe the command line logs and the browser console


<!-- B -->]
---
.left-column[
  ### Goodbye Console
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We can get rid of the console altogether

Edit ```'${PKG_NAME}-tests.js'``` again and delete the line ```console.log("ººº Yoo Hoo ººº");```

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });

Tinytest.add("example", function sanity(test) {
    Logger.info("ººº Yoo Hoo ººº");
//    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```


<!-- B -->]
---
.left-column[
  ### Refactor Bunyan (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part A)

Create a file ```'logger.js'``` that separates out Bunyan setup.

```javascript
const Bunyan = Npm.require("bunyan");
Logger = Bunyan.createLogger({
  "name": "ci4meteor",
  "streams": [{
    "path": "/var/log/meteor/ci4meteor.log",
  }],
});
```
Logs will be written to a permanent server-side file.

Remove Bunyan instantiation from ```'${PKG_NAME}-tests.js'```
```javascript
// const Bunyan = Npm.require('bunyan');
// const Logger = Bunyan.createLogger({ "name": "ci4meteor" });

Tinytest.add("example", function sanity(test) {
    :
    :
```

Continues ...


<!-- B -->]
---
.left-column[
  ### Refactor Bunyan (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continuing.

In ```package.js``` change this ...
```javascript
api.use('${YOUR_NAME}:${PKG_NAME}');
api.addFiles(['${PKG_NAME}-tests.js'], ['server']);
```
... to look like this ...
```javascript
api.use('${YOUR_NAME}:${PKG_NAME}');
api.export("Logger");           //  ADD! <--
api.addFiles(                   //  EDIT! <--
  ["logger.js", '${PKG_NAME}-tests.js'],
  ['server']
);   //  EDIT! <--
```
In a new terminal window run
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan
```

<!-- B -->]
---
.left-column[
  ### Another NodeJS Module (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part A)


Edit the file ```'package.js'``` to look like this

```javascript
Package.onUse(function(api) {
  api.versionsFrom('1.1.0.3');
  api.addFiles('${PKG_NAME}.js', ['server']);    //  EDIT! <--
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('${YOUR_NAME}:${PKG_NAME}');
  api.addFiles(                               //  EDIT! <--
    ["logger.js", '${PKG_NAME}.js', '${PKG_NAME}-tests.js'],
    ['server']
  );
  api.export("Logger"); // Order matters.  Export **after** adding
});});

Npm.depends({
  "bunyan": "1.4.0",
  "swagger-client": "2.1.1",
});
```
Continues ...


<!-- B -->]
---
.left-column[
  ### Another NodeJS Module (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part B)

... continuing.

Open the empty file ```'${PKG_NAME}.js'``` and paste into it

```javascript
const Client = Npm.require("swagger-client");
const swaggerSpecURL = "http://petstore.swagger.io/v2/swagger.json";

const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 7}, {responseContentType: "application/json"},
      function log(pet) { Logger.info("Pet #" + pet.obj.id, " -- " + pet.obj.name);  }
    );
  },
});
```
<a href='http://petstore.swagger.io/#!/pet/getPetById' target='_blank'>Swagger</a> give you instant connectivity to remote REST APIs, based solely on a machine readable specification: ```'swagger.json'```. Have a look at the logs, now.

Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Examining the code ```'${PKG_NAME}.js'``` we see :
```javascript
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 8},
      {responseContentType: "application/json"},
      function log(pet) {
        Logger.info("(Async) Pet #" + pet.obj.id, " -- " + pet.obj.name);
      }
    );
  },
});
```
The parameter ```'pet'``` passed by ```getPetById``` to the ```log``` callback function is completely inaccesible.  It is buried inside two asynchronous calls.

_How do we get it?__


Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Continuing ...

We need two wrapper functions that wait for the asynchronous calls to return their values.

Replace ```new Client()``` block with :
```javascript
const getSwaggerProxy = Meteor.wrapAsync(
  function wrpr(swaggerSpec, callback) {
    var prxySwagger = new Client({
      url: swaggerSpec,
      success: function suxs() { callback(null, prxySwagger); },
      error: function errs() { callback(null, prxySwagger); },
    });
  }
);
PetStore = getSwaggerProxy(swaggerSpecURL);
```
PetStore is now a proxy for the remote server.

Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Continuing ...

PetStore needs to be known to the rest of the application, so we declare it in ```package.js```.

So this line ...
```javascript
  api.export("Logger");
```

... becomes ...
```javascript
  api.export(["Logger", "PetStore"]);
```
Note that their names are in an array.

Continues ...


<!-- B -->]
---
.left-column[
    ### End Of Part #F
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you!



<!-- B -->]
