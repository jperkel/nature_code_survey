# nature_code_survey

Scripts to tally free-text responses the 'Code that transformed science' NatureNews poll.

1. Run the script `tally_free_responses.sh` to extract the free responses column from the survey dataset. (The result is given in `free_responses.txt`.)
2. To extract top-line results, pipe the output to grep: `./tally_free_responses.sh | grep '>>>'`.
3. `code_survey_graph.R` graphs a CSV created from those top-line results. 
