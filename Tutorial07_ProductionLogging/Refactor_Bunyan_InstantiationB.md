---
.left-column[
  ### Refactor Bunyan (B)
  <br /><br /><div class="input_type_indicator"><img src="./fragments/typer.gif" /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continuing ... we still need to 'wire' ```Logger``` into our package.

In ```package.js```, in ∗∗both∗∗ the ```onUse``` ∗∗and∗∗ the ```onTest``` sections, we need the "api" to add ```logger.js``` and export the ```Logger``` object.
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
Continues ...
<!-- B -->]
