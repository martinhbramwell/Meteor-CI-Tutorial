#!/usr/bin/awk -f
#

function blue(s) {
    return "\033[1;34m" s "\033[0m"
}

function green(s) {
    return "\033[1;32m" s "\033[0m"
}

function lightRed(s) {
    return "\033[1;91m" s "\033[0m"
}

function lightGreen(s) {
    return "\033[1;92m" s "\033[0m"
}

function inverted(s) {
    return "\033[7m" s "\033[27m"
}

function underline(s) {
    return "\033[4m" s "\033[24m"
}

function boldZone(count) {
  if (count%2 > 0) return "\033[1m";
  return "\033[21m";
}

function paleZone(count) {
  if (count%2 > 0) return "\033[2m";
  return "\033[22m";
}

function invertedZone(count) {
  if (count%2 > 0) return "\033[7m";
  return "\033[27m";
}

function lightGreenZone(count) {
  if (count%2 > 0) return "\033[1;92m";
  return "\033[0m";
}

function magentaZone(count) {
  if (count%2 > 0) return "\033[1;35m";
  return "\033[0m";
}

function greenZone(count) {
  if (count%2 > 0) return "\033[1;32m";
  return "\033[0m";
}

function blueZone(count) {
  if (count%2 > 0) return "\033[1;34m";
  return "\033[0m";
}

function lightBlueZone(count) {
  if (count%2 > 0) return "\033[1;94m";
  return "\033[0m";
}

function italicsZone(count) {
  if (count%2 > 0) return "\033[1;94m";
  return "\033[0m";
}

function terminalSyntaxHighlight(count, line) {
  if (count%2 > 0) return "\033[0m"line"\n";
  return "\n"line;
}

BEGIN {
#  print lightRed("\n -- start --");
  blueOn=1;
  invertedOn=1;
  lightBlueOn=1;
  lightGreenOn=1;
  magentaOn=1;
  greenOn=1;
  boldOn=1;
  italicsOn=1;
  terminalSyntaxOn=1;
  linelength=99;
}

