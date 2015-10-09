---
name: AmendTheConfigurationAndPushAgain
.left-column[
  ### Configure CircleCI
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Amend the Configuration and Push Again

The command failed because we still must reference our package from the ```circle.yml``` file.  We have to add these lines (substituting appropriately for your names) . . .
```ruby
    - mkdir -p ~/packages/${YOUR_UID};  # ensure dir exists
    - pushd ~/packages/${YOUR_UID};
        git clone https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME};
      popd;
    - pushd ./packages;
        rm -fr ${PKG_NAME};
        ln -s ~/packages/${YOUR_UID}/${PKG_NAME} ${PKG_NAME};
      popd;
```
. . . just after this one, and then commit and push again.
```ruby
    - ln -s ~/node_modules node_modules
```
#####Commands
```terminal
git commit -am 'clone pkg and link to it' && git push
```


<!-- Code for this begins at line #64 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L64" target="_blank">Code for this step.</a>] ]
]
