layout: false
.left-column[
  ### PART B INTRODUCTION
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

These scripts will get you started easily with Meteor package development, testing, documenting, code style linting and continuous integration.

The previous script, 'Part01_PrepareTheMachine.sh', set up necessary preconditions for the second script, basically all tasks that require root access. 

This one . . .  
```terminal
Part02_UnitTestThePackage.sh
```
. . . prepares a Meteor project with an associated external package ready for testing with TinyTest using the first few of the previously mentioned application development support tools.

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
 - The exact package name for use in GitHub
 - The exact name for the GitHub organization
 - The project owner's full name to use to publish on GitHub
 - The project owner name to for internal use
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
git config --global user.name "${PACKAGE_DEVELOPER}"
git config --global user.email "${YOUR_EMAIL}"
git config --global push.default simple
```
<!-- Code for this begins at line #48-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L35" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L46" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L71" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L115" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L142" target="_blank">Code for this step.</a>] ]
]
---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

In this step we create a repository in GitHub project source hosting.

The steps are :

 - Log in to [GitHub](https://github.com/) as ```${PACKAGE_DEVELOPER}``` and create a project with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
 - Log in to [CircleCI](https://circleci.com/) and set it to monitor project ```${PROJECT_NAME}``` for rebuilding.

Some steps are more understandable if you watch the video series mentioned on the [Table of Contents](./) page.



<!-- B -->]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L204" target="_blank">Code for this step.</a>] ]
]
---
name: CreateLocalGitHubRepository
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

**This step is NOT idempotent.**  If you have already pushed to GitHub you might get errors. If so, eliminate the project from GitHub and run this step again. *Also note : SSH may ask you to confirm GitHub's PK fingerprint.**
#####Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
git push -u origin master
```

<!-- Code for this begins at line #257-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L240" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor package development directory.

If you aim for "package only applications", if packages are to be reusable, your packages need independent version control, and hence a directory outside of the project, located by Meteor's shell variable ```PACKAGE_DIRS```.

To create self-sufficient packages, begin by defining it as a permanent fixture of your user profile, pointing to the place where you will keep your packages.
##### Commands
```terminal
export PACKAGES=~/${PARENT_DIR}/packages;
export PACKAGE_DIRS=${PACKAGES}/somebodyelse:${PACKAGES}/${YOUR_NAME};
mkdir -p ${PACKAGES}/${YOUR_NAME}; mkdir -p ${PACKAGES}/somebodyelse;
export HAS_PACKAGE_DIRS=$(grep PACKAGE_DIRS ~/.profile | grep -c ${PACKAGES} ~/.profile);
[[ ${HAS_PACKAGE_DIRS} -lt 1 ]] && echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS}" >> ~/.profile;
source ~/.profile;
```
Continued . . . 
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L264" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a "self-sufficient" Meteor package.

... continuing.

Now that Meteor can find your packages, you can create one and install it in your project :
1. step into the directory you created earlier
2. use ```meteor create``` to create your package
3. use ```add``` to add the package to your project
4. use ```list``` to confirm the package was added.

#####Commands
```terminal
cd ~/${PARENT_DIR}/packages/${YOUR_NAME}
meteor create --package ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}
cd ~/${PARENT_DIR}/${PROJECT_NAME}
meteor add ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}
meteor list
```
Your package will be part of your project's run time, but not part of it at edit time. That's next . . .
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L279" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Working on your Meteor package.

One disadvantage of keeping packages outside your project directory is that you lose Meteor's automatic refresh on saving changes.

That's easily fixed.  You simply need to establish a symbolic link from your packages directory to the real package :
1. step into the packages directory of your project
2. create a symbolic link

#####Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/packages
ln -s ${PACKAGE_DIRS}/${YOUR_NAME}/${PKG_NAME} ${PKG_NAME}
```
For editing purposes your package now appears to be part of your project.  But wait!  It won't be "git managed", will it?!
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L344" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Package Version Control
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor package.

Another consequence of keeping packages outside your project directory is the need for a separate version control repository for each one.

The resulting modularity is benefical and the multiplication of git commands can be mitigated by using <a href="https://git-scm.com/book/en/v2/Git-Tools-Submodules" target="_blank">git submodules</a> *("Submodules allow you to keep a Git repository as a subdirectory of another Git repository.")*. Regardless of whether we go that way we must repeat the earlier steps to create [remote](#CreateRemoteGitHubRepository) and [local](#CreateLocalGitHubRepository) repositories, this time for ```${PKG_NAME}```.


#####Commands
Continuing . . . 
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L356" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Package Version Control
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor package
. . . continued.

#####Commands

<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L364" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### TinyTest a package.

Meteor makes unit testing of packages very easy. A single command and we can see test results every time we save a file.

In the accompanying script, the ampersand ```"&"``` causes Meteor package testing to start up as a background process.  In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

#####Commands
```terminal
meteor test-packages &
tree
```
To stop Meteor after you have confirmed that it ran successful tests, hit ```<enter>```.
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L373" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Runner for TinyTest
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add a test runner for getting TinyTest output on the command line

TinyTest pretty prints its results in the browser, but -- that's useless for continuous integration!  We must have test results on the command line. The Selenium wrapper [warehouseman:meteor-tinytest-runner](https://github.com/warehouseman/meteor-tinytest-runner) does that for us.

In this step we :
1. Get the installer for the test runner and then run it *(Note that it deletes itself after preparing everything for immediate use)*
3. Run all tests

##### Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.run
./meteor-tinytest-runner.run
./tests/tinyTests/test-all.sh
```
<!-- Code for this begins at line #311-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L402" target="_blank">Code for this step.</a>] ]
]
---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line ESLint 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use ESLint on the Command Line

We are ready with ESLint for the command line, and will have it for Sublime Text.  Both have advantages: the command line lists all code quality deficiencies which we need for continuous integration and editor based linting helps ensure code quality as we type.

The result should look like this :
```ruby
packages/${PKG_NAME}/${PKG_NAME}-tests.js
 3:14 error   Strings must use doublequote                 quotes
 3:25 warning Missing function expression name             func-names
 3:33 error   Unexpected space before function parentheses space-before-function-paren

✖ 3 problems (2 errors, 1 warning)
```
##### Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/
eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
```

<!-- Code for this begins at line #414-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L433" target="_blank">Code for this step.</a>] ]
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
  ### Sublime ESLint
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Customize the '.eslintrc' file

In Sublime Text :
1. go to the menu ```File >> Open Folder```
2. find and open our project ```~/${PARENT_DIR}/${PROJECT_NAME}```
3. begin editing the file ```.eslintrc```
4. search for ```/rules/quotes```
5. change 'double' to 'single'
```JSON
    'quotes': [
      2, 'single', 'avoid-escape'    // http://eslint.org/docs/rules/quotes
    ],
```
6. save the file :  ```File >> Save```

You have reconfigured the ESLint rule ```'quotes'```.  The complete list of configurable rules is available from <a target="blank" href="http://eslint.org/docs/rules/">eslint.org rules documentation</a>
<!-- B -->]
---
.left-column[
  ### Sublime ESLint
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Correct the indicated code-quality defects

In Sublime Text, make sure you're editing the same project as you opened in the previous slide, then :
1. begin editing the files ```./${PROJECT_NAME}.js``` and ```./packages/${PKG_NAME}/${PKG_NAME}-tests.js```
2. the former has ESLint deficiencies indicated, while the latter does not.
3. open ```./.eslintrc``` and save it as ```./packages/${PKG_NAME}/${PKG_NAME}-tests.js```.
4. close and reopen ```./packages/${PKG_NAME}/${PKG_NAME}-tests.js``` and deficiency flags will appear
5. click on line '3' and notice the status bar has a warning ```func-names``` and an error ```space-before-function-paren```
6. add ```checkSanity``` after the key word ```function``` to correct both defects

```javascript
Tinytest.add('example', function checkSanity(test) {
  test.equal(true, true);
});
```

<!-- B -->]
---
.left-column[
  ### Command Line ESLint
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Test again for code-quality defects

Return to the command line and rerun . . . 
```terminal
eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
```
. . . as you did for the earlier step ["Command Line ESLint"](#UseESLintOnTheCommandLine).

Great!  All clean!
<!-- Code for this begins at line #441-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L459" target="_blank">Code for this step.</a>] ]
]
---
name: TryJSDocFromTheCommandLinea
.left-column[
  ### Command Line jsDoc (Step #1)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line

JSDoc creates a documentation web site, in a directory you specify, like this :
```ruby
yourself@YourVM:~/projects/yourproject$ tree -L 2 ./packages/${PKG_NAME}
./packages/yourpackage
├── docs
│   ├── files.html
│   ├── index.html
│   └── symbols
│       ├── _global_.html
│       └── src
├── package.js
      :  etc
      :  etc
```
##### Commands
```terminal
jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
tree -L 2 ./packages/${PKG_NAME}
```
continued ...
<!-- Code for this begins at line #455-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L473" target="_blank">Code for this step.</a>] ]
]
---
name: TryJSDocFromTheCommandLineB
.left-column[
  ### Command Line jsDoc (Step #2)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line
... continuing.

If you open the index file in your browser from its file system location . . . 

 *(something like : [```file:///home/${YOUR_NAME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html```](file:///home/${YOUR_NAME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html))*

 . . . you will see a page a bit like this :

 ![http://i.imgur.com/LBfHmi3.png](http://i.imgur.com/LBfHmi3.png)

<!-- Code for this begins at line #471-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L491" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### jsDoc for ST3
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure Sublime Text to assist with jsDoc annotation

Now we add ```DocBlockr``` to Sublime Text.  [DocBlockr](https://github.com/spadgos/sublime-jsdocs) goes beyond jsDocs and helps add documentation annotations for many other languages than just JavaScript. 

Steps to perform :

 - Go to Preferences >> Package Control
 - In Package Control type : install package
 - Install 'DocBlockr'



<!-- B -->]
---
.left-column[
  ### jsDoc for ST3
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

A partially documented ```${PKG_NAME}-tests.js``` is available at [*martinhbramwell:Meteor-CI-Tutorial* -- ```/fragments/${PKG_NAME}-tests.js```](https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/${PKG_NAME}-tests.js) 

Let DocBlockr help finish the annotations for the ```'Check inequality'``` test, as explained in DocBlockr's [usage instructions](https://github.com/spadgos/sublime-jsdocs#usage).  Type ```/**``` followed by ```<enter>``` and DocBlockr will attempt to create appropriate tags.  You can ```<tab>``` and ```<shift-tab>``` back and forth between incomplete fields.

##### Commands
```terminal
WORKED=${PKG_NAME}-tests.js
GH_RAW=https://raw.githubusercontent.com
PRJ=martinhbramwell/Meteor-CI-Tutorial/master
wget -O ${WORKED} ${GH_RAW}/${PRJ}/fragments/${WORKED}
```

Continues . . .
<!-- Code for this begins at line #485-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L508" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### jsDoc for ST3
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

. . . continued.

 ![https://camo.githubusercontent.com/087348d3e797f4ccc91528459b0473f6d34eadf3/687474703a2f2f73706164676f732e6769746875622e696f2f7375626c696d652d6a73646f63732f696d616765732f6c6f6e672d617267732e676966](https://camo.githubusercontent.com/087348d3e797f4ccc91528459b0473f6d34eadf3/687474703a2f2f73706164676f732e6769746875622e696f2f7375626c696d652d6a73646f63732f696d616765732f6c6f6e672d617267732e676966)

```javascript
/**
 * @param  {[type]}
 * @return {[type]}
 */    
```

TinyTest's structure is unusual so those suggestions are poor. Simply copy from the 'Check Equality' test and adapt.  The use of the tags ```@namespace``` and ```@memberof Tinytest``` is just one of jsDoc's many workaround tricks for special cases.
 

<!-- Code for this begins at line #485-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L487" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### End Of Part #2 - Unit Test a Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding two parts covered the minimal basic set up tasks of a Meteor developer's work station with linting, automated documentation, unit testing and version control.  The next section will guide you through preparations for end-to-end testing and continuous integration *in-the-cloud*. 

[Part #3 - Cloud Continuous Integration](./?part=C)



<!-- B -->]
