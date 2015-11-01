---
.left-column[
  ### Prepare SSH directory
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Prepare Deploy Keys for a GitHub Repository.
 
This step is a repeat of the equivalent operation from the previous part.
Names are made to be distinct, deliberately, so *git* meets no ambiguity about connecting local repos to the correct remote repo.

In this step we prepare an aliased key for ```${PKG_NAME}```.
##### Example Commands
```terminal
ssh-keygen -t rsa -b 4096 -C "github-${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}" -N "" -f "${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}"
printf 'Host github-%s-%s\nHostName github.com\nUser git\nIdentityFile ~/.ssh/%s-%s\n\n' "${GITHUB_ORGANIZATION_NAME}" "${PKG_NAME}"  "${GITHUB_ORGANIZATION_NAME}" "${PKG_NAME}" >> config
ssh-add ${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}
```


<!-- B -->
<div id="pubkey" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('pubkey'); return true;"
       href="javascript:HideContent('pubkey')">
        <p>If a file '~/.ssh/${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}.pub' already exists, then this command group will do nothing.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('pubkey'); return true;"
    href="javascript:ReverseContentDisplay('pubkey')">
    <i>Hover Note</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/modularize/Tutorial03_UnitTestAPackage/UnitTestAPackage_functions.sh#L87" target="_blank">Code for this step.</a>] ]
]
