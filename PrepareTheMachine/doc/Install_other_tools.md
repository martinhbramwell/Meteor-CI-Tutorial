---
.left-column[
  ### Install other tools 
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Some basic tools ...

This sequence installs the following dependencies, if they're not already present :
- 'build-essential' and 'libssl-dev' are required by [Selenium Webdriver](http://www.seleniumhq.org/projects/webdriver/)
- 'libappindicator1' for [Chrome](https://www.google.com/chrome/browser/desktop/)
- '[curl](http://curl.haxx.se/)' for [Meteor](https://www.meteor.com/)
- '[git](https://git-scm.com/)' and '[ssh](http://www.openssh.com/)' for version control
- 'tree' for demo convenience 

##### Commands
```terminal
  apt-get install -y build-essential libssl-dev  # for selenium webdriver
  apt-get install -y libappindicator1            # for chrome
  apt-get install -y curl                        # for Meteor
  apt-get install -y tree                        # for demo convenience
  apt-get install -y git ssh                     # for version control
```


<!-- -->]
