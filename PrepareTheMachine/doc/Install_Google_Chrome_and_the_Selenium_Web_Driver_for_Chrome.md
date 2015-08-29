---
.left-column[
  ### Install Selenium Web Driver
.footnote[.red.bold[] [Back to TOC](./)] 
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

<!-- B -->]
