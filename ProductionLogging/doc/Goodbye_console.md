---
.left-column[
  ### Goodbye Console
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We can get rid of the console altogether

Edit ```'${PKG_NAME}-tests.js'``` again and delete the line ```console.log('ººº Yoo Hoo ººº');```

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });

Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    Logger.info('ººº Yoo Hoo ººº');
//    console.log('ººº Yoo Hoo ººº');
    test.equal(true, true);
});
```
So, on the server-side, we now have much more control over logging <a href="https://github.com/trentm/node-bunyan#levels" target="_blank">levels</a> and <a href="https://github.com/trentm/node-bunyan#streams-introduction" target="_blank">output destinations</a>.

<!-- B -->]
