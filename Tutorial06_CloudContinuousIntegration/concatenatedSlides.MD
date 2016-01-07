layout: false
last_update: 2016-01-02
 .left-column[
  ### PART F Introduction

.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Cloud Continuous Integration

The preceding script, 'Tutorial05_AutomaticDocumentationInTheCloud.sh', set up semi-automatic published documentation using ```jsDoc``` and ```gh-pages```.

Now, this script . . .  
```terminal
./Tutorial06_CloudContinuousIntegration.sh
```
. . . will move those tasks out of your PC and into CircleCI: a continuous integration server in the cloud.


<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.gif' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Connect CircleCI to GitHub (Part A)

A complete introduction to CircleCI is beyond the scopè of this series, however you can learn all the essential elements in the YouTube video: <a href="https://www.youtube.com/watch?v=oIRbUGJKcrs" target="_blank">"Android Continuous Integration with CircleCI"</a>

By <a href="http://imgur.com/z3atLCi.png" target="_blank">signing up to CircleCi</a> with <a href="http://imgur.com/lznvxN5.png" target="_blank">our GitHub account</a>, we <a href="http://imgur.com/e8kT2qL.png" target="_blank">authorize GitHub</a> to <a href="http://imgur.com/NyDT13U.png" target="_blank">reveal our organizations and repositories to CircleCI</a>.  By <a href="http://i.imgur.com/X8ABtsf.png" target="_blank">registering a GitHub repository</a> with CircleCI, <a href="http://imgur.com/6Vw0xnW.png" target="_blank">CircleCI and GitHub establish between them</a> a <a href="https://developer.github.com/webhooks/" target="_blank">"webhook"</a> that alerts CircleCI of events such as a new commit.

Once CircleCI <a href="http://i.imgur.com/DtaBko1.png" target="_blank">has analyzed our repository</a> and <a href="http://i.imgur.com/OuxEBqp.png" target="_blank">has attempted a first build</a>, we can <a href="http://i.imgur.com/QdJ8GF7.png?1" target="_blank">turn to the build results page</a>. However, there will be <a href="http://i.imgur.com/3xO3BWx.png" target="_blank">no results</a> until we describe our build requirements.

Continued . . .
<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.gif' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Connect CircleCI to GitHub (Part B)

. . . continuing.


Our initial build readies us to do two important things :

1. *Obtain an <a href="https://circleci.com/docs/api#getting-started" target="_blank">API Token</a> so we can automate our interactions with CircleCI*  : Open the page <a href="https://circleci.com/account/api" target="_blank">API Tokens</a>, invent a name for the token (eg; who will use it), and click *Create*.  The named token will remain available on that page, any time you need it.

2. *Authorize our ```circle.yml``` scripts to write back into GitHub, with a <a href="https://circleci.com/docs/github-security-ssh-keys" target="_blank">User Checkout Key</a>* : To push changes back to GitHub you must get a *User Key* from : <div style='word-wrap:break-word;'><a href="https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout" target="_blank">https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout</a></div>

Our next task is to commit/push '```circle.yml```', a build definition file.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L296" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a CircleCI Configuration File and Push to GitHub

The documentation page "<a href="https://circleci.com/docs/configuration" target="_blank">Configuring CircleCI</a>" shows how to prepare a '```circle.yml```' file.

In this step, we get a minimal '```circle.yml```' from the example ('```example_circle.yml```') provided with the installer for <a href="https://github.com/warehouseman/meteor-tinytest-runner" target="_blank">warehouseman:meteor-tinytest-runner</a>, that we used in <a href="http://localhost:8000/Meteor-CI-Tutorial/index.html?part=C#9" target="_blank">"Part C"</a>.  It will not succeed, for an obvious reason :
```ruby
$ ./tests/tinyTests/test-all.sh
grep: packages/yourpackage: No such file or directory
ERROR: Found no packages to test. tests/tinyTests/test-all.sh returned exit code 1
```

##### Example Commands
```terminal
cp example_circle.yml circle.yml
git add circle.yml tests
git commit -am 'Added circle.yml and unit testing' && git push
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L318" target="_blank">Code for this step.</a>] ]
]
---
name: AmendTheConfigurationAndPushAgain
last_update: 2016-01-02
 .left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Amend the Configuration and Push Again

The command failed because we still must reference our package from the ```circle.yml``` file.

We add the script "<a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/obtain_managed_packages.sh" target="_blank">obtain_managed_packages.sh</a>" to the packages directory of our project.  It uses the list, ```managed_packages.sh```, to clone our packages and link them into the project.  Edit the list as needed.
```ruby
  # Pull each of our packages and link them into our project
  - ./packages/obtain_managed_packages.sh
```

##### Example Commands
```terminal
wget -O ./packages/managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/managed_packages.sh;
wget -O ./packages/obtain_managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/obtain_managed_packages.sh;
git add packages;
git commit -am 'Add script to clone packages and symlink to them';
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L368" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Set Up Nightwatch
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare for NightWatch testing.

Nightwatch tests applications end-to-end by directly controlling the browser.  Meteor has full support for TinyTests running as part of Meteor itself, but NightWatch has no such support and runs in its own NodeJS process apart from Meteor's NodeJs process.  It can even run on a different machine.

To install: pull this file out of GitHub
```terminal
wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run
```
then make it executable and run it.

The installer prepares a Nightwatch test directory and then deletes itself, leaving only what's necessary. It includes a sample ```circle.yml``` that expects the TinyTest runner to have been installed first; it will run TinyTests and Nightwatch tests in CircleCI one after the other.


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L417" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Run NightWatch
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Run NightWatch testing.

Nightwatch and Meteor are separate.

This command group starts Meteor in a background process, (stopping any already running), and then starts the Nightwatch Test Runner to try the simple sanity check test, "Does the main page have a <body> tag?".  It will kill the Meteor processes when complete.  Expected results :
```ruby
[2015-09-29T15:45:32.571Z]  INFO: demo/4217 on yourvm: Running:  Layout and Static Pages
[2015-09-29T15:45:36.170Z]  INFO: demo/4217 on yourvm: ✔ Testing if element <body> is present.
[2015-09-29T15:45:36.762Z]  INFO: demo/4217 on yourvm: OK. 1 assertions passed. (4.189s)
[2015-09-29T15:45:36.768Z]  INFO: demo/4217 on yourvm:
[2015-09-29T15:45:36.771Z]  INFO: demo/4217 on yourvm: OK. 1 assertion passed. (4.912s)
[2015-09-29T15:45:37.049Z]  INFO: demo/4217 on yourvm: Finished!  Nightwatch ran all the tests!
```


##### Example Commands
```terminal
 ./tests/nightwatch/runTests.js | bunyan
```
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L430" target="_blank">Code for this step.</a>] ]
]
---
name: ConfigureCircleCIforNightwatchTesting
last_update: 2016-01-02
 .left-column[
  ### Commit Nightwatch
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure CircleCI for Nightwatch Testing

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI.

The Nightwatch runner's ```circle.yml``` can safely overwrite the one for TinyTest.  We still need to do that **and** we need to restore the call to execute ```obtain_managed_packages.sh``` 

First, in the project main directory, make a copy of the ```circle.yml``` augmented for nightwatch, then patch it, adding the call to ```obtain_managed_packages.sh``` as we did earlier, then push it to GitHub and see how it builds in CircleCI.

##### Example Commands
```terminal
cp tests/nightwatch/config/example_circle.yml circle.yml;
git add tests/nightwatch;
git commit -am 'Added Nightwatch testing';
git push
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L491" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-07
 .left-column[
    ### End Of Part #F
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding six parts covered everything involved in setting up linting, automated documentation, unit testing, version control, end-to-end testing and continuous integration *in-the-cloud*.

An important missing piece is production grade logging -- logging that can be scaled up and down in localized bits of code, to inspect behaviour unobtrusively.  That's [Part #G - Production Logging](./?part=G)

<!-- B -->]
