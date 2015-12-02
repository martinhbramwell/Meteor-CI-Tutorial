---
.left-column[
  ### Prepare Sublime Text (Step #1)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

### Preparation of Sublime Text
#### First step - add '<a href='https://packagecontrol.io/' target='_blank'>Package Control</a>'

We need <a href='http://www.sublimetext.com/3' target='_blank'>Sublime Text 3</a> configured as follows :

 - In your browser, go to the <a href='https://packagecontrol.io/installation' target='_blank'>Package Control installer URL</a>
 - Copy the code snippet for **Sublime Text 3**
 - Find Sublime Text in ```Start >> Development```, add it to the panel and start it up.
 - Go to ```View >> Show Console```, to open the Console
 - Paste the snippet into ST3's console, hit enter and respond to the two prompts.
 - Go to ```View >> Hide Console```, to close the Console

##### Example Commands
```terminal
export ST3URL="https://packagecontrol.io/installation#st3";
python -c "import requests;from bs4 import BeautifulSoup;print '>>>';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L317" target="_blank">Code for this step.</a>] ]
]
