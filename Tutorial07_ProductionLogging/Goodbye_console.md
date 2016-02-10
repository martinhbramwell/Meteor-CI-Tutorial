---
last_update: 2016-02-09
 .left-column[
  ### Goodbye Console
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

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

Our output destination will depend on the execution environment. In our CI script we redirect log output to ```${CIRCLE_TEST_REPORTS}```, while for production it should go to a file.  We will now see how to specify the destination at run time.


<!-- B -->]
