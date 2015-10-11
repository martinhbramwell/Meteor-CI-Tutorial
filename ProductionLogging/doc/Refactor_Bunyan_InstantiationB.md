---
.left-column[
  ### Refactor Bunyan (B)
  <br />
  <br />
  <div class="manual_input_reqd">
  <img src="./fragments/typer.gif" />
  Manual input required here.
  </div>
  <br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continuing ... we still need to 'wire' ```Logger``` into our package.

In ```package.js```, in **both** the ```onUse``` **and** the ```onTest``` sections, we need the "api" to add ```logger.js``` and export the ```Logger``` object.
```javascript
Package.onUse(function(api) {
       :
  api.addFiles(['logger.js', 'ourpackage.js'], ['server']);
  api.export('Logger');
});
``` 
```javascript
Package.onTest(function(api) {
       :
  api.addFiles(['logger.js', 'ourpackage-tests.js'], ['server']);
  api.export('Logger');
});
```
Continues ...
<!-- B -->]
