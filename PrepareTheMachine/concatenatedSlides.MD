layout: false
.left-column[
  ### Part A INTRODUCTION


.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

These scripts will get you started easily with Meteor package development, testing, documenting, code style linting and continuous integration.

This first script, 'Step01_PrepareTheMachine.sh', sets up all necessary preconditions for the second script.  As much as possible, this first step handles all tasks that require root access.

You can hit the 'a' key at any of the pause points to have it run **a**ll the remaining steps without further interruption.

(Yes, ```apt-get update``` gets called too often; the point is to show each step separately and clearly.)

<!-- B -->]
---
layout: false
.left-column[
  ### Java required
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Java 7 is required by Nightwatch. 
Java 7 is required by Selenium which is required by Nightwatch.  Selenium seems to hold the strategic high ground when it comes to testing web applications, so like it, or not, you gotta install Java.

Steps performed :
 - Gets the [PPA](https://en.wikipedia.org/wiki/Personal_Package_Archive) for [Oracle Java](http://www.oracle.com/technetwork/indexes/downloads/index.html?ssSourceSiteId=ocomen)
 - installs it

**Legal Notice** : Normally, the PPA installer will prompt you to accept Oracle's license.  If you run this step . . . **you accept the license agreement, implicitly!**

##### Commands
```terminal
  add-apt-repository -y ppa:webupd8team/java
  apt-get update
  apt-get -y install oracle-java7-installer
```
<!-- Code for this begins at line #44-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L45" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install other tools 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Some basic tools ...

This sequence installs the following dependencies, if they're not already present :
- 'build-essential' and 'libssl-dev' are required by [Selenium Webdriver](http://www.seleniumhq.org/projects/webdriver/)
- 'libappindicator1' for [Chrome](https://www.google.com/chrome/browser/desktop/)
- '[curl](http://curl.haxx.se/)' for [Meteor](https://www.meteor.com/)
- '[git](https://git-scm.com/)' and '[ssh](http://www.openssh.com/)' for version control
- 'tree' and '[pip](https://pypi.python.org/pypi/pip)' for demo convenience 

##### Commands
```terminal
  apt-get install -y build-essential libssl-dev  # for selenium webdriver
  apt-get install -y libappindicator1            # for chrome
  apt-get install -y curl                        # for Meteor
  apt-get install -y git ssh                     # for version control
  apt-get install -y tree python-pip            # for demo convenience
```


<!-- Code for this begins at line #59-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L60" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install NodeJS
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### NodeJS

[Nightwatch](http://nightwatchjs.org/) is a [NodeJS](https://nodejs.org/) utility.

You must have NodeJS to do Nightwatch testing.

It can run on a separate computer from [Meteor](https://www.meteor.com/), (but we'll do it all in this one).
##### Commands
```terminal
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  apt-get install -y nodejs
  apt-get -y autoremove
```


<!-- Code for this begins at line #70-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L71" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install Selenium Web Driver
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install Google Chrome and the Selenium Web Driver for Chrome.

[Nightwatch](http://nightwatchjs.org/) leverages [Selenium](http://www.seleniumhq.org/), which has drivers for the major browsers.

The [Chrome Driver](https://code.google.com/p/selenium/wiki/ChromeDriver) is the most convenient.  **Note**: This is not the Selenium Webdriver for NodeJS installed in the previous step.
##### Commands
```terminal
wget http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
unzip -o chromedriver_linux64.zip -d /usr/local/bin
chmod a+rx /usr/local/bin/chromedriver
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
```

<!-- Code for this begins at line #93-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L94" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install Bunyan
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
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


<!-- Code for this begins at line #113-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step02_UnitTestThePackage.sh#L114" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Selenium Web Driver for NodeJS
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install 'selenium-webdriver' in NodeJS

The [NodeJS](https://nodejs.org/) module [Selenium Webdriver](https://github.com/SeleniumHQ/selenium) is required for running Meteor TinyTest on the command line, rather than in a browser.  **Note**: The next step after this one installs a different Seleniun driver.

We must first ensure that root has not taken ownership of the local .npm directory *(that can happen if you ran npm with sudo when you didn't need to)*.
##### Commands
```terminal
sudo chown -R ${USER}:${USER} ~/.npm
npm install -y --prefix ${HOME} selenium-webdriver
```


<!-- Code for this begins at line #82-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L83" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install Sublime Text 3 editor. 
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### This tutorial uses Sublime Text 3.

It also expects to be run in a virtual machine; for later destruction.  You most likely have your own preferred test editor.  This will show the general principle of simultaneous editor and CI linting.
 
Steps performed :
 - gets the [PPA](https://en.wikipedia.org/wiki/Personal_Package_Archive) for [Sublime Text 3](http://www.sublimetext.com/3)
 - installs it. 
 
If you just want to quickly follow the tutorial then *do* execute this group of commands, otherwise install your usual editor/IDE.  Slimetits ain't bad, tho'.
##### Commands
```terminal
  add-apt-repository -y ppa:webupd8team/sublime-text-3
  apt-get update
  apt-get install -y sublime-text-installer
  pip install -y beautifulsoup4 requests
```

<!-- Code for this begins at line #129-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L130" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Set Up Linting
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install “eslint”.

Linting detects code style contraventions, improves maintainability, and flags many hard-to-debug errors before they happen.

[ECMA Script linter](http://eslint.org/docs/about/) : 
  - thorough Linter for ECMA Script 6 and earlier
  - preferred by Facebook, AirBnB and many other big names
##### Commands
```terminal
npm install -gy eslint
npm install -gy eslint-plugin-react
npm install -gy babel-eslint
```


<!-- Code for this begins at line #144-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L145" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Prepare Sublime Text (Step #1)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

### (Optional) Preparation of Sublime Text 
#### First step - add '[Package Control](https://packagecontrol.io/)'

We need [Sublime Text 3](http://www.sublimetext.com/3) configured as follows :

 - In your browser, go to the [Package Control installer URL](https://packagecontrol.io/installation)
 - Copy the code snippet for **Sublime Text 3**
 - Find Sublime Text in 'Start >> Development', add it to the panel and start it up.
 - Go to View >> Show Console, to open the Console
 - Paste the snippet into ST3's console, hit enter and respond to the prompts.
 - Go to View >> Hide Console, to close the Console
#####Commands
```terminal
export ST3URL="https://packagecontrol.io/installation#st3";
python -c "import requests;from bs4 import BeautifulSoup;print '>>>';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
```
<!-- Code for this begins at line #153-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Step01_PrepareTheMachine.sh#L155" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Prepare Sublime Text (Step #2)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

### (Optional) Preparation of Sublime Text 
#### Second step - Use '[Package Control](https://packagecontrol.io/)' to install more packages.

 - Go to Preferences >> Package Control
 - In Package Control select : install package
 - Install these two packages :
   - 'MarkDownEditing'
   - 'SideBarEnhancements'
 - In Preferences 
   - Color Scheme 
     - Color Scheme - Default --> pick ```IDLE```

<!-- B -->]
---
.left-column[
  ### End Of Part #1 - Prepare the Machine
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section ...

The preceding section required 'sudo' at nearly every step. Following sections, on the other hand, must run **without** sudo.

Your virtual machine should now have all necessary system wide installations.

The next part will guide you through the minimal basic set up tasks of a Meteor developer's work station with linting, unit testing and version control.

[Part #2 - Unit Test a Package](./?part=B)


<!-- B -->]
