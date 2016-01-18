---
last_update: 2016-01-17
 .left-column[
  ### Specify Npm modules
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
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
  api.addFiles('${PKG_NAME}-tests.js');
});

Npm.depends({
  'bunyan': '1.5.1',
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->
<div id="syntaxnote" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('syntaxnote'); return true;"
       href="javascript:HideContent('syntaxnote')">
        <p>Manual substitution :  you will need to replace ${PKG_NAME} with the name you actually use. </p><p>However, you will find that the substitutions are automated for you in the console output of ./Part07_ProductionLogging.sh</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('syntaxnote'); return true;"
    href="javascript:ReverseContentDisplay('syntaxnote')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note</i>
</a>
]
