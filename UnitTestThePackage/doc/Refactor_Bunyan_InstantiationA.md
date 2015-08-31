---
.left-column[
  ### Refactor Bunyan (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part A)

Create a file ```'logger.js'``` that separates out Bunyan setup.

```javascript
const Bunyan = Npm.require("bunyan");
Logger = Bunyan.createLogger({
  "name": "ci4meteor",
  "streams": [{
    "path": "/var/log/meteor/ci4meteor.log",
  }],
});
```
Logs will be written to a permanent server-side file.

Remove Bunyan instantiation from ```'skeleton-tests.js'```
```javascript
// const Bunyan = Npm.require('bunyan');
// const Logger = Bunyan.createLogger({ "name": "ci4meteor" });

Tinytest.add("example", function sanity(test) {
    :
    :
```

Continues ...


<!-- B -->]
