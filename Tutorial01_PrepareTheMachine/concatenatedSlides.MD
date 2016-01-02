layout: false
last_update: 2016-01-02
last_update: 2016-01-02
 .left-column[
  ### Part A INTRODUCTION

.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

##  Prepare the Machine

These scripts will get you started easily with continuous integration development, testing, documenting, logging, code style linting of Meteor packages.

This first script, run with . . .
```terminal
sudo ./Tutorial01_PrepareTheMachine.sh
```
. . . sets up all necessary preconditions for the remaining scripts.  As much as possible, this first step handles all tasks that require root access.

You can hit the 'a' key at any of the pause points to have it run **a**ll the remaining steps without further interruption.

(Yes, ```apt-get update``` does get called too often; but the point is to show each step separately and clearly.)

<!-- B -->]
---
layout: false
last_update: 2016-01-02
 .left-column[
  ### Java required
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

#### Java 7 is required by Nightwatch
Java 7 is required by Selenium, which is required by Nightwatch.  Selenium seems to hold the strategic high ground when it comes to remote control of web applications.  Moreover, the Android SDK specifies Oracle JDK, so like it or not, you gotta install Oracle's Java.  Steps performed :
 - Gets the <a href="https://en.wikipedia.org/wiki/Personal_Package_Archive" target="_blank">PPA</a> for <a href="http://www.oracle.com/technetwork/indexes/downloads/index.html?ssSourceSiteId=ocomen" target="_blank">Oracle Java</a>
 - installs it

**Legal Notice** : Normally, the PPA installer will prompt you to accept Oracle's license.  If you run this step . . . **you accept the license agreement, implicitly!**

##### Example Commands
```terminal
  sudo add-apt-repository -y ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get -y install oracle-java7-installer
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L145" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Install other tools
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

#### Some basic tools ...

This sequence installs the following dependencies, if they're not already present :
- 'build-essential' and 'libssl-dev' are required by <a href="http://www.seleniumhq.org/projects/webdriver/" target="_blank">Selenium Webdriver</a>
- 'libappindicator1' for <a href='https://www.google.com/chrome/browser/desktop/' target='_blank'>Chrome</a>
- '<a href='http://curl.haxx.se/' target='_blank'>curl</a>' for <a href='https://www.meteor.com/' target='_blank'>Meteor</a>
- '<a href='https://git-scm.com/' target='_blank'>git</a>' and '<a href='http://www.openssh.com/' target='_blank'>ssh</a>' for version control
- 'tree' and '<a href='https://pypi.python.org/pypi/pip' target='_blank'>pip</a>' for demo convenience

##### Example Commands
```terminal
sudo apt-get install -y build-essential libssl-dev  # for selenium webdriver
sudo apt-get install -y libappindicator1            # for chrome
sudo apt-get install -y curl                        # for Meteor
sudo apt-get install -y git ssh                     # for version control
sudo apt-get install -y tree expect python-pip      # for demo convenience
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L172" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Install NodeJS
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

#### NodeJS

<a href='http://nightwatchjs.org/' target='_blank'>Nightwatch</a> is a <a href='https://nodejs.org/' target='_blank'>NodeJS</a> utility.

You must have NodeJS to do Nightwatch testing.

It can run on a separate computer from <a href='https://www.meteor.com/' target='_blank'>Meteor</a>, (but we'll do it all in this one).

##### Example Commands
```terminal
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
sudo apt-get -y autoremove
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L217" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Selenium Web Driver for NodeJS
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

#### Install 'selenium-webdriver' in NodeJS

The <a href='https://nodejs.org/' target='_blank'>NodeJS</a> module <a href='https://github.com/SeleniumHQ/selenium' target='_blank'>Selenium Webdriver</a> is required for running Meteor TinyTest on the command line, rather than in a browser.  **Note**: The next step after this one installs a different Selenium driver.

We must first ensure that root has not taken ownership of the local .npm directory *(that can happen if you ran npm with sudo when you didn't need to)*.

##### Example Commands
```terminal
sudo chown -R ${USER}:${USER} ~/.npm
sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/node_modules
npm install -y --prefix ${HOME} selenium-webdriver
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L231" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Install Selenium Web Driver
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

#### Install Google Chrome and the Selenium Web Driver for Chrome.

<a href='http://nightwatchjs.org/' target='_blank'>Nightwatch</a> leverages <a href='http://www.seleniumhq.org/' target='_blank'>Selenium</a>, which has drivers for the major browsers.

The <a href='https://code.google.com/p/selenium/wiki/ChromeDriver' target='_blank'>Chrome Driver</a> is the most convenient.  **Note**: This is not the Selenium Webdriver for NodeJS installed in the previous step.

##### Example Commands
```terminal
wget http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux${CPU_WIDTH}.zip
sudo unzip -o chromedriver_linux${CPU_WIDTH}.zip -d /usr/local/bin
sudo chmod a+rx /usr/local/bin/chromedriver
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd${CPU_WIDTH}.deb
sudo dpkg -i google-chrome-stable_current_amd${CPU_WIDTH}.deb
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L250" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Install Bunyan
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

#### Install 'bunyan'

Bunyan is a logging package with the special advantage of writing run-time logs as JSON.

This makes subsequent analysis and long-term storage of production system logs much more efficient.

It is in two parts :
 - a local node module to replace 'console.log'
 - a global module that reads Bunyan JSON and reformats for different uses, including stdout.

For ongoing server side logging during development or production we need a permanent home for the logs.  The standard place for that in Ubuntu is ```/var/log/```.  So we also need to create a directory for Meteor with suitable permissions.


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L288" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Install Sublime Text 3 editor
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

#### This tutorial uses Sublime Text 3.

It also expects to be run in a virtual machine; for later destruction.  While you likely have your own preferred text editor, this will introduce the general idea of in-editor linting, which you can then adapt to your own taste.
 
Steps performed :
 - gets the <a href='https://en.wikipedia.org/wiki/Personal_Package_Archive' target='_blank'>PPA</a> for <a href='http://www.sublimetext.com/3' target='_blank'>Sublime Text 3</a>
 - installs it. 
 
If you just want to quickly follow the tutorial, then *do* execute this group of commands, otherwise install your usual editor/IDE.

##### Example Commands
```terminal
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install -y sublime-text-installer
sudo pip install -y beautifulsoup4 requests
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L316" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Set Up Linting
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

#### Install “eslint”.

Linting detects code style contraventions, improves maintainability, and flags many hard-to-debug errors before they happen.

<a href='http://eslint.org/docs/about/' target='_blank'>ECMA Script linter</a> : 
  - thorough Linter for ECMA Script 6 and earlier
  - preferred by Facebook, AirBnB and many other big names

##### Example Commands
```terminal
sudo npm install -y eslint
sudo npm install -y eslint-plugin-react
sudo npm install -y babel-eslint
```

There is a closely related ESLint package for Sublime Text.  We will install it in the next section.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L356" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Set Up Automatic Documentation
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

#### Install “JSDoc”.

JSDoc can generate a very sophisticated documentation web site for you, directly from annotations you make in your code.  When you use JSDoc together with an annotations package in your text editor, documenting your work simply becomes an integral part of how you think about it.

<a href='http://usejsdoc.org/' target='_blank'>jsdoc.org</a> : 
  - very detailed and complete documentation generator
  - used by Google for controlling data types in <a href="https://developers.google.com/closure/compiler/docs/js-for-compiler" target="_blank">their JavaScript compiler.</a>

##### Example Commands
```terminal
sudo npm install -y jsdoc
```

There is a closely related JSDoc package for Sublime Text, which we will install in the next section.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L386" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Prepare Sublime Text (Step #1)
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

### Preparation of Sublime Text
#### First step - add '<a href='https://packagecontrol.io/' target='_blank'>Package Control</a>'

We need <a href='http://www.sublimetext.com/3' target='_blank'>Sublime Text 3</a> configured as follows :

 - In your browser, go to the <a href='https://packagecontrol.io/installation' target='_blank'>Package Control installer URL</a>
 - Copy the code snippet for **Sublime Text 3**
 - Find Sublime Text in ```Start >> Development```, add it to the panel and start it up.
 - Go to ```View >> Show Console```, to open the Console
 - Paste the snippet into ST3's console, hit enter and respond to the two prompts.
 - Go to ```View >> Hide Console```, to close the Console

##### Example Commands
```terminal
export ST3URL="https://packagecontrol.io/installation#st3";
python -c "import requests;from bs4 import BeautifulSoup;print '>>>';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L402" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Prepare Sublime Text (Step #2)
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

### Preparation of Sublime Text
#### Second step - Use '<a href='https://packagecontrol.io/' target='_blank'>Package Control</a>' to install more packages.

 - Go to Preferences >> Package Control
 - In Package Control select : install package
 - Install these two packages :
   - 'MarkDownEditing'
   - 'SideBarEnhancements'
 - (Optional) In Preferences
   - Color Scheme
     - Color Scheme - Default --> pick ```IDLE```

<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### End Of Part #A
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section ...

The preceding section required 'sudo' at nearly every step. Following sections, on the other hand, must run **without** sudo.

Your virtual machine should now have all necessary system wide installations.

The next part will guide you through the minimal basic set up tasks of a Meteor developer's work station with linting, unit testing and version control.

[Part #B - Version Control In The Cloud](./?part=B)



<!-- B -->]
