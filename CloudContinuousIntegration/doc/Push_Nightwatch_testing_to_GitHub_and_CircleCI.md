---
name: PushNightwatchTestingToGitHubAndCircleCI
.left-column[
  ### Commit Nightwatch
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

. . . continued.

Now edit ```circle.yml``` to re-enable use of ${PKG_NAME}, (not forgetting substitutions), then commit to GitHub -- hooking CircleCI for a rebuild :

```ruby
    - mkdir -p ~/packages/yourself;  # ensure dir exists
    - pushd ~/packages/yourself;     
        git clone https://github.com/your0rg/yourpackage;
      popd;
    - pushd ./packages;
        rm -fr yourpackage;   ln -s ~/packages/yourself/yourpackage yourpackage;
      popd;
```
##### Commands
```terminal
git add tests/nightwatch;
git add circle.yml;
git commit -am 'Added Nightwatch testing';
git push
```
<!-- Code for this begins at line #162 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L162" target="_blank">Code for this step.</a>] ]
]
