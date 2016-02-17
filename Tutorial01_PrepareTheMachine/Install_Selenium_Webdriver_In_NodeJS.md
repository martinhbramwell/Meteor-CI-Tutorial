---
last_update: 2016-02-17
 .left-column[
  ### Selenium Web Driver for NodeJS
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install 'selenium-webdriver' in NodeJS

The <a href='https://nodejs.org/' target='_blank'>NodeJS</a> module <a href='https://github.com/SeleniumHQ/selenium' target='_blank'>Selenium Webdriver</a> is required for running Meteor TinyTest on the command line, rather than in a browser.  **Note**: The next step after this one installs a different Selenium driver.

We must first ensure that root has not taken ownership of the local .npm directory *(that can happen if you ran npm with sudo when you didn't need to)*.

##### Example Commands
```ruby
sudo chown -R ${USER}:${USER} ~/.npm
sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/node_modules
npm install -y --prefix ${HOME} selenium-webdriver
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L137" target="_blank">Code for this step.</a>] ]
]
