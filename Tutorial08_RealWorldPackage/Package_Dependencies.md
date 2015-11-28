---
.left-column[
  ### Make Package Method Callable
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Package Dependencies

... continuing.

The new files ```usage_example.html``` and ```usage_example.js``` :
 - must implement client-side functionality and they
 - must do it from within a template

Simply specifying ```['client']``` in ```api.addFiles()``` answers the first issue, but two errors arise from the second one.

We need to declare a dependency on ```templating``` to solve the error, "No plugin known to handle file 'usage_example.html'" and we need to declare a dependency on the package, ```session``` to solve the client-side 'ReferenceError' seen on Session, Template and Meteor.  Update the ```Package.onUse()``` section with :
```javascript
Package.onUse(function onUse(api) {
  api.use(['ecmascript', 'templating', 'session']);
```



Continues ...


<!-- B -->]
