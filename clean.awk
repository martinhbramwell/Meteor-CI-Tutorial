#!/usr/bin/awk -f
#

@include "functions.awk";

{

  if (match($0,"^`{2,}")) {
    print terminalSyntaxHighlight(terminalSyntaxOn++, "|-----------------------------------------------------------|<");
  } else {

    if ( terminalSyntaxOn % 2 < 1 ) {

      gsub(/'/, "±", $0);
#      command = "./shellSyntaxHiLite.sh '"$0"'";
      command = "echo '"$0"' | sed \"s/±/'/g\" | pygmentize -l bash";
      if ( (command | getline var) > 0) { print " "var; };
      close(command);
      
    } else {
    
      while (match($0,"<a[^>]*href=[^>]*>")) {
        before = substr($0,1,RSTART-1);
        after = substr($0,RSTART+RLENGTH);
        sub(/<\/a>/, "", after);
        $0=before after;
      }
     
      while (match($0,"`{3,}")) {
        before = substr($0,1,RSTART-1);
        after = substr($0,RSTART+RLENGTH);
        $0=before invertedZone(invertedOn++) after;
      }
     
      while (match($0,"a{2,}")) {
        before = substr($0,1,RSTART-1);
        after = substr($0,RSTART+RLENGTH);
        $0=before lightGreenZone(lightGreenOn++) after;
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

      if (match($0,"^#{2,} *")) {
        after = substr($0,RSTART+RLENGTH);
        $0= "    " underline(after);
      }

      print $0;
    }
  }
}
