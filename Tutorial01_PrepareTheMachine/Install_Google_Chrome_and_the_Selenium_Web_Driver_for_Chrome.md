---
last_update: 2016-01-05
 .left-column[
  ### Install Selenium Web Driver
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L254" target="_blank">Code for this step.</a>] ]
]
