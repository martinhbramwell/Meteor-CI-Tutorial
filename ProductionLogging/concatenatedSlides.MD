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
    ### End Of Part #G
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding seven parts completed our exploration of a complete development toolkit for Meteor (Did we miss something?).  You should now have linting, logging, automated documentation, unit testing, version control, end-to-end testing and continuous integration *in-the-cloud*.

Now we need look at a more useful package in [Part #H - A Real World Package](./?part=H)


<!-- B -->]
