layout: false
.left-column[
  ### PART G Introduction

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Production Logging

In, 'Part06_CloudContinuousIntegration.sh' we got most of our intended toolkit functioning without actually doing any Meteor development.

The next step is mainly about the inner workings of packages, but the goal is to get rid of those pernicious ```console.log()``` statements.

We look at scaleable logging: run-time logs that track critical server-side activity at appropriate levels of detail.  "Bunyan" emits machine readable, JSON format, logs that you can archive, for example in MongoDB, and analyze later for any kind of development, production or business purpose.

Now run ...
```terminal
./Part07_ProductionLogging.sh
```



<!-- B -->]
