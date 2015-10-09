---
name: AmendTheConfigurationAndPushAgain
.left-column[
  ### Configure CircleCI
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Amend the Configuration and Push Again

The command failed because we still must reference our package from the ```circle.yml``` file.

We add the script <a href="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/ci_help.sh" target="_blank">ci_help.sh</a> to the packages directory of our project.  It holds an array (```OUR_PACKAGES```) of package descriptions and a script to clone the packages and link them into the project.  Edit ```OUR_PACKAGES``` as needed.

We also insert a call to ```ci_help.sh``` in ```circle.yml```.
```ruby
    # Pull each of our packages and link them into our project
    - ./packages/ci_help.sh```
#####Commands
```terminal
wget -O ./packages/ci_help.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/ci_help.sh
git add packages;
git commit -am 'Add script to clone packages and symlink to them';
```


<!-- Code for this begins at line #48 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L48" target="_blank">Code for this step.</a>] ]
]
