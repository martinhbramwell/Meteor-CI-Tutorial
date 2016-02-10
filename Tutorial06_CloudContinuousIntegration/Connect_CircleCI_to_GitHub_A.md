---
last_update: 2016-02-09
 .left-column[
  ### Configure CircleCI
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

#### Connect CircleCI to GitHub (Part A)

A complete introduction to CircleCI is beyond the scopè of this series, however you can learn all the essential elements in the YouTube video: <a href="https://www.youtube.com/watch?v=oIRbUGJKcrs" target="_blank">"Android Continuous Integration with CircleCI"</a>

By <a href="http://imgur.com/z3atLCi.png" target="_blank">signing up to CircleCi</a> with <a href="http://imgur.com/lznvxN5.png" target="_blank">our GitHub account</a>, we <a href="http://imgur.com/e8kT2qL.png" target="_blank">authorize GitHub</a> to <a href="http://imgur.com/NyDT13U.png" target="_blank">reveal our organizations and repositories to CircleCI</a>.  By <a href="http://i.imgur.com/X8ABtsf.png" target="_blank">registering a GitHub repository</a> with CircleCI, <a href="http://imgur.com/6Vw0xnW.png" target="_blank">CircleCI and GitHub establish between them</a> a <a href="https://developer.github.com/webhooks/" target="_blank">"webhook"</a> that alerts CircleCI of events such as a new commit.

Once CircleCI <a href="http://i.imgur.com/DtaBko1.png" target="_blank">has analyzed our repository</a> and <a href="http://i.imgur.com/OuxEBqp.png" target="_blank">has attempted a first build</a>, we can <a href="http://i.imgur.com/QdJ8GF7.png?1" target="_blank">turn to the build results page</a>. However, there will be <a href="http://i.imgur.com/3xO3BWx.png" target="_blank">no results</a> until we describe our build requirements.

Continued . . .
<!-- B -->]
