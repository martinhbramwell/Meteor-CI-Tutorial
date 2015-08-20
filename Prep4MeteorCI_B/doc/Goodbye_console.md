---
.left-column[
  ### Goodbye Console
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Now we can get rid of the console alothogether

Edit ```'skeleton-tests.js'``` again and delete the line ```console.log("ººº Yoo Hoo ººº");```

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });
// Write your tests here!
// Here is an example.
Tinytest.add("example", function sanity(test) {
    Logger.info("ººº Yoo Hoo ººº");
//    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```

Stop your Meteor service and restart with this command :
```terminal
meteor test-packages | bunyan
```

<!-- -->]
