layout: false
last_update: 2016-01-02
 .left-column[
  ### PART I Introduction

.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Package Self Test

A major benefit of freely publishing a useful package is the feedback and collaboration that can come back to you.  However, the quality of your code, documention and tests, can convince or repel would-be contributors. If I can fork your repo, push it to continuous integration and see it thoroughly tested and see its documentation generated without intervention, I will be confident that Ì can contribute easily to an enduring project.

In this step we will finalize our code annotations, automate running and verifying the usage example and then complete our ```circle.yml``` file so that documentation generation and the verfication of usage examples all run automatically in CircleCI.

Get started now by running ...
```terminal
./Tutorial09_PackageSelfTest.sh
```



<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Revisit End-To-End Testing
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

#### End To End Test of the Usage Example

The accompanying script creates a new subdirectory *(if needed)* of ${PKG_NAME} called ```tools/testing``` and, into it, downloads the <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/test_usage_example.js' target='_blank'>code for a usage example end-to-end test</a>.  *Nightwatch* needs to be told where to find it, so now edit ```${PROJECT_NAME}/tests/nightwatch/config/nightwatch.json``` to look like this :
```javascript
  "src_folders": [
    "./packages/${PKG_NAME}/tools/testing",   // ADD | <--
    "./tests/nightwatch/walkthroughs"
  ]
```
Then  re-run nightwatch testing with ```./tests/nightwatch/runTests.js | bunyan -o short```.
##### Example Commands
```terminal
wget -O test_usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/test_usage_example.js
./tests/nightwatch/runTests.js | bunyan
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L2" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Finish Documentation
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

#### The Package Works But It Is Not Documented

The files <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js' target='_blank'>"yourpackage_documented.js"</a> and <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js' target='_blank'>"usage_example_documented.js"</a> are to replace the less well documented files ```${PKG_NAME}.js``` and ```usage_example.js```.

<div style='word-wrap:break-word;'>Rerunning jsDoc now will generate a much more complete documentation site than before.  View it locally at : <a href='file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html' target='_blank'>file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html</a>.</div>

Be aware that we still need to commit the docs directory to the ```gh-pages``` branch of the package repo so as to publish it as GitHub Pages.  Our CI system must be able to do that.

##### Example Commands
```terminal
wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js
wget -O usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js
jsdoc -d ./docs . ./nightwatch
```

Continues ...

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L38" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Integrating Everything
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

#### Integrating Everything

We have two last pushes to do: the package and its enclosing test/demo project.  However, we want CircleCI to do a lot more work for us.

Up to now, we commit the package with a new version number, then commit the umbrella project referencing the new version.  That triggers CircleCI to launch a new build sequence that pulls the project and packages together and runs all their tests, but it neither verifies coding style compliance nor regenerates our documentation nor deploys to our public server.

Our focus for the rest of this part is going to be on <a href="https://circleci.com/docs/configuration" target="_blank">configuring</a> our ```circle.yml``` file.  We'll verify coding style during CircleCI's ```test``` phase.  We'll publish our documentation and deploy the application itself during the ```deployment``` phase.  For now we'll just commit/push and check it all works.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L65" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Helper File - Package Iterator
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

#### Code Maintenance Helper File (Part A)

Let's take a step back and a fresh look at what we are doing here.

Our project only exists to act as an integration and test harness for our package -- but, we might want multiple packages.  Back in  <a href="./index.html?part=F#4" target="_blank">Tutorial 6</a> we introduced the file ```obtain_managed_packages.sh``` that iterates through a list of packages in ```managed_packages.sh```, cloning each in turn from GitHub into CircleCI.

Linting code and publishing docs are just two out of N additional integration tasks we might want to perform.  Since we know in advance neither the number of packages, nor the number of tasks for each package, we'll offer each one an opportunity to **run it's own** maintenance tasks. So, we'll introduce two more files; at the project level ```perform_per_package_ci_tasks.sh``` will iterate through our ```managed_packages.sh``` list calling ```perform_ci_tasks.sh``` in each package.

Continued . . .

<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Helper File - Arbitrary # of Packages.
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

#### Code Maintenance Helper File (Part B)

. . . continuing.

In this step, we create a dummy package maintenance file with a single command to be executed: 

```terminal
echo "I will perform CI tasks on ${PKG_NAME}.";
```

We also download ```perform_per_package_ci_tasks.sh``` and run it, expecting the result :

```ruby
Delegating to 1 package in '../../packages'.

   Package 1 of 1 :: Found code maintenance routine at '../../packages/${YOUR_UID}/${PKG_NAME}/tools/perform_ci_tasks.sh'.
I will perform CI tasks on ${PKG_NAME}.
```

As long as a package has a valid bash executable at ```./tools/perform_ci_tasks.sh``` then linting, documenting and other tasks will be executed as part of continuous integration.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L103" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Helper File - Arbitrary # of Tasks.
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

#### Code Maintenance Helper File (Part C)

We now need to make the package level maintenance script actually do something.

The prepared script, <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_ci_tasks.sh" target="_blank">"perform_ci_tasks.sh"</a>, has 3 functions: 

1)  ```generateDocs()``` simply writes documents locally without trying to publish on GitHub Pages. 

2) ```checkCodeStyle()``` should write it's results to CircleCI's <a href="https://circleci.com/docs/build-artifacts" target="_blank">build artifacts directory</a> specified by <a href="https://circleci.com/docs/environment-variables" target="_blank">the environment variable</a> ```CIRCLE_ARTIFACTS```.  Of course, if we are working locally, that variable will be ```null```.  We have to set it to something, so we simply make it: "```.```".

3) ```commitDocsToGitHubPages()``` is temporarily commented out.

Executing, ```perform_per_package_ci_tasks.sh```, now will show ```esLint``` and ```jsDoc``` completing their respective tasks.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L128" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Helper File - GitHub "UserKey"
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

#### Build Script Authorization

The function, ```commitDocsToGitHubPages()```, presents us with a problem.

Back in Part #6 we authorized CircleCI to access our GitHub project with a "GitHub User Key" -- now we're going to need it.  Without it, our ```circle.yml``` script will fail when it tries to push our documentation to the *gh-pages* branches of our packages.  As CircleCI's manual page, <a href="https://circleci.com/docs/github-security-ssh-keys" target="_blank">*GitHub security and SSH keys*</a> indicates, we need a heightened privileges "UserKey", in order to push back to GitHub from CircleCI.

Open your project's page, "Checkout keys for ${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}", ensure "${PACKAGE_DEVELOPER} user key" exists and (optionally) delete the redundant deploy key :

```ruby
https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout
``` 

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L154" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Helper File - Commit gh-pages Branch (Part A)
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

#### Push Docs To GitHub Pages From CI Build (Part A)

Now that our build script has sufficient privileges, we can enable the call to ```commitDocsToGitHubPages```, which is commented out at the bottom of the file ```./tools/perform_ci_tasks.sh``` :

```ruby
checkCodeStyle;
generateDocs;
# commitDocsToGitHubPages;    # <--  uncomment
```

We'll also update our ```circle.yml``` script, adding the call to ```perform_per_package_ci_tasks.sh```, as follows :

```ruby
test:
  override:
    # Perform per package CI Tasks
    - ${HOME}/${CIRCLE_PROJECT_REPONAME}/packages/perform_per_package_ci_tasks.sh
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L172" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Helper File - Commit gh-pages Branch (Part B)
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

#### Pushing Docs To GitHub Pages From CI Build (Part B)

Finally, we can commit all these changes and push them out to GitHub.  When we do that, GitHub will hook CircleCI into performing a new build.  We should see :

 - The build completed successfully at https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}
 - <a href="https://martinhbramwell.github.io/Meteor-CI-Tutorial/fragments/loader.gif" target="_blank">CircleCI Artifacts tab</a> links to successful results for :
   - Linting in "eslintReport.txt"
   - Nightwatch test results in "result.json"
 - Latest documentation at our GitHub Pages web site.

##### Example Commands

```ruby
git add ./tools/perform_ci_tasks.sh;
git commit -am "Added code maintenance tasks";
#
git add ./packages/perform_per_package_ci_tasks.sh;
git add circle.yml;
git commit -am "Added code maintenance package iterator and augmented circle.yml";
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L213" target="_blank">Code for this step.</a>]  ]
]
---
last_update: 2016-01-04
 .left-column[
  ### Final Deployment
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

#### Inspect Build Results

Because we created an "API Token" at the start of Section 6 we have the capability to monitor build execution from our development machine.

In this case we will check on the status of the build every 30 seconds, then when it is no longer running we get the build number.  We request the list of artifacts for that specific build and then search the list for the URLs of the artifacts that interest us.

##### Example Commands

```ruby
BUILD_STATUS=$( curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json"  | jq '.[0].status' );
BUILD_NUM=$(curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}?circle-token=${CIRCLECI_PERSONAL_TOKEN}  -H "Accept: application/json"  | jq '.[0].build_num');
NGHTWTCH_RESULT_URL=$(cat /tmp/circleci_artifacts.json | jq '.[] | .url' | grep 'result.json');
wget -qO- ${NGHTWTCH_RESULT_URL//\"/} | bunyan -o short;

```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L257" target="_blank">Code for this step.</a>]  ]
]
---

 .left-column[
  ### Final Deployment
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

#### Report An Issue

Whenever a build process turns up an error such as the "Unexpected console statement" warning in ```usage_example.js``` you should prepare an issue report.

In GitHub it is possible to hyperlink to the exact specific source code line, but, be aware that the URL of the latest version won't also work for prior versions.  You can refer to the permanent line number of a specific commit by clicking the line of text in GitHub and then typing 'y'.  Github will replace the URL in the browser's address bar with the 'permalink' address.

Copying it, you can make a markdown hyperlink to paste into the issue like this . . . 

```javscript
[usage_example.js - line #${LINE_NUM}](https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}/blob/${COMMIT_SHA}/usage_example.js#L379${LINE_NUM})
```



<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L255" target="_blank">Code for this step.</a>]  ]
]
---
last_update: 2016-01-04
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

#### Fin

We have successfully built and tested our package in its container project.

Now we need to deploy it to a web server and also serve it out to the public as a mobile app.  In the next section we'll first see how to do this in our development machine and then how to deploy from our continuous integration service.

[Part #J - Automated Deployment](./?part=J)




<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L38" target="_blank">Code for this step.</a>] ]
]
