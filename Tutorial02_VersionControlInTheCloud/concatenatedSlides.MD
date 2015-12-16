layout: false
.left-column[
  ### PART B INTRODUCTION

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Version Control In The Cloud

These scripts will get you started easily with Meteor package development, testing, documenting, logging, code style linting and continuous integration.

The previous script, 'Tutorial01_PrepareTheMachine.sh', set up necessary preconditions for the remaining scripts, (basically all tasks that require root access). 

This one . . .  
```terminal
./Tutorial02_VersionControlInTheCloud.sh
```
. . . prepares a Meteor project, with version control *in the cloud* in GitHub.  You will need to understand a bit about Public and Private Keys and about Secure Shell.  Try reading <a href="https://help.github.com/articles/generating-ssh-keys/" target="_blank">GitHub's getting started documents.</a>

You should not need to use 'sudo' for this or any of the later parts.  In other words, everything should happen in subdirectories of your HOME directory.



<!-- B -->]
---
.left-column[
  ### Set Up Project Names
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.gif' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Set up identifiers required by GitHub

This step writes some names you specify to a file.  You won't have to repeat this.

You will be asked to supply the following details :
 - The sudirectory path in your home directory
 - The exact project name for use in GitHub
 - The exact package name for use in GitHub
 - The exact name for the GitHub organization
 - The project owner's name for publishing on GitHub
 - The project owner name to for internal use
 - The email address for the project owner in GitHub

<!-- B -->]
---
.left-column[
  ### Configure git for GitHub
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure git for use with GitHub.

In this step we set up the local git tool kit to communicate correctly with GitHub, per <a href='https://help.github.com/articles/set-up-git/' target='_blank'>their getting started guide</a>.

Steps performed :
 - identify user name
 - identify user email
 - use simple push


##### Example Commands
```terminal
git config --global user.name "${YOUR_FULLNAME}"
git config --global user.email "${YOUR_EMAIL}"
git config --global push.default simple
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L3" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install Meteor
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Your typical Meteor install step

In this step we simply run Meteor's installation

##### Example Commands
```terminal
curl https://install.meteor.com/ | sh
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L14" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create Meteor Project
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor project.

Here we create a container directory called ```${PARENT_DIR}``` and inside it we start a Meteor project called ```${PROJECT_NAME}```.

If the project was created earlier you'll be invited to delete it and start a new one.

##### Example Commands
```terminal
mkdir -p ~/${PARENT_DIR}
meteor create ${PROJECT_NAME}
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L47" target="_blank">Code for this step.</a>] ]
]
---
name: Check Meteor Works

.left-column[
  ### Check Meteor Works
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Check the meteor project will work

This script will now stop any currently running Meteor process and start a new one for ```${PROJECT_NAME}```, cleanly.

**When prompted**, test Meteor with this link in a browser, <a href='http://localhost:3000/' target='_blank'>http://localhost:3000/</a>

When you hit ```<Enter>```, to continue to the next step, Meteor will be killed automatically.

##### Example Commands
```terminal
A_METEOR_PID=$(ps aux | grep meteor | grep tools/main.js | awk '{print \$2}')
echo $A_METEOR_PID;
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L96" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Meteor App Metadata
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add Meteor application metadata files

In this step we create some of the project meta data files :
 -  LICENSE
 -  README.md
 -  .gitignore
 -  .eslintrc
 -  public/favicon-32x32.png

The .eslintrc file is borrowed from the project <a href='https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc' target='_blank'>warehouseman:meteor-swagger-client</a>

##### Example Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc
wget -O ./public/favicon-32x32.png https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/favicon-32x32.png
sed -i "/<head>/c<head>\
    \\n  <link rel=\"shortcut icon\" href=\"/favicon-32x32.png\" type=\"image/x-icon\" />" ${PROJECT_NAME}.html
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L119" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Prepare SSH directory
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
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
    <i>Hover Note</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L187" target="_blank">Code for this step.</a>] ]
]
---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

In this step we create a repository in GitHub project source hosting.  

The most direct approach to creating a GitHub repo is simply to do it in your own name and manage it using the account owner's (your!) SSH keys.

However, if you take a long-term view, it's much more flexible and resilient to assume a large team from day one. While it's fractionally more difficult, it beats the hell out of having to refactor some day because you have too many committers with keys on your personal account.

We'll create an organization distinct from ourselves (```${GITHUB_ORGANIZATION_NAME}```), and add our own SSH public key as a ```"Deploy key"``` for each repo we create.

Continued . . . 
<!-- B -->]
---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.gif' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

... continuing.  This procedure will be more understandable if you watch the video series mentioned on the [Table of Contents](./) page. The steps are :

1. Log in to [GitHub](https://github.com/) as ```${PACKAGE_DEVELOPER}```
1. **Either** create the ```${GITHUB_ORGANIZATION_NAME}``` organization if it *does not exist*, **or** <a href='http://i.imgur.com/7wHRARZ.png' target='_blank'>switch to operate in that role</a> if it *does exist*.
1. <a href='http://i.imgur.com/X2K6NJf.png' target='_blank'>Create a project</a> with the exact name ```${PROJECT_NAME}``` . Don't set any other values. We'll do that automatically.
1. Select <a href='http://i.imgur.com/VKCUsx4.png' target='_blank'>[Settings]</a> *(project page bottom-right)* then <a href='http://i.imgur.com/lZfef0a.png' target='_blank'>[DeployKeys]</a> *(settings page bottom-left)*, then <a href='http://i.imgur.com/njWlTvX.png' target='_blank'>[Add deploy key]</a>
1. Copy the contents of ```~/.ssh/github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}``` to <a href='http://i.imgur.com/70Lsp1u.png' target='_blank'>the [Key] field</a>
1. Give the key a name in the ```Title``` field
1. Select ```Allow write access```.
1. Click ```Add key```.

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L231" target="_blank">Code for this step.</a>] ]
]
---
name: CreateLocalGitHubRepository
.left-column[
  ### Local GitHub Repo
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.gif' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Create our **local** GitHub repository.
In this step we :
 -  initialize a local .git repository
 -  add all the files to the local repo and commit
 -  establish our GitHub project as the remote repository
 -  push our new files to GitHub

**This step is NOT idempotent.**  If you have already pushed to GitHub you might get errors. If so, eliminate the project from GitHub and run this step again. *Also note : SSH may ask you to confirm GitHub's PK fingerprint.*

##### Example Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add ${PROJECT_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
git push -u ${PROJECT_NAME}_origin master
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L257" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
    ### End Of Part #B
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

The preceding two parts covered the minimal basic set up of a Meteor application with cloud-based version control.  The next section will guide you through preparations for unit testing a package. 

[Part #C - Create and Unit Test a Package](./?part=C)



<!-- B -->]
