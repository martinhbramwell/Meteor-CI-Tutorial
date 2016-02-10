---
last_update: 2016-02-09
 .left-column[
  ### Helper File - Package Iterator
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Code Maintenance Helper File (Part A)

Let's take a step back and a fresh look at what we are doing here.

Our project only exists to act as an integration and test harness for our package -- but, we might want multiple packages.  Back in  <a href="./toc.html?part=F#4" target="_blank">Tutorial 6</a> we introduced the file ```obtain_managed_packages.sh``` that iterates through a list of packages in ```managed_packages.sh```, cloning each in turn from GitHub into CircleCI.

Linting code and publishing docs are just two out of N additional integration tasks we might want to perform.  Since we know in advance neither the number of packages, nor the number of tasks for each package, we'll offer each one an opportunity to **run it's own** maintenance tasks. So, we'll introduce two more files; at the project level ```perform_per_package_ci_tasks.sh``` will iterate through our ```managed_packages.sh``` list calling ```perform_ci_tasks.sh``` in each package.

Continued . . .

<!-- B -->]
