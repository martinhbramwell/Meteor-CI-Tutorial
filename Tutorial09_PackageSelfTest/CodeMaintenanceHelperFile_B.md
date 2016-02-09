---
last_update: 2016-02-05
 .left-column[
  ### Helper File - Arbitrary # of Packages.
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Code Maintenance Helper File (Part B)

. . . continuing.

In this step, we create a dummy package maintenance file with a single command to be executed: 

```terminal
echo "I will perform CI tasks on ${PKG_NAME}.";
```

We also download ```perform_per_package_ci_tasks.sh``` and run it, expecting the result :

```ruby
Delegating to 1 package in '../../packages'.

   Package 1 of 1 :: Found code maintenance routine at '../../packages/${YOUR_UID}/${PKG_NAME}/tools/perform_ci_tasks.sh'.
I will perform CI tasks on ${PKG_NAME}.
```

As long as a package has a valid bash executable at ```./tools/perform_ci_tasks.sh``` then linting, documenting and other tasks will be executed as part of continuous deployment.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L103" target="_blank">Code for this step.</a>] ]
]
