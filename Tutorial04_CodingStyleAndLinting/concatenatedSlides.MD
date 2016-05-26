layout: false
last_update: 2016-02-09
 .left-column[
  ### PART D INTRODUCTION

.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## Code Quality - Coding Style and Linting

These scripts will get you started easily with Meteor package development, testing, documenting, logging, code style linting and continuous deployment.

The previous script, 'Tutorial03_UnitTestAPackage.sh', got us started with a package, stored and controlled independantly, yet one that can still be edited and tested as though it was part of an app anyway.

This one . . .  
```terminal
./Tutorial04_CodingStyleAndLinting.sh
```
. . .  brings in the capability of applying code style and quality rules: while editing, before committing and during continuous deployment.

This is useful for an individual developer, but increases in importance with the number of developers involved.

<!-- B -->]
---
name: UseESLintOnTheCommandLine
last_update: 2016-02-09
 .left-column[
  ### Command Line ESLint
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use ESLint on the Command Line

We installed command line ESLint in the first part, and will have it for Sublime Text momentarily.  Both have advantages: editor based linting helps ensure code quality as we type, while command line linting catches quality issues during continuous deployment.  A command line result looks like this :
```ruby
/home/yourself/demos/yourproject/yourproject.js
   3:22  error    Strings must use doublequote                  quotes
   6:14  warning  Missing function expression name              func-names
           :        :                :                            :
  20:26  error    Unexpected space before function parentheses  space-before-function-paren

✖ 13 problems (10 errors, 3 warnings)
```
##### Example Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/
eslint ${PROJECT_NAME}.js
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L1" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-09
 .left-column[
  ### ESLint for ST3
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure Sublime Text to use the '.eslintrc' file

Now we add hinting about coding style defects to Sublime Text.

Steps to perform :

 - Go to Preferences >> Package Control
 - In Package Control type : install package
 - Install these two packages :
   - 'SublimeLinter'
   - 'SublimeLinter-contrib-eslint'

<!-- B -->]
---
last_update: 2016-02-09
 .left-column[
  ### Sublime ESLint
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Customize the '.eslintrc' file

In Sublime Text :
1. go to the menu ```File >> Open Folder```
2. find and open our project ```~/${PARENT_DIR}/${PROJECT_NAME}```
3. begin editing the file ```.eslintrc```
4. search for ```/rules/quotes```
5. change 'double' to 'single'
```JSON
    'quotes': [
      2, 'single', 'avoid-escape'    // http://eslint.org/docs/rules/quotes
    ],
```
6. save the file :  ```File >> Save```

You have reconfigured the ESLint rule ```'quotes'```.  The complete list of configurable rules is available from <a target="blank" href="http://eslint.org/docs/rules/">eslint.org rules documentation</a>
<!-- B -->]
---
last_update: 2016-02-09
 .left-column[
  ### Sublime ESLint
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Correct the indicated code-quality defects

In Sublime Text, make sure you're editing the same project as you opened in the previous slide, then :
1. begin editing the files ```./${PROJECT_NAME}.js``` and ```${PARENT_DIR}/modules/${USER}/${MODULE_NAME}/${MODULE_NAME}-tests.js```
2. the former has ESLint deficiencies indicated, while the latter does not.
3. open ```./.eslintrc``` and save it as ```./packages/${MODULE_NAME}/.eslintrc```
4. close and reopen ```${PARENT_DIR}/modules/${USER}/${MODULE_NAME}/${MODULE_NAME}-tests.js``` and deficiency flags will appear
5. click on line '3' and notice the status bar has a warning ```func-names``` and an error ```space-before-function-paren```
6. add ```checkSanity``` after ```function``` to correct both defects

```javascript
Tinytest.add('example', function checkSanity(test) {
  test.equal(true, true);
});
```

<!-- B -->
 
<div id="needineach" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('needineach'); return true;"
       href="javascript:HideContent('needineach')">
        <p>By default, the linter in Sublime Text ignores files reached by symbolic links. Consequently, you'll need an .eslintrc file in each package.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('needineach'); return true;"
    href="javascript:ReverseContentDisplay('needineach')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note</i>
</a>


]
---
last_update: 2016-02-09
 .left-column[
  ### Command Line ESLint
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Ignore Files

It's worth mentioning how to skip files that esLint should not process.

If esLint finds an ```.eslintignore``` file in the current directory it will not analyze any files or descend into any directories listed in the file.

In later parts of this tutorial we'll have additional files, some of which should not be processed.  We might as well mask them off now . . . 

##### Example commands

```terminal
echo "./docs" > .eslintignore
echo "./backup" >> .eslintignore
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L12" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-09
 .left-column[
  ### Command Line ESLint
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Test again for code-quality defects

Return to the command line and rerun . . . 
```terminal
eslint ~/${PARENT_DIR}/modules/${USER}/${MODULE_NAME}/${MODULE_NAME}-tests.js
```
. . . as you did for the earlier step ["Command Line ESLint"](#UseESLintOnTheCommandLine).

Great!  All clean!

**Note 2015/09/27** - The current version mishandles ```.eslintignore``` when there are symlinks, resulting in the false warning "File ignored because of your .eslintignore file. Use --no-ignore to override"
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial04_CodingStyleAndLinting/CodingStyleAndLinting_functions.sh#L23" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-02-09
 .left-column[
    ### End Of Part #D
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

We made unit testing and coding standards assurance as easy as possible. 

In the next section we will address jsDoc and GitHub pages, which together will make it as easy as possible to publish high quality documentation.  We will also be saving our work on our package to GitHub

[Part #E - Code Quality - Automatic Documentation in the Cloud](./toc.html?part=E)


<!-- B -->]
