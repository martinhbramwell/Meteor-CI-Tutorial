layout: false
.left-column[
  ### PART B INTRODUCTION
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

These scripts will get you started easily with Meteor package development, testing, documenting, code style linting and continuous integration.

The previous script, 'Step01_PrepareTheMachine.sh', set up necessary preconditions for the second script, basically all tasks that require root access. 

This one, 'Step02_UnitTestThePackage.sh', prepares a Meteor project with an embedded package ready for testing with TinyTest using the first few of the previously mentioned application development support tools.

You should not need to use 'sudo' for this or any of the later parts.  Everything should happen in your HOME directory.


<!-- B -->]
---
.left-column[
  ### Set Up Project Names
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Set up identifiers required by GitHub

This step writes some names you specify to a file.  You won't have to repeat this.

You will be asked to supply the following details :
 - The exact project name for use in GitHub
 - The exact name for the GitHub organization
 - The project owner name to use to publish it in GitHub
 - The email address for the project owner in GitHub

<!-- B -->]
---
.left-column[
  ### Configure git for GitHub
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure git for use with GitHub.

In this step we set up the local git tool kit to communicate correctly with GitHub, per [their getting started guide](https://help.github.com/articles/set-up-git/).

Steps performed :
- identify user name
- identify user email
- use simple push
#####Commands
```terminal
git config --global user.name "${YOUR_EMAIL}"
git config --global user.email "${YOUR_NAME}"
git config --global push.default simple
```
<!-- Code for this begins at line #48-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L48" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Prepare SSH directory
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create SSH keys directory if it does not exist.
 
This script requires you to have an SSH private key!

If the file '~/.ssh/id_rsa' exists, then this command group will do nothing.

Otherwise, it will set up the directory and create an empty '~/.ssh/id_rsa' 

You'll need to paste your SSH credentials into each of the empty files. This assumes you only need to copy them in from some other GitHub project.  Getting them for the first time is beyond the scope of this tutorial.  You should follow [GitHub's getting started documents.](https://help.github.com/articles/generating-ssh-keys/)


<!-- Code for this begins at line #62-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L62" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install Meteor
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Your typical Meteor install step

In this step we simply run Meteor's installation

##### Commands
```terminal
curl https://install.meteor.com/ | sh
```


<!-- Code for this begins at line #98-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L98" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create Meteor Project
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor project.

Here we create a container directory called ```${PARENT_DIR}``` and inside it we start a Meteor project called ```${PROJECT_NAME}```

If the project was created earlier you'll be invited to delete it and start a new one.
##### Commands
```terminal
mkdir -p ~/${PARENT_DIR}
meteor create ${PROJECT_NAME}
```

<!-- Code for this begins at line #123-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L123" target="_blank">Code for this step.</a>] ]
]
---
name: Check Meteor Works

.left-column[
  ### Check Meteor Works
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
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

<!-- Code for this begins at line #167-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L167" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Meteor App Metadata
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add Meteor application metadata files

In this step we create some of the project meta data files :
 -  LICENSE
 -  README.md
 -  .gitignore
 -  .eslintrc

The .eslintrc file is borrowed from the project [warehouseman:meteor-swagger-client](https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc)
#####Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc
```

<!-- Code for this begins at line #194-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L194" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### ESLint for ST3
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure Sublime Text to use the '.eslintrc' file

Now we add hinting about coding style defects to Sublime Text.

Steps to perform :

 - Go to Preferences >> Package Control
 - In Package Control type : install package
 - Install these two packages :
   - 'SublimeLinter'
   - 'SublimeLinter-contrib-eslint'

<!-- B -->]
---
.left-column[
  ### GitHub Repo
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

In this step we create a repository in GitHub project source hosting.

The steps are :

 - Log in to GitHub and create a project with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
 - Log in to CircleCI and set it to monitor project ```${PROJECT_NAME}``` for rebuilding.

Some steps are more understandable if you watch the video series mentioned on the Table of Contents page.



<!-- B -->]
---
.left-column[
  ### Local GitHub Repo
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create our **local** GitHub repository.

In this step we :
 -  initialize a local .git repository
 -  add all the files to the local repo and commit
 -  establish our GitHub project as the remote repository
 -  push our new files to GitHub

SSH may ask you to confirm GitHub's PK fingerprint.

This step is NOT idempotent.

If the project has already been pushed to GitHub you might get errors. If so, the easiest thing to do is eliminate the project from GitHub and run this step again.

<!-- Code for this begins at line #257-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L257" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a package and TinyTest it.

Meteor makes this very easy. Two commands and we have a unit tested package.

- meteor create --package yours:skeleton
- meteor test-packages

Meteor will start up as a background process in TinyTest mode.

In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

Notice the files newly added under the package directory.  These will also have to be pushed to GitHub.


<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L278" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Runner for TinyTest
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser.  This is useless for continuous integration.

We need to have test results on the command line.

The GitHub repo [warehouseman:meteor-tinytest-runner](https://github.com/warehouseman/meteor-tinytest-runner) has a wrapper tool that drives a browser with Selenium and collects the results in text format.

The installer deletes itself after preparing the files for immediate use.


<!-- Code for this begins at line #311-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L311" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Configure CircleCI 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI configuration file and push to GitHub

On the preliminary commit, CircleCI recognized the project's existence but did not know what to do with it.

Now, we have a test runner, and with the addition of a ```circle.yml``` configuration file committing the project to GitHub will cause an automatic rebuild.


<!-- Code for this begins at line #342-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L342" target="_blank">Code for this step.</a>] ]
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


<!-- Code for this begins at line #374-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L374" target="_blank">Code for this step.</a>] ]
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


<!-- Code for this begins at line #390-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L390" target="_blank">Code for this step.</a>] ]
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


<!-- Code for this begins at line #422-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L422" target="_blank">Code for this step.</a>] ]
]
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

To the file ```packages/skeleton/skeleton-tests.js``` add the following
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
  ### NPM module
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add an NPM module to your package.

Meteor supports 'npm' modules with the package NPM. 

Edit ```'skeleton-tests.js'``` again adding :

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
  api.use('yours:skeleton');
  api.addFiles('skeleton-tests.js');
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
  api.use('yours:skeleton');
  api.addFiles(['skeleton-tests.js'], ['server']);  //  EDIT! <--
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

Edit ```'skeleton-tests.js'``` again adding ```const Logger = Bunyan.createLogger({ "name": "ci4meteor" });``` and ```const Logger = Bunyan.createLogger({ "name": "ci4meteor" });``` as shown.

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
  ### Goodbye Console
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We can get rid of the console altogether

Edit ```'skeleton-tests.js'``` again and delete the line ```console.log("ººº Yoo Hoo ººº");```

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

Remove Bunyan instantiation from ```'skeleton-tests.js'```
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
api.use('yours:skeleton');
api.addFiles(['skeleton-tests.js'], ['server']);
```
... to look like this ...
```javascript
api.use('yours:skeleton');
api.export("Logger");           //  ADD! <--
api.addFiles(                   //  EDIT! <--
  ["logger.js", 'skeleton-tests.js'],
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
  api.addFiles('skeleton.js', ['server']);    //  EDIT! <--
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('yours:skeleton');
  api.addFiles(                               //  EDIT! <--
    ["logger.js", 'skeleton.js', 'skeleton-tests.js'],
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

Open the empty file ```'skeleton.js'``` and paste into it

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
[Swagger](http://petstore.swagger.io/#!/pet/getPetById) give you instant connectivity to remote REST APIs, based solely on a machine readable specification: ```'swagger.json'```. Have a look at the logs, now.

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

Examining the code ```'skeleton.js'``` we see :
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
  ### End Of Part B
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you!


<!-- B -->]
