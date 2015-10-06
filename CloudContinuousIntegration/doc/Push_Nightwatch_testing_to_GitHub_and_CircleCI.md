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
    - mkdir -p ~/packages/${YOUR_NAME};  # ensure dir exists
    - pushd ~/packages/${YOUR_NAME};
        git clone https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME};
      popd;
    - pushd ./packages;
        rm -fr ${PKG_NAME};   ln -s ~/packages/${YOUR_NAME}/${PKG_NAME} ${PKG_NAME};
      popd;
```
##### Commands
```terminal
git add tests/nightwatch;
git add circle.yml;
git commit -am 'Added Nightwatch testing';
git push
```
<!-- Code for this begins at line #161 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part06_CloudContinuousIntegration.sh#L161" target="_blank">Code for this step.</a>] ]
]
