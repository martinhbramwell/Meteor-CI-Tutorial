#!/usr/bin/awk -f
#

@include "./scripts/functions.awk";

{
  # Triple back quotes at start of line mark lines of code

  if (match($0,"^`{2,}")) {

    print terminalSyntaxHighlight(terminalSyntaxOn++, gensub(/0/, "   -:-   ", "g", sprintf("| %0*d |", linelength/9, 0)));

  } else {

    if ( terminalSyntaxOn % 2 < 1 ) {

      gsub(/'/, "±", $0);
      gsub(/\\/, "\\\\", $0);
#      command = "./shellSyntaxHiLite.sh '"$0"'";
      command = "echo '"$0"' | sed \"s/±/'/g\" | pygmentize -l bash";
      if ( (command | getline var) > 0) { print "   "var; };
      close(command);

    } else {

      print $0;
    }
  }
}
