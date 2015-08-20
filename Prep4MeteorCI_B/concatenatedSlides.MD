layout: false
.left-column[
  ### PART B INTRODUCTION
]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

These scripts prepare the way for you to get started easily with Meteor package development, testing, documenting, code style linting and continuous integration

The previous script, 'Prep4MeteorCI_A.sh', prepared a virtual machine with the system wide requirements for continuous integration with Meteor.

This one, 'Prep4MeteorCI_B.sh', prepares an actual Meteor project and package with all the previously mentioned application development support tools.

You should not need to use 'sudo' for this part.  Everything should happen in your HOME diectory.


<!-- -->]
---
.left-column[
  ### Configure git
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure git for use with GitHub.

In this step we set up the local git tool kit to communicate correctly with GitHub.

Steps performed :
 - identify user name
 - identify user email
 - use simple push


<!-- -->]
---
.left-column[
  ### Prepare SSH directory
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create SSH keys directory if it does not exist.
 
This script requires you to have an SSH private key!

If the file '~/.ssh/id_rsa' exists, then this command group will do nothing.

Otherwise, it will set up the directory and create an empty '~/.ssh/id_rsa' 

You'll need to paste your SSH credentials into each of the empty files


<!-- -->]
---
.left-column[
  ### Install Meteor
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Your typical Meteor install step

In this step we simply run Meteor's installation

The command run is :

```terminal
curl https://install.meteor.com/ | sh
```


<!-- -->]
---
.left-column[
  ### Create Meteor Project
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor project.

Here we create a container directory called ```${PARENT_DIR}``` and inside it we start a Meteor project called ```${PROJECT_NAME}```

If the project was created earlier you'll be invited to delete it and start a new one.


<!-- -->]
---
name: Check Meteor Works

.left-column[
  ### Check Meteor Works
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Check the meteor project will work

If Meteor is not already running, it will start up ```${PROJECT_NAME}``` now.

If Meteor IS already running, you will need to stop it.

**When prompted**, test meteor in a browser.

[localhost:3000](http://localhost:3000/)

When you continue to the next step Meteor will be killed automatically.


<!-- -->]
---
.left-column[
  ### Meteor App Metadata
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add Meteor application metadata files

In this step we create some of the project meta data files :
 -  LICENSE
 -  README.md
 -  .gitignore
 -  .eslintrc

The .eslintrc file is borrowed from the project [warehouseman:meteor-swagger-client](https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc)


<!-- -->]
---
.left-column[
  ### ESLint for ST3
]
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

<!-- -->]
---
.left-column[
  ### GitHub Repo
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

In this step we create a repository in GitHub project source hosting.

The steps are :

 - Log in to GitHub and create a project with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
 - Log in to CircleCI and set it to monitor project ```${PROJECT_NAME}``` for rebuilding.


<!-- -->]
---
.left-column[
  ### Local GitHub Repo
]
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

<!-- -->]
---
.left-column[
  ### Test a Meteor Package
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a package and TinyTest it.

Meteor makes this very easy. Two commands and we have a unit tested package.

- meteor create --package yours:skeleton
- meteor test-packages

Meteor will start up as a background process in TinyTest mode.

In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

Notice the files newly added under the package directory.  These will also have to be pushed to GitHub.


<!-- -->]
---
.left-column[
  ### Selenium Web Driver
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install 'selenium-webdriver'

Selenium Webdriver is required for the next step.

We must first ensure that root has not taken ownership of the local .npm directory.  You will need your password to enable the [ch]ange [own]er command.

```terminal
sudo chown -R ${USER}:${USER} ~/.npm
```


<!-- -->]
---
.left-column[
  ### Runner for TinyTest
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser.  This is useless for continuous integration.

We need to have test results on the command line.

The GitHub repo [warehouseman:meteor-tinytest-runner](https://github.com/warehouseman/meteor-tinytest-runner) has a wrapper tool that drives a browser with Selenium and collects the results in text format.

The installer deletes itself after preparing the files for immediate use.


<!-- -->]
---
.left-column[
  ### Configure CircleCI 
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI configuration file and push to GitHub

On the preliminary commit, CircleCI recognized the project's existence but did not know what to do with it.

Now, we have a test runner, and with the addition of a ```circle.yml``` configuration file committing the project to GitHub will cause an automatic rebuild.


<!-- -->]
---
.left-column[
  ### Install Bunyan
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install 'bunyan'

Bunyan is a logging package with the special advantage of writing
run-time logs as JSON.

This makes subsequent analysis and long-term
storage of production system logs much more efficient.

It is in two parts :
 - a local node module to replace 'console.log'
 - a global module that reads Bunyan JSON and reformats for different uses, including stdout.

For ongoing server side logging during development or production we need a permanent home for the logs.  The standard place for that in Ubuntu is ```/var/log/```.  So we also need to create a directory for Meteor with suitable permissions.


<!-- -->]
---
.left-column[
  ### Set Up Nightwatch
]
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


<!-- -->]
---
.left-column[
  ### Run NightWatch
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Run NightWatch testing.

Nightwatch and Meteor are separate.

This command group starts Meteor in a background process, and then starts the Nightwatch Test Runner to try the simple sanity check test, "Does the main page have a <body> tag?".


<!-- -->]
---
.left-column[
  ### Commit Nightwatch
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI.

The Nightwatch ```circle.yml``` includes set up of TinyTest, so it can overwrite the one created earlier.


<!-- -->]
---
.left-column[
  ### Console.log is bad!
]
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


<!-- -->]
---
.left-column[
  ### NPM module
]
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



<!-- -->]
---
.left-column[
  ### Specify Npm modules
]
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
  api.addFiles(['skeleton-tests.js'], ['server']);
});

Npm.depends({                 //  ADD! <--
  "bunyan": "1.4.0",
});
```

   ... save, and observe the command line logs and the browser console.

<!-- -->]
---
.left-column[
  ### Add Bunyan Logging
]
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

<!-- -->]
---
.left-column[
  ### Goodbye Console
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Now we can get rid of the console alothogether

Edit ```'skeleton-tests.js'``` again and delete the line ```console.log("ººº Yoo Hoo ººº");```

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });
// Write your tests here!
// Here is an example.
Tinytest.add("example", function sanity(test) {
    Logger.info("ººº Yoo Hoo ººº");
//    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```

Stop your Meteor service and restart with this command :
```terminal
meteor test-packages | bunyan
```

<!-- -->]
---
.left-column[
  ### 
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### title

body

<!-- -->]
---
.left-column[
  ### 
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### title

body

<!-- -->]
---
.left-column[
  ### 
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### title

body

<!-- -->]
---
.left-column[
  ### 
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### title

body

<!-- -->]
---
.left-column[
  ### 
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### title

body

<!-- -->]
---
.left-column[
  ### End Of Part #B
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you!


<!-- -->]
