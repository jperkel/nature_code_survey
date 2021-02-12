#!/bin/bash
# script to analyze polling data for NatureNews 
# 'code that transformed science' feature (20 Jan 2021)
# 
# supply a CSV on the command line to override default filename below
# pipe output to grep to extract top-line results
# ie: "./tally_free_responses.sh | grep '>>>'"
#

set -euo pipefail

# set to 0 if the survey CSV file is not available, 1 if it is
CSV_AVAILABLE=1
CSVFILE=~/Downloads/20210211095647-SurveyExport.csv
FREE_RESPONSES=free_responses.txt 

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
                  
function tally_free_responses {
   cat $FREE_RESPONSES | \
   sed -E 's/\"//g' | \
   tr [:upper:] [:lower:] | \
   sed -E '/^[[:space:]]*$/d' | \
   sort | \
   uniq -c | \
   sort
}

function do_report {
   if [[ "$CSV_AVAILABLE" == 1 ]]; then
      echo -e "Data from file: $CSVFILE"
      Rscript extract_answers.R $CSVFILE > $FREE_RESPONSES

      votes=$(cat $CSVFILE | tail +2 | wc -l)
      echo -e "Total votes: $votes"
   fi 

   free_responses=$(tally_free_responses | awk '{ COUNT += $1; } END { print COUNT; }')
   echo -e "Free-text responses: $free_responses\n"

   echo -e "Top responses: "
   tally_free_responses | tail -n20
   echo ""
   
   for term in "${terms[@]}"; do
      echo -e "---------- [ '$term' ] ----------"
      tally_free_responses | grep -E "$term"
      tally_free_responses | grep -E "$term" | awk -v term="$term" '{ SUM += $1 } END { print ">>>Total (" term "): " SUM }'
      echo -e "-------------------------------------------------\n\n"
   done
}

function main {
   if [[ "$CSV_AVAILABLE" == 1 ]]; then
      if [ "$#" -eq 1 ]; then
         CSVFILE=$1
      fi

      if [ ! -e $CSVFILE ]; then
         echo "File not found: $CSVFILE"
         exit 0
      fi
   fi 

   do_report
}

main "$@"