---
.left-column[
  ### Run NightWatch
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Run NightWatch testing.

Nightwatch and Meteor are separate.

This command group starts Meteor in a background process, (stopping any already running), and then starts the Nightwatch Test Runner to try the simple sanity check test, "Does the main page have a <body> tag?".  It will kill the Meteor processes when complete.  Expected results :
```ruby
[2015-09-29T15:45:32.571Z]  INFO: demo/4217 on yourvm: Running:  Layout and Static Pages
[2015-09-29T15:45:36.170Z]  INFO: demo/4217 on yourvm: ✔ Testing if element <body> is present.
[2015-09-29T15:45:36.762Z]  INFO: demo/4217 on yourvm: OK. 1 assertions passed. (4.189s)
[2015-09-29T15:45:36.768Z]  INFO: demo/4217 on yourvm:
[2015-09-29T15:45:36.771Z]  INFO: demo/4217 on yourvm: OK. 1 assertion passed. (4.912s)
[2015-09-29T15:45:37.049Z]  INFO: demo/4217 on yourvm: Finished!  Nightwatch ran all the tests!
```


##### Example Commands
```terminal
 ./tests/nightwatch/runTests.js | bunyan
```
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L98" target="_blank">Code for this step.</a>] ]
]
