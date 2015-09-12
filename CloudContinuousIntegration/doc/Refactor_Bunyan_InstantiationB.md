---
.left-column[
  ### Refactor Bunyan (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continuing.

In ```package.js``` change this ...
```javascript
api.use('${YOUR_NAME}:${PKG_NAME}');
api.addFiles(['${PKG_NAME}-tests.js'], ['server']);
```
... to look like this ...
```javascript
api.use('${YOUR_NAME}:${PKG_NAME}');
api.export("Logger");           //  ADD! <--
api.addFiles(                   //  EDIT! <--
  ["logger.js", '${PKG_NAME}-tests.js'],
  ['server']
);   //  EDIT! <--
```
In a new terminal window run
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan
```

<!-- B -->]
