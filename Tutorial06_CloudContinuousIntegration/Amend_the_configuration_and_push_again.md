---
name: AmendTheConfigurationAndPushAgain
.left-column[
  ### Configure CircleCI
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Amend the Configuration and Push Again

The command failed because we still must reference our package from the ```circle.yml``` file.

We add the script "<a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/fragments/obtain_managed_packages.sh" target="_blank">obtain_managed_packages.sh</a>" to the packages directory of our project.  It uses the list, ```managed_packages.sh```, to clone our packages and link them into the project.  Edit the list as needed.
```ruby
  # Pull each of our packages and link them into our project
  - ./packages/obtain_managed_packages.sh
```

##### Example Commands
```terminal
wget -O ./packages/managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/managed_packages.sh;
wget -O ./packages/obtain_managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/obtain_managed_packages.sh;
git add packages;
git commit -am 'Add script to clone packages and symlink to them';
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial06_CloudContinuousIntegration/CloudContinuousIntegration_functions.sh#L368" target="_blank">Code for this step.</a>] ]
]
