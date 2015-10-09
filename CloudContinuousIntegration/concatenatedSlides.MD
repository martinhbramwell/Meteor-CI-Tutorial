layout: false
.left-column[
  ### PART F Introduction

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Cloud Continuous Integration

The preceding script, 'Part05_AutomaticDocumentationInTheCloud.sh', set up semi-automatic published documentation using ```jsDoc``` and ```gh-pages```.

Now, this script . . .  
```terminal
./Part06_CloudContinuousIntegration.sh
```
. . . will move those tasks out of your PC and into CircleCI: a continuous integration server in the cloud.


<!-- B -->]
---
.left-column[
  ### Configure CircleCI 
  <br />
  <br />
  <div class="manual_input_reqd">
  <img src="./fragments/typer.gif" />
  Manual input required here.
  </div>
  <br />
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
name: AmendTheConfigurationAndPushAgain
.left-column[
  ### Configure CircleCI
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Amend the Configuration and Push Again

The command failed because we still must reference our package from the ```circle.yml``` file.  We have to add these lines (substituting appropriately for your names) . . .
```ruby
    - mkdir -p ~/packages/${YOUR_UID};  # ensure dir exists
    - pushd ~/packages/${YOUR_UID};
        git clone https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME};
      popd;
    - pushd ./packages;
        rm -fr ${PKG_NAME};
        ln -s ~/packages/${YOUR_UID}/${PKG_NAME} ${PKG_NAME};
      popd;
```
. . . just after this one, and then commit and push again.
```ruby
    - ln -s ~/node_modules node_modules
```
#####Commands
```terminal
git commit -am 'clone pkg and link to it' && git push
```


<!-- Code for this begins at line #64 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L64" target="_blank">Code for this step.</a>] ]
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
then make it executable and run it.

The installer prepares a Nightwatch test directory and then deletes itself, leaving only what's necessary. It includes a sample ```circle.yml``` that expects the TinyTest runner to have been installed first; it will run TinyTests and Nightwatch tests in CircleCI one after the other.


<!-- Code for this begins at line #89 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L89" target="_blank">Code for this step.</a>] ]
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

This command group starts Meteor in a background process, (stopping any already running), and then starts the Nightwatch Test Runner to try the simple sanity check test, "Does the main page have a <body> tag?".  It will kill the Meteor processes when complete.  Expected results :
```ruby
[2015-09-29T15:45:32.571Z]  INFO: demo/4217 on yourvm: Running:  Layout and Static Pages
[2015-09-29T15:45:36.170Z]  INFO: demo/4217 on yourvm: ✔ Testing if element <body> is present.
[2015-09-29T15:45:36.762Z]  INFO: demo/4217 on yourvm: OK. 1 assertions passed. (4.189s)
[2015-09-29T15:45:36.768Z]  INFO: demo/4217 on yourvm:
[2015-09-29T15:45:36.771Z]  INFO: demo/4217 on yourvm: OK. 1 assertion passed. (4.912s)
[2015-09-29T15:45:37.049Z]  INFO: demo/4217 on yourvm: Finished!  Nightwatch ran all the tests!
```


##### Commands
```terminal
 ./tests/nightwatch/runTests.js | bunyan
```
<!-- Code for this begins at line #105 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L105" target="_blank">Code for this step.</a>] ]
]
---
name: ConfigureCircleCIforNightwatchTesting
.left-column[
  ### Commit Nightwatch
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure CircleCI for Nightwatch Testing

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI.

The Nightwatch runner's ```circle.yml``` can safely overwrite the one for TinyTest.  We still need to do that **and** we need to restore the code for using ${PKG_NAME} that we applied in the step ["Amend the Configuration and Push Again"](#AmendTheConfigurationAndPushAgain), (again, not forgetting appropriate substitutions).

First get the augmented ```circle.yml``` . . .

##### Commands
```terminal
cp tests/nightwatch/config/example_circle.yml circle.yml;
```

Continued . . .
<!-- Code for this begins at line #162 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L162" target="_blank">Code for this step.</a>] ]
]
---
name: PushNightwatchTestingToGitHubAndCircleCI
.left-column[
  ### Commit Nightwatch
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

. . . continued.

Now edit ```circle.yml``` to re-enable use of ${PKG_NAME}, (not forgetting substitutions), then commit to GitHub -- hooking CircleCI for a rebuild :

```ruby
    - mkdir -p ~/packages/${YOUR_UID};  # ensure dir exists
    - pushd ~/packages/${YOUR_UID};
        git clone https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME};
      popd;
    - pushd ./packages;
        rm -fr ${PKG_NAME};   ln -s ~/packages/${YOUR_UID}/${PKG_NAME} ${PKG_NAME};
      popd;
```
##### Commands
```terminal
git add tests/nightwatch;
git add circle.yml;
git commit -am 'Added Nightwatch testing';
git push
```
<!-- Code for this begins at line #177 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L177" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
    ### End Of Part #F
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding six parts covered everything involved in setting up linting, automated documentation, unit testing, version control, end-to-end testing and continuous integration *in-the-cloud*.

An important missing piece is production grade logging -- logging that can be scaled up and down in localized bits of code, to inspect behaviour unobtrusively.  That's [Part #G - Production Logging](./?part=G)


<!-- B -->]
