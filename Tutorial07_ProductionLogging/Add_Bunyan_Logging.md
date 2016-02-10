---
last_update: 2016-02-09
 .left-column[
  ### Add Bunyan Logging
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

#### Now we can add logging

Edit ```'${PKG_NAME}-tests.js'``` again adding ```const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });``` and ```Logger.info('ººº Yoo Hoo ººº');``` as shown.

```javascript
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });  //  ADD! <--

Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    Logger.info('ººº Yoo Hoo ººº');                           //  ADD! <--
    console.log('ººº Yoo Hoo ººº');
    test.equal(true, true);
});
```

   ... save, and observe the command line logs and the (empty!) browser console.

<!-- B -->]
