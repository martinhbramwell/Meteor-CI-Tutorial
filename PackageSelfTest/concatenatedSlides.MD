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
./Part09_RealWorldPackage.sh
```



<!-- B -->]
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

<!-- B -->]
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
