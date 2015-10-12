layout: false
.left-column[
  ### PART I Introduction

.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Package Self Test

A major benefit of freely publishing a useful package is the feedback and collaboration that can come back to you.  However, the quality of the code, documention and tests, can convince or repel would-be contributors. If I can fork your repo, push it to continuous integration and see it thoroughly tested and see its documentation generated without intervention, I will be confident that Ì can contribute easily to an enduring project.

In this step we will finalize our code annotations, automate running and verifying the usage example and then complete our ```circle.yml``` file so that documentation generation and the verfication of usage examples all run automatically in CircleCI.

Get started now by running ...
```terminal
./Part09_PackageSelfTest.sh
```



<!-- B -->]
---
.left-column[
  ### Revisit End-To-End Testing
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### End To End Test of the Usage Example

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
---
.left-column[
  ### Finish Documentation
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### The Package Works But It Is Not Documented

<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js' target='_blank'>yourpackage_documented.js</a> and <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js' target='_blank'>usage_example_documented.js</a> are documented replacements for the previously created files ```${PKG_NAME}.js``` and ```usage_example.js```.<div style="word-wrap:break-word;">Rerunning jsDoc now will generate a much more complete documentation site than before.  View it at : <a href='file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html' target='_blank'>```file:///home/${USER}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html```</a></div>

##### Commands
```terminal
pushd ./packages/${PKG_NAME};
wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js
wget -O usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js
jsdoc -d ./docs . ./nightwatch
popd;
```

Continues ...

<!-- Code for this begins at line #55 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L55" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Left Title
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Friendly Title


```javascript
Package.onUse(function(api) {
});
```

Continues ...

<!-- Code for this begins at line #87 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L87" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Left Title
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Friendly Title


```javascript
Package.onUse(function(api) {
});
```

Continues ...

<!-- Code for this begins at line #87 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part09_PackageSelfTest.sh#L87" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Left Title
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Friendly Title

... continuing.


Continues ...


<!-- B -->
<div id="usage" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('usage'); return true;"
       href="javascript:HideContent('usage')">
      <p>Note text.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('usage'); return true;"
    href="javascript:ReverseContentDisplay('usage')">
    <i>Hover Note</i>
</a>
]
---
.left-column[
    ### End Of Part #F
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you!



<!-- B -->]
