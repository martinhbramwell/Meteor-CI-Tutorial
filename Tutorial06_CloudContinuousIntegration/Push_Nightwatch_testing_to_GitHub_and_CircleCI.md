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
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Nightwatch testing to GitHub (and CircleCI)

. . . continued.

Now edit ```circle.yml``` to re-enable use of ${PKG_NAME}, (not forgetting substitutions), then commit to GitHub -- hooking CircleCI for a rebuild :

```ruby
    - mkdir -p ~/packages/${YOUR_UID};  # ensure dir exists
    - pushd ~/packages/${YOUR_UID};
        git clone https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME};
      popd;
    - pushd ./packages;
        rm -fr ${PKG_NAME};   ln -s ~/packages/${YOUR_UID}/${PKG_NAME} ${PKG_NAME};
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
