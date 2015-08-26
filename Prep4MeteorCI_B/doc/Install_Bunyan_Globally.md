---
.left-column[
  ### Install Bunyan
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Install 'bunyan'

Bunyan is a logging package with the special advantage of writing
run-time logs as JSON.

This makes subsequent analysis and long-term
storage of production system logs much more efficient.

It is in two parts :
 - a local node module to replace 'console.log'
 - a global module that reads Bunyan JSON and reformats for different uses, including stdout.

For ongoing server side logging during development or production we need a permanent home for the logs.  The standard place for that in Ubuntu is ```/var/log/```.  So we also need to create a directory for Meteor with suitable permissions.


<!-- -->]
