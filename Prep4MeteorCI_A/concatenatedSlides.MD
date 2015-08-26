layout: false
.left-column[
  ### Part A INTRODUCTION


.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

These scripts prepare the way for you to get started easily with Meteor package development, testing, documenting, code style linting and continuous integration

They are designed for a small (10GB) Xubuntu 14.04 virtual machine. They have not been tested in any other environment since the idea is to provide clear proven instructions that can be adapted easily to other circumstances.

Except where indicated, the scripts are 'idempotent' -- you can run them repeatedly without adverse consequences.

The first script 'Prep4MeteorCI_A.sh' sets up all necessary preconditions for the second script.

The second one 'Prep4MeteorCI_B.sh' takes you  through the entire process of preparing a Meteor project and package with  all the previously mentioned application development support tools.

<!-- -->]
---
layout: false
.left-column[
  ### Java required
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Java 7 is required by Nightwatch. 

Steps performed :
 - Gets the PPA for Oracle Java
 - installs it

**Note : **

Normally, the PPA installer will prompt you to accept Oracle's license.  If you run this step . . . 

     you accept the license agreement, implicitly!

<!-- -->]
---
.left-column[
  ### Install Sublime Text 3 editor. 
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### This tutorial expects you to edit with Sublime Text 3.

It also expects to be run in a virtual machine; for later destruction.
 
Steps performed :
 - Gets the PPA for Sublime Text 3
 - installs it. 
 
If you just want to quickly follow the tutorial then *do* execute this group of commands.


<!-- -->]
---
.left-column[
  ### Install other tools 
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Some basic tools ...

This sequence installs the following dependencies, if they're not already present :
- 'build-essential' and 'libssl-dev' for selenium webdriver 
- 'libappindicator1' for chrome 
- 'curl' for Meteor 
- 'git' and 'ssh' for version control
- 'tree' for demo convenience 


<!-- -->]
---
.left-column[
  ### Install NodeJS
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### NodeJS

Nightwatch is a NodeJS utility.

You must have NodeJS to do Nightwatch testing.

It can run on a separate computer from Meteor, (but we'll do it all in this one).


<!-- -->]
---
.left-column[
  ### Install Selenium Web Driver
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install Google Chrome and the Selenium Web Driver for Chrome.

Nightwatch leverages Selenium, which has drivers for the major browsers.

The Chrome driver is the most convenient.

<!-- -->]
---
.left-column[
  ### Set Up Linting
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install “eslint” and configure Sublime Text 3.

Linting : detects code style contraventions, and traps many
  hard to debug errors before they happen.

ECMA Script linter : 
  - thorough Linter for ECMA Script 6 and earlier
  - preferred by Facebook, AirBnB and many other big names

Learn more : [ESLint](http://eslint.org/docs/about/)


<!-- -->]
---
.left-column[
  ### Prepare Sublime Text (Step #1)
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

### (Optional) Preparation of Sublime Text 
#### First step

We need Sublime Text 3 configured as follows :

 - Find Sublime Text in 'Start >> Development', add it to the panel and start it up.
 - Go to View >> Show Console
 - Paste the following into ST3's console :

.small[
```terminal
# - - - snip - - - 
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
# - - - snip - - - 

```
]


<!-- -->]
---
.left-column[
  ### Prepare Sublime Text (Step #2)
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

### (Optional) Preparation of Sublime Text 
#### Second step

 - Go to Preferences >> Package Control
 - In Package Control type : install package
 - Install these two packages :
   - 'MarkDownEditing'
   - 'SideBarEnhancements'
 - In Preferences 
   - Color Scheme 
     - Color Scheme - Default --> pick ```IDLE```

<!-- -->]
---
.left-column[
  ### End Of Part A
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Got to the next section

The previous section require 'sudo' at nearly every step.

The next section must run **without** sudo.

[Part B](../Prep4MeteorCI_B/index.html)
[](Prep4MeteorCI_B)


<!-- -->]
