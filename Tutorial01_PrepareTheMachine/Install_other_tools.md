---
last_update: 2016-02-11
 .left-column[
  ### Install other tools
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
#### Some basic tools ...

This sequence installs the following dependencies, if they're not already present :
- 'build-essential' and 'libssl-dev' are required by <a href="http://www.seleniumhq.org/projects/webdriver/" target="_blank">Selenium Webdriver</a>
- 'libappindicator1' for <a href='https://www.google.com/chrome/browser/desktop/' target='_blank'>Chrome</a>
- '<a href='http://curl.haxx.se/' target='_blank'>curl</a>' for <a href='https://www.meteor.com/' target='_blank'>Meteor</a>
- '<a href='https://git-scm.com/' target='_blank'>git</a>' and '<a href='http://www.openssh.com/' target='_blank'>ssh</a>' for version control.
'tree', 'expect', 'virt-what' and '<a href='https://pypi.python.org/pypi/pip' target='_blank'>pip</a>' for demo convenience

##### Example Commands
```ruby
sudo apt-get install -y build-essential libssl-dev       # for selenium webdriver
sudo apt-get install -y libappindicator1                 # for chrome
sudo apt-get install -y curl                             # for Meteor
sudo apt-get install -y git ssh                          # for version control
sudo apt-get install -y tree expect virt-what python-pip # for demo convenience
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L176" target="_blank">Code for this step.</a>] ]
]
