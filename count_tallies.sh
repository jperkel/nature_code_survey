#!/bin/bash
# script to analyze polling data for NatureNews 
# 'code that transformed science' feature (20 Jan 2021)
# 
# supply a CSV on the command line to override default filename below
# pipe output to grep to extract top-line results
# ie: "./count_tallies.sh | grep '>>>'"
#

set -euo pipefail

CSVFILE=~/Downloads/20210211095647-SurveyExport.csv

# search terms
declare -a terms=(" r | r$|r[ ]?studio"
                  "unix|linux"
                  " c | c$|c[+][+]"
                  "latex|tex"
                  "matlab"
                  "mathematica"
                  " basic | basic$"
                  "\bpython|numpy|scipy"
                  "monte carlo|mcmc|markov"
                  "web|www |internet|tcp"
                  "c[.]?o[.]?b[.]?o[.]?l[.]?"
                  "google|pagerank"
                  "html"
                  "lisp"
                  "pascal")


function tally_responses {
   cat $CSVFILE | \
   sed -E 's/([A-Z][a-z]{2} [0-9]{2}), /\1 /' | \
   sed -E 's/([A-Z][a-z]{2} [0-9]{2}), /\1 /' | \
   cut -d, -f22- | \
   sed -E 's/\"//g' | \
   tr [:upper:] [:lower:] | \
   sed -E 's/^the //' | \
   sed -E '/^[[:space:]]*$/d' | \
   sort | \
   uniq -c | \
   sort
}

function do_report {
   echo -e "Data from file: $CSVFILE"

   votes=$(cat $CSVFILE | wc -l)
   echo -e "Total votes: $votes"
   free_responses=$(tally_responses | awk '{ COUNT += $1; } END { print COUNT; }')
   echo -e "Free-text responses: $free_responses\n"

   echo -e "Top responses: "
   tally_responses | tail -n20
   echo ""
   
   for term in "${terms[@]}"; do
      echo -e "---------- [ '$term' ] ----------"
      tally_responses | grep -E "$term"
      tally_responses | grep -E "$term" | awk -v term="$term" '{ SUM += $1 } END { print ">>>Total (" term "): " SUM }'
      echo -e "-------------------------------------------------\n\n"
   done
}

function main {
   if [ "$#" -eq 1 ]; then
      CSVFILE=$1
   fi

   if [ ! -e $CSVFILE ]; then
      echo "File not found: $CSVFILE"
      exit 0
   fi
   
   do_report
}

main "$@"
