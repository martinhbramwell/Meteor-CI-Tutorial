layout: false
last_update: 2015-12-18
 .left-column[
  ### PART H Introduction

.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## A Real World Package

'Tutorial07_ProductionLogging.sh' introduced how to ```require``` a NodeJS module into Meteor but it was a simple case.

Although Meteor is built on NodeJS, there's a fundamental divergence of design philosophy.  NodeJS achieves very efficient processing of requests using "non-blocking", **asynchronous** callbacks.  Meanwhile, Meteor achieves a very efficient development platform with event-driven **synchronous** programming, by hiding the complexity of asynchronous coding within synchronous wrappers.

An understanding of synchronous wrappers of NodeJS modules opens the doors to the whole NodeJS ecosystem for use in Meteor development.

Get started now by running ...
```terminal
./Tutorial08_RealWorldPackage.sh
```



<!-- B -->]
