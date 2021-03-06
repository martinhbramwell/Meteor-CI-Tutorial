---
last_update: 2016-02-09
 .left-column[
  ### Server Only
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Bunyan is for Server Side Logging Only

You will have noticed that the client test results have gone, and the browser console shows ```'Npm' is not defined```.  NodeJS modules need extra packaging to run on the client.  With our focus on CI, we don't need that here.  We'll be testing server side only.  Let's make it explicit.

Edit the ```api.addFiles``` line in ```'package.js'``` to look like this :

```javascript
Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.addFiles(['${PKG_NAME}-tests.js'], ['server']); // EDIT! <--
});    // Note the square brackets.   ᗑ ᗑ

Npm.depends({
  'bunyan': '1.5.1',
});
```
. . . save, and observe the command line logs and the browser console.. 

<!-- B -->]
