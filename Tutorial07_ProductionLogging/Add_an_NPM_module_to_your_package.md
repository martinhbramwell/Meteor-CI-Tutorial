---
last_update: 2016-01-02
 .left-column[
  ### NPM module
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add the NPM logger module Bunyan to your package.

Meteor supports 'npm' modules with the package ```Npm```.

Edit ```'${PKG_NAME}-tests.js'``` again adding :

       ```const Bunyan = require('bunyan');```

```javascript
/∗∗
 ∗ Tinytest unit tests
 ∗ @namespace Tinytest
 ∗/
const Bunyan = require('bunyan');  //  ADD! <--
```

... save, start up Meteor and observe the command line logs and the browser console. The NodeJS command on its own, **will not work**. We need ```require``` from the Npm package, so try ```const Bunyan = Npm.require('bunyan'); ```  instead.

We now need to fix ```"Error: Cannot find module 'bunyan'"!```



<!-- B -->]
