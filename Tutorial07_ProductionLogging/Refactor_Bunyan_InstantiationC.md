---
last_update: 2016-01-06
 .left-column[
  ### Refactor Bunyan (C)
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

#### Refactor Bunyan Instantiation (Part C)

In ```package.js```, in ∗∗both∗∗ the ```onUse``` ∗∗and∗∗ the ```onTest``` sections, the "api" must add ```logger.js``` and export ```Logger```.
```javascript
Package.onUse(function(api) {
       :
  api.addFiles(['logger.js', '${PKG_NAME}.js'], ['server']);
  api.export('Logger');
});
``` 
```javascript
Package.onTest(function(api) {
       :
  api.addFiles(['logger.js', '${PKG_NAME}-tests.js'], ['server']);
  api.export('Logger');
});
```
Rerun the tests while watching a ```tail``` of the log file.
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan -o short
```


<!-- B -->]
