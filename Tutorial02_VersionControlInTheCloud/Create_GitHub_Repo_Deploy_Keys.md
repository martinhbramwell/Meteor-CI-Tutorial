---
last_update: 2016-02-05
 .left-column[
  ### Prepare SSH directory
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare Deploy Keys for a GitHub Repository.
 
If you follow <a href='https://help.github.com/articles/generating-ssh-keys/' target='_blank'>GitHub's getting started documents</a>, you'll learn the hobbyist setup for GitHub.

We want to do something more realistic -- one deploy key per repository per developer, with a way to manage numerous keys easily.  The trick is in a file called ```~/.ssh/config```. It keeps multiple keys with aliased names that *git* will use to push to the correct repo for you, automatically.

In this step we prepare an aliased key for ```${PROJECT_NAME}```.

##### Example Commands
```terminal
ssh-keygen -t rsa -b 4096 -C "github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}" -N "" -f "${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}"
printf 'Host github-%s-%s\nHostName github.com\nUser git\nIdentityFile ~/.ssh/%s-%s\n\n' "${GITHUB_ORGANIZATION_NAME}" "${PROJECT_NAME}"  "${GITHUB_ORGANIZATION_NAME}" "${PROJECT_NAME}" >> config
ssh-add ${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}
```


<!-- B -->
<div id="gotkey" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('gotkey'); return true;"
       href="javascript:HideContent('gotkey')">
        <p>If a file '~/.ssh/${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}.pub' already exists, then this command group will do nothing.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('gotkey'); return true;"
    href="javascript:ReverseContentDisplay('gotkey')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L190" target="_blank">Code for this step.</a>] ]
]
