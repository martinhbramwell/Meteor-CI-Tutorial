---
name: CreateRemoteGitHubRepository
last_update: 2016-02-05
 .left-column[
  ### GitHub Repo
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

... continuing.  This procedure will be more understandable if you watch the video series mentioned on the [Table of Contents](./) page. The steps are :

1. Log in to [GitHub](https://github.com/) as ```${PACKAGE_DEVELOPER}```
1. **Either** create the ```${GITHUB_ORGANIZATION_NAME}``` organization if it *does not exist*, **or** <a href='http://i.imgur.com/7wHRARZ.png' target='_blank'>switch to operate in that role</a> if it *does exist*.
1. <a href='http://i.imgur.com/X2K6NJf.png' target='_blank'>Create a project</a> with the exact name ```${PROJECT_NAME}``` . Don't set any other values. We'll do that automatically.
1. Select <a href='http://i.imgur.com/VKCUsx4.png' target='_blank'>[Settings]</a> *(project page right-most tab)* then <a href='http://i.imgur.com/lZfef0a.png' target='_blank'>[DeployKeys]</a> *(settings page bottom-left)*, then <a href='http://i.imgur.com/njWlTvX.png' target='_blank'>[Add deploy key]</a>
1. Copy the contents of ```~/.ssh/github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}``` to <a href='http://i.imgur.com/70Lsp1u.png' target='_blank'>the [Key] field</a>
1. Give the key a name in the ```Title``` field
1. Select ```Allow write access```.
1. Click ```Add key```.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L256" target="_blank">Code for this step.</a>] ]
]
