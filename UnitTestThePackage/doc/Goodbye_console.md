---
.left-column[
  ### Goodbye Console
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We can get rid of the console altogether

Edit ```'yourpackage-tests.js'``` again and delete the line ```console.log("ººº Yoo Hoo ººº");```

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });

Tinytest.add("example", function sanity(test) {
    Logger.info("ººº Yoo Hoo ººº");
//    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```


<!-- B -->]
