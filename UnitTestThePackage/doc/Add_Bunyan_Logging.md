---
.left-column[
  ### Add Bunyan Logging
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Now we can add logging

Edit ```'skeleton-tests.js'``` again adding ```const Logger = Bunyan.createLogger({ "name": "ci4meteor" });``` and ```const Logger = Bunyan.createLogger({ "name": "ci4meteor" });``` as shown.

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });  //  ADD! <--

Tinytest.add("example", function sanity(test) {
    Logger.info("ººº Yoo Hoo ººº");                           //  ADD! <--
    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->]
