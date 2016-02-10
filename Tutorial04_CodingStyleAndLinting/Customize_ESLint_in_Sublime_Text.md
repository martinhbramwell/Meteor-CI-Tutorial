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
