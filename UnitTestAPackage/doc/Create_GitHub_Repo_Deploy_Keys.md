---
.left-column[
  ### Prepare SSH directory
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare Deploy Keys for a GitHub Repository.
 
This step is a repeat of the equivalent operation from the previous part.
Names are different at key points, so *git* meets no ambiguity about connecting local repos to the correct remote repo.

In this step we prepare an aliased key for ```${PKG_NAME}```.
##### Commands
```terminal
ssh-keygen -t rsa -b 4096 -C "github-${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}" -N "" -f "${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}"
printf 'Host github-%s-%s\nHostName github.com\nUser git\nIdentityFile ~/.ssh/%s-%s\n\n' "${GITHUB_ORGANIZATION_NAME}" "${PKG_NAME}"  "${GITHUB_ORGANIZATION_NAME}" "${PKG_NAME}" >> config
ssh-add ${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}
```


<!-- Code for this begins at line #110 -->
<!-- B -->
<div id="uniquename" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('uniquename'); return true;"
       href="javascript:HideContent('uniquename')">
        <p>If a file '~/.ssh/${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}.pub' already exists, then this command group will do nothing.</p>
    </a>
</div>
<a
    class="subtle_a"
    onmouseover="ReverseContentDisplay('uniquename'); return true;"
    href="javascript:ReverseContentDisplay('uniquename')">
    <i>Hover Note</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part03_UnitTestAPackage.sh#L110" target="_blank">Code for this step.</a>] ]
]
