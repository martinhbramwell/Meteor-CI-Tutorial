layout: false
.left-column[
  ### PART B INTRODUCTION
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

These scripts will get you started easily with Meteor package development, testing, documenting, code style linting and continuous integration.

The previous script, 'Step01_PrepareTheMachine.sh', set up necessary preconditions for the second script, basically all tasks that require root access. 

This one . . .  
```terminal
Step02_UnitTestThePackage.sh
```
. . . prepares a Meteor project with an embedded package ready for testing with TinyTest using the first few of the previously mentioned application development support tools.

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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L33" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L44" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L69" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L113" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L140" target="_blank">Code for this step.</a>] ]
]
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

 - Log in to [GitHub](https://github.com/) and create a project with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L202" target="_blank">Code for this step.</a>] ]
]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L238" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor package.

Meteor makes creating a package very easy, but it's deceptive if you aim for the flexibility of "package only applications".  If packages are to be reusable, they need their own independent version control, which means they need a directory outside of the project, whose location is defined by Meteor's shell variable ```PACKAGE_DIRS```.

To create self-sufficient packages, begin by defining ```PACKAGE_DIRS```, as a permanent fixture of your user profile, pointing to the place where you will keep your packages.
#####Commands
```terminal
export PACKAGE_DIRS=~/projects/packages
mkdir -p ${PACKAGE_DIRS}/yourself
mkdir -p ${PACKAGE_DIRS}/somebodyelse
echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS}" >> ~/.profile
```
Continued . . . 
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L259" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create a Meteor Package
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
cd ${PACKAGE_DIRS}/yourself
meteor create --package yourself:yourpackage
cd ~/projects/${PROJECT_NAME}
meteor add yourself:yourpackage
meteor list
```
Your package will be part of your project's run time, but not part of it at edit time. That's next . . .
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L272" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Altering your Meteor package.

One disadvantage of keeping packages outside your project directory is that you lose Meteor's automatic refresh on saving changes.

That's easily fixed.  You simply need to establish a symbolic link from your packages directory to the real package :
1. step into the packages directory of your project
2. create a symbolic link

#####Commands
```terminal
cd ~/projects/${PROJECT_NAME}
ln -s ${PACKAGE_DIRS}/yourself/yourpackage ./packages/yourpackage
```
For editing purposes your package now appears to be part of your project.
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L289" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### TinyTest a package.

Meteor makes this very easy. Two commands and we have a unit tested package.

Meteor will start up as a background process in TinyTest mode.

In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

Notice the files newly added under the package directory.  These will also have to be pushed to GitHub.
#####Commands
```terminal
meteor create --package yours:skeleton
meteor test-packages &
tree
```

<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L305" target="_blank">Code for this step.</a>] ]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L336" target="_blank">Code for this step.</a>] ]
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

In a terminal session execute these commands:
```terminal
cd ~/projects/${PROJECT_NAME}/
eslint ./packages/skeleton/skeleton-tests.js
```

The result should look like this :
```ruby
packages/skeleton/skeleton-tests.js
 3:14 error   Strings must use doublequote                 quotes
 3:25 warning Missing function expression name             func-names
 3:33 error   Unexpected space before function parentheses space-before-function-paren

✖ 3 problems (2 errors, 1 warning)
```

<!-- B -->]
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
2. find and open our project ```~/projects/${PROJECT_NAME}```
3. begin editing the file ```.eslintrc```
4. search for ```/rules/quotes```
5. change 'double' to 'single'
```JSON
    'quotes': [
      2, 'single', 'avoid-escape'    // http://eslint.org/docs/rules/quotes
    ],
```
6. save the file :  ```File >> Save```

You have reconfigured the ESLint rule ```'quotes'```.  The complete list of configurable rules is available from <a target="blank" href="http://eslint.org/docs/rules/">eslint.org</a>
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
1. begin editing the file ```skeleton-tests.js```
2. click on line '3' and notice the status bar has a warning ```func-names``` and an error ```space-before-function-paren```
3. adding ```checkSanity``` after the key word ```function``` corrects both defects

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
eslint ./packages/skeleton/skeleton-tests.js
```
. . . as you did for the earlier step ["Command Line ESLint"](#UseESLintOnTheCommandLine).

Great!  All clean!
<!-- B -->]
---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line jsDoc (Step #1)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line

In a terminal session execute these commands:
```terminal
cd ~/projects/${PROJECT_NAME}/
jsdoc -d=./packages/skeleton/doc ./packages/skeleton
tree -L 3 ./packages/skeleton
```
The result should look like this :
```ruby
yourself@YourVM:~/projects/yourProj$ tree -L 3 ./packages/skeleton
./packages/skeleton
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
continued ...
<!-- B -->]
---
name: UseESLintOnTheCommandLine
.left-column[
  ### Command Line jsDoc (Step #2)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line
... continuing.

If you open the index file ```file:///home/yourself/projects/yourProj/packages/skeleton/docs/index.html``` in your browser you will see something like :

 ![this](http://i.imgur.com/FBWR5wO.png)

<!-- B -->]
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
  ### End Of Part #2 - Unit Test a Package
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding two parts covered the minimal basic set up tasks of a Meteor developer's work station with linting, unit testing and version control.  The next section will guide you through preparations for end-to-end testing and continuous integration, *in-the-cloud*. 

[Part #3 - Cloud Continuous Integration](./?part=C)



<!-- B -->]
