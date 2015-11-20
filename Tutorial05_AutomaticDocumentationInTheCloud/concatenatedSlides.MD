layout: false
.left-column[
  ### PART E INTRODUCTION

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Code Quality - Automatic Documentation in the Cloud

These scripts will get you started easily with Meteor package development, testing, documenting, logging, code style linting and continuous integration.

The previous script, 'Tutorial04_CodingStyleAndLinting.sh', set up code quality checks.

This one . . .  
```terminal
./Tutorial05_AutomaticDocumentationInTheCloud.sh
```
. . . continues the componentization efforts of earlier parts, by making it very easy to document the code and the tests of each package as it is developed.



<!-- B -->]
---
name: TryJSDocFromTheCommandLine_A
.left-column[
  ### Command Line jsDoc (Step #1)
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line

In a directory you specify, JSDoc creates a documentation web site like this :
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
##### Example Commands
```terminal
jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
tree -L 2 ./packages/${PKG_NAME}
```
continued ...
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L1" target="_blank">Code for this step.</a>] ]
]
---
name: TryJSDocFromTheCommandLine_B
.left-column[
  ### Command Line jsDoc (Step #2)
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use jsDoc on the Command Line
... continuing.

If you open the index file in your browser from its file system location . . . 

 *(something like : [```file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html```](file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html))*

 . . . you will see a page a bit like this :

 ![http://i.imgur.com/LBfHmi3.png](http://i.imgur.com/LBfHmi3.png)

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L16" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### jsDoc for ST3
  <br /><br /><div class="input_type_indicator"><img src="./fragments/typer.gif" /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure Sublime Text to assist with jsDoc annotation

Now we add ```DocBlockr``` to Sublime Text.  <a href='https://github.com/spadgos/sublime-jsdocs' target='_blank'>DocBlockr</a> goes beyond jsDocs and helps add documentation annotations for many other languages than just JavaScript.

Steps to perform :

 - Go to Preferences >> Package Control
 - In Package Control type : install package
 - Install 'DocBlockr'


<!-- B -->]
---
.left-column[
  ### jsDoc for ST3
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

DocBlockr tries to help finish annotations begun with ```/**```, as explained in the <a href='https://github.com/spadgos/sublime-jsdocs#usage' target='_blank'>usage instructions</a>.

 ![https://camo.githubusercontent.com/087348d3e797f4ccc91528459b0473f6d34eadf3/687474703a2f2f73706164676f732e6769746875622e696f2f7375626c696d652d6a73646f63732f696d616765732f6c6f6e672d617267732e676966](https://camo.githubusercontent.com/087348d3e797f4ccc91528459b0473f6d34eadf3/687474703a2f2f73706164676f732e6769746875622e696f2f7375626c696d652d6a73646f63732f696d616765732f6c6f6e672d617267732e676966)

Here is a partially documented <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/package-tests_T05_05.js' target='_blank'>```yourpackage-tests.js```</a>

##### Example Commands
```ruby
wget -O ${PKG_NAME}-tests.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/package-tests_T05_05.js
```

Continues . . .
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L24" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### jsDoc for ST3
  <br /><br /><div class="input_type_indicator"><img src="./fragments/typer.gif" /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

. . . continued.

To have DocBlockr help finish the annotations for ```'Check inequality'``` type ```/**``` followed by ```<enter>```. It will attempt to create appropriate tags.  You can ```<tab>``` and ```<shift-tab>``` back and forth between incomplete fields.

TinyTest's structure is atypical -- so the suggestions are less useful than usual.

```javascript
/**
 * [sanityCheckNEQ description]
 * @param  {[type]} test) { test.notEqual(true, false);} [description]
 * @return {[type]} [description]
 */
```

Simply copy from the 'Check Equality' test and adapt.  The use of the tags ```@namespace``` and ```@memberof Tinytest``` is just one of jsDoc's many workaround tricks for special cases.

Continues . . .
<!-- B -->
]
---
.left-column[
  ### jsDoc for ST3
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

.img_right[
  <a href="http://i.imgur.com/VX85WIE.png" target="_blank">![example](http://i.imgur.com/LY7yErF.png)<br/>click to enlarge</a>
]
. . . continued.

If you run the jsdoc command again you should see an improved main page with a ```TinyTest``` link under a section header "Namespaces".

Click on the ```TinyTest``` link and you should see something like the image to the right.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L46" target="_blank">Code for this step.</a>] ]
]
---
name: PublishJsDocsToGitHub_A
.left-column[
  ### 'GitHub Pages' Web Site
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Your jsDoc Documents as a GitHub Pages Website
<a href="https://help.github.com/articles/what-are-github-pages/" target="_blank">The user guide for "GitHub Pages"</a>, shows how GitHub can publish <a href="https://help.github.com/articles/creating-project-pages-manually/" target="_blank">a special branch of your repository</a> as a web site.

In the next step we run a script that automates :
 - checking out the 'gh-pages' branch
 - decompressing a zipped copy of our docs
 - committing the 'gh-pages' branch & pushes to GitHub
 - returning to the current branch
 
For safety sake, the script includes a number of checks and validations :
 - the directory must contain the specified repository
 - the current branch must be fully committed and pushed to GitHub
 - there is a valid zip file of a docs directory

Finally, if no 'gh-pages' branch exists, it will create one.

Continued . . .

<!-- B -->]
---
name: PublishJsDocsToGitHub_B
.left-column[
  ### 'GitHub Pages' Web Site
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Your jsDoc Documents as a GitHub Pages Website

Shortly after this step completes, you would expect to find your documentation on the web. You won't find it; instead you'll get a 404 error.  GitHub has <a href="https://help.github.com/articles/troubleshooting-github-pages-build-failures/#deploy-key-used-for-push" target="_blank">a rule</a> about ```gh-pages``` and deploy keys.  The fix is to edit a file online in the repo (eg, README.md) and save it.  However. **first** you must verify your user email address!  After that, (as an implicit by a verified user) the site will appear at :  <a href="https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/" target="_blank">https://${GITHUB_ORG_NAME}.github.io/${PKG_NAME}/</a>.

##### Example Commands
```terminal
zip -qr /tmp/${PKG_NAME}_docs.zip *
git checkout gh-pages
unzip -o /tmp/${PKG_NAME}_docs.zip
git add docs/*
git commit -am "Preliminary package documentation."
git push
./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} .tmp_docs.zip
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L59" target="_blank">Code for this step.</a>] ]
]

---
.left-column[
    ### End Of Part #E
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding five parts covered the minimal basic set up tasks of a Meteor developer's work station with linting, automated documentation, unit testing and version control.  The next section will guide you through preparations for end-to-end testing and continuous integration *in-the-cloud*. 

[Part #F - Cloud Continuous Integration](./?part=F)



<!-- B -->]
