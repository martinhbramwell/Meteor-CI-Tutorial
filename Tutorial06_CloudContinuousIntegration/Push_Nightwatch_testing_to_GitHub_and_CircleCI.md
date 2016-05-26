---
name: PushNightwatchTestingToGitHubAndCircleCI
last_update: 2015-12-18
 .left-column[
  ### Commit Nightwatch
  <!-- input_type_indicator -->
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

. . . continued.

Now edit ```circle.yml``` to re-enable use of ${MODULE_NAME}, (not forgetting substitutions), then commit to GitHub -- hooking CircleCI for a rebuild :

```ruby
    - mkdir -p ~/modules/${YOUR_UID};  # ensure dir exists
    - pushd ~/modules/${YOUR_UID};
        git clone https://github.com/${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME};
      popd;
    - pushd ./modules;
        rm -fr ${MODULE_NAME};   ln -s ~/modules/${YOUR_UID}/${MODULE_NAME} ${MODULE_NAME};
      popd;
```
##### Example Commands
```terminal
git add tests/nightwatch;
git add circle.yml;
git commit -am 'Added Nightwatch testing';
git push
```
<!-- B -->]
