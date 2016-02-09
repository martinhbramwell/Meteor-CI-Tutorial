layout: false
last_update: 2016-02-09
 .left-column[
  ### PART G Introduction

.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Production Logging

In, 'Tutorial06_CloudContinuousIntegration.sh' we got most of our intended toolkit functioning without actually doing any Meteor development.

The next step is mainly about the inner workings of packages, but the goal is to get rid of those pernicious ```console.log()``` statements.

We look at scaleable logging: run-time logs that track critical server-side activity at appropriate levels of detail.  "Bunyan" emits machine readable, JSON format logs that you can archive, for example in MongoDB, and analyze later for any kind of development, production or business purpose.

Now run ...
```terminal
./Tutorial07_ProductionLogging.sh
```



<!-- B -->]
