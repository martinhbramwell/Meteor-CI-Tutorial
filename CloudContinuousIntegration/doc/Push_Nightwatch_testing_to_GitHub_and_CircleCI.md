---
name: PushNightwatchTestingToGitHubAndCircleCI
.left-column[
  ### Commit Nightwatch
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

We are ready for the final stage: TinyTest & Nightwatch testing run in a single pass of continuous integration in CircleCI. Intentionally, the Nightwatch runner's ```circle.yml``` can safely overwrite the one created for  TinyTest . . .

**However**, we will still need to restore the code for using ${PKG_NAME} that we applied in the step [Amend the Configuration and Push Again](#AmendTheConfigurationAndPushAgain), (not forgetting appropriate substitutions) :
```ruby
    - mkdir -p ~/packages/yourself;  # ensure dir exists
    - pushd ~/packages/yourself;     
        git clone https://github.com/your0rg/yourpackage;
      popd;
    - pushd ./packages;
        rm -fr yourpackage;
        ln -s ~/packages/yourself/yourpackage yourpackage;
      popd;
```


<!-- Code for this begins at line #147 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L147" target="_blank">Code for this step.</a>] ]
]
