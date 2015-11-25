#!/usr/bin/awk -f
#

@include "./scripts/functions.awk";

{
  # Throw away HTML parts of hyperlinks.
  while (match($0,"<a[^>]*href=[^>]*>")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    sub(/<\/a>/, "", after);
    $0=before after;
  }
 
  # Double asterisk is markdown syntax for bold
  while (match($0,"\\*{2,}")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    $0=before boldZone(boldOn++) after;
  }
 
  # Single asterisk is markdown syntax for italics
  while (match($0,"\\*")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    $0=before italicsZone(italicsOn++) after;
  }
 
  # U2271 asterisk is marker for example asterisk
  while (match($0,"∗∗")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    $0=before "**" after;
  }

  # U2271 asterisk is marker for example asterisk
  while (match($0,"∗")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    $0=before "*" after;
  }

  # Hash symbols at start of line set section title font scale
  if (match($0,"^#{2,} *")) {
    after = substr($0,RSTART+RLENGTH);
    $0= "    " underline(after);
  }

  # Triple back quotes *not* at start of line mark code fragment
  if ( ! match($0,"^```")) {
    while (match($0,"`{3,}")) {
      before = substr($0,1,RSTART-1);
      after = substr($0,RSTART+RLENGTH);
      $0=before invertedZone(invertedOn++) after;
    }
  }

  # Hide special formatting html
  if ( match($0,"<div style='word-wrap:break-word;'>")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    $0=before after;
  }
  if ( match($0,"</div>")) {
    before = substr($0,1,RSTART-1);
    after = substr($0,RSTART+RLENGTH);
    $0=before after;
  }

  print $0;
}
