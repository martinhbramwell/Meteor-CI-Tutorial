---
last_update: 2016-02-11
 .left-column[
  ### Prepare Sublime Text (Step #1)
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

### Add 'Package Control' to Sublime Text

We need <a href='http://www.sublimetext.com/3' target='_blank'>Sublime Text 3</a> configured as follows :

 - In your browser, go to the <a href='https://packagecontrol.io/installation' target='_blank'>Package Control installer URL</a>
 - Copy the code snippet for **Sublime Text 3**
 - Find the Sublime Text icon in your machine at ```Start >> Development```, add it to the panel and start it up (cancel update note if shown).
 - Go to ```View >> Show Console```, to open the Console
 - Paste the snippet into ST3's console, hit enter and respond to the two prompts.
 - Go to ```View >> Hide Console```, to close the Console

##### Example Commands
```ruby
export ST3URL="https://packagecontrol.io/installation#st3";
python -c "import requests;from bs4 import BeautifulSoup;print '>>>';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
```

<!-- B -->
<div id="gotkey" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('gotkey'); return true;"
       href="javascript:HideContent('gotkey')">
        <p>If you find this slide hard to understand, watch <a target="_blank" href="https://www.youtube.com/watch?v=oMBYTwElMvk#t=3m13s.">the video beginning at 3:16.</a></p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('gotkey'); return true;"
    href="javascript:ReverseContentDisplay('gotkey')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note</i>
</a>

.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial01_PrepareTheMachine/PrepareTheMachine_functions.sh#L406" target="_blank">Code for this step.</a>] ]
]
