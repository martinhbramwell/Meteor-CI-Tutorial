---
.left-column[
  ### Left Title
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### End To End Testof the Usage Example

The accompanying script creates a new subdirectory of ${PKG_NAME} called ```nightwatch``` and, into it, downloads the <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/test_usage_example.js' target='_blank'>code for a usage example end-to-end test</a>.  *Nightwatch* needs to be told where to find it, so you should now edit ```${PROJECT_NAME}/tests/nightwatch/config/nightwatch.json``` to look like this :
```javascript
  "src_folders": [
    "./packages/ourpackage/nightwatch",   // ADD | <--
    "./tests/nightwatch/walkthroughs"
  ]
```
Then  re-run nightwatch testing with ```./tests/nightwatch/runTests.js```.
##### Commands
```terminal
wget -O test_usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/test_usage_example.js
./tests/nightwatch/runTests.js | bunyan
```

<!-- Code for this begins at line #22 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L22" target="_blank">Code for this step.</a>] ]
]
