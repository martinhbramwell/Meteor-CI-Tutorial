---
.left-column[
  ### Specify Npm modules
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We have to specify every Npm requirement explicitly.

The Meteor package ```Npm``` preloads any NodeJS modules specified in a package.js file. To solve ```"Error: Cannot find module 'bunyan'"``` type errors we need to specify dependencies individually with ```Npm.depends({});```.

Add the indicated block to the file ```'package.js'```

```javascript
Package.onTest(function onTest(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}');
  api.addFiles('${PKG_NAME}-tests.js');
});

Npm.depends({
  'bunyan': '1.4.0',
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->
<div id="syntaxnote" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('syntaxnote'); return true;"
       href="javascript:HideContent('syntaxnote')">
        <p>Manual substitution :  you will need to replace ${GITHUB_ORGANIZATION_NAME} and ${PKG_NAME} with the names you actually use. </p><p>However, youu will find that the substitutions are automated for you in the console output of ./Part07_ProductionLogging.sh</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('syntaxnote'); return true;"
    href="javascript:ReverseContentDisplay('syntaxnote')">
    <i>Hover Note</i>
</a>
]
