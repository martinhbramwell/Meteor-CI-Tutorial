layout: false
.left-column[
  ### PART B INTRODUCTION

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Version Control In The Cloud

These scripts will get you started easily with Meteor package development, testing, documenting, code style linting and continuous integration.

The previous script, 'Part01_PrepareTheMachine.sh', set up necessary preconditions for the remaining scripts, (basically all tasks that require root access). 

This one . . .  
```terminal
./Part02_VersionControlInTheCloud.sh
```
. . . prepares a Meteor project, with version control *in the cloud* in GitHub.  You will need to understand a bit about Public and Private Keys and about Secure Shell.  Try reading <a href="https://help.github.com/articles/generating-ssh-keys/" target="_blank">GitHub's getting started documents.</a>

You should not need to use 'sudo' for this or any of the later parts.  In other words, everything should happen in subdirectories of your HOME directory.



<!-- B -->]
---
.left-column[
  ### Set Up Project Names
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Set up identifiers required by GitHub

This step writes some names you specify to a file.  You won't have to repeat this.

You will be asked to supply the following details :
 - The exact project name for use in GitHub
 - The exact package name for use in GitHub
 - The exact name for the GitHub organization
 - The project owner's full name to use to publish on GitHub
 - The project owner name to for internal use
 - The email address for the project owner in GitHub

<!-- B -->]
---
.left-column[
  ### Configure git for GitHub
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure git for use with GitHub.

In this step we set up the local git tool kit to communicate correctly with GitHub, per [their getting started guide](https://help.github.com/articles/set-up-git/).

Steps performed :
 - identify user name
 - identify user email
 - use simple push


#####Commands
```terminal
git config --global user.name "${PACKAGE_DEVELOPER}"
git config --global user.email "${YOUR_EMAIL}"
git config --global push.default simple
```
<!-- Code for this begins at line #38 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L38" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Install Meteor
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Your typical Meteor install step

In this step we simply run Meteor's installation

##### Commands
```terminal
curl https://install.meteor.com/ | sh
```


<!-- Code for this begins at line #49 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L49" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Create Meteor Project
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a Meteor project.

Here we create a container directory called ```${PARENT_DIR}``` and inside it we start a Meteor project called ```${PROJECT_NAME}```

If the project was created earlier you'll be invited to delete it and start a new one.
##### Commands
```terminal
mkdir -p ~/${PARENT_DIR}
meteor create ${PROJECT_NAME}
```

<!-- Code for this begins at line #77 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L77" target="_blank">Code for this step.</a>] ]
]
---
name: Check Meteor Works

.left-column[
  ### Check Meteor Works
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Check the meteor project will work

If Meteor is not already running, it will start up ```${PROJECT_NAME}``` now.

If Meteor IS already running, you will need to stop it.

**When prompted**, test meteor in a browser.

<a href='http://localhost:3000/' target='_blank'>http://localhost:3000/</a>

When you continue to the next step Meteor will be killed automatically.
#####Commands
```terminal
A_METEOR_PID=$(ps aux | grep meteor | grep tools/main.js | awk '{print $2}')
echo $A_METEOR_PID
```

<!-- Code for this begins at line #121 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L121" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Meteor App Metadata
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

The .eslintrc file is borrowed from the project [warehouseman:meteor-swagger-client](https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc)
#####Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc
```

<!-- Code for this begins at line #148 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L148" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Prepare SSH directory
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create SSH keys directory if it does not exist.
 
This script requires you to have an SSH private key!

If the file '~/.ssh/id_rsa' exists, then this command group will do nothing.

Otherwise, it will set up the directory and create an empty '~/.ssh/id_rsa' 

You'll need to paste your SSH credentials into each of the empty files. This assumes you only need to copy them in from some other GitHub project.  Getting them for the first time is beyond the scope of this tutorial.  You should follow <a href='https://help.github.com/articles/generating-ssh-keys/' target='_blank'>GitHub's getting started documents.</a>


<!-- Code for this begins at line #202 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L202" target="_blank">Code for this step.</a>] ]
]
---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
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
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

... continuing.

This procedure will be more understandable if you watch the video series mentioned on the [Table of Contents](./) page. The steps are :

1. Log in to [GitHub](https://github.com/) as ```${PACKAGE_DEVELOPER}```
1. **Either** create the ```${GITHUB_ORGANIZATION_NAME}``` organization if it *does not exist*, **or** <a href='http://i.imgur.com/7wHRARZ.png' target='_blank'>switch to operate in that role</a> if it *does exist*.
1. <a href='http://i.imgur.com/X2K6NJf.png' target='_blank'>Create a project</a> with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
1. Select <a href='http://i.imgur.com/VKCUsx4.png' target='_blank'>[Settings]</a> *(project page bottom-right)* then <a href='http://i.imgur.com/lZfef0a.png' target='_blank'>[DeployKeys]</a> *(settings page bottom-left)*, then <a href='http://i.imgur.com/njWlTvX.png' target='_blank'>[Add deploy key]</a>
1. Copy the contents of ```~/.ssh/id_rsa.pub``` to <a href='http://i.imgur.com/70Lsp1u.png' target='_blank'>the [Key] field</a>
1. Give the key a name in the ```Title``` field
1. Select ```Allow write access```.
1. Click ```Add key```.



<!-- Code for this begins at line #248 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L248" target="_blank">Code for this step.</a>] ]
]
---
name: CreateLocalGitHubRepository
.left-column[
  ### Local GitHub Repo
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

**This step is NOT idempotent.**  If you have already pushed to GitHub you might get errors. If so, eliminate the project from GitHub and run this step again. *Also note : SSH may ask you to confirm GitHub's PK fingerprint.**
#####Commands
```terminal
git init
git add .
git commit -am 'First commit'
git remote add origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
git push -u origin master
```

<!-- Code for this begins at line #263 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_VersionControlInTheCloud.sh#L263" target="_blank">Code for this step.</a>] ]
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
