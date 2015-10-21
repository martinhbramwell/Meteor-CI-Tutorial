---
.left-column[
  ### Finish Documentation
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### The Package Works But It Is Not Documented

<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js' target='_blank'>yourpackage_documented.js</a> and <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js' target='_blank'>usage_example_documented.js</a> are documented replacements for the previously created files ```${PKG_NAME}.js``` and ```usage_example.js```.<div style="word-wrap:break-word;">Rerunning jsDoc now will generate a much more complete documentation site than before.  View it locally at : <a href='file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html' target='_blank'>```file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html```</a>.

Be aware that we still need to commit the docs directory to the ```gh-pages``` branch of the package repo so as to publish it as GitHub Pages.  Our CI system must be able to do that.</div>

##### Commands
```terminal
wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js
wget -O usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js
jsdoc -d ./docs . ./nightwatch
```

Continues ...

<!-- Code for this begins at line #52 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L52" target="_blank">Code for this step.</a>] ]
]
