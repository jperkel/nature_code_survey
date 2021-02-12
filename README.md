# nature_code_survey

Scripts to tally free-text responses the 'Code that transformed science' NatureNews poll.

1. Run the script `tally_free_responses.sh` to extract the free responses column from the survey dataset. (The result is given in `free_responses.txt`.)
2. To extract top-line results, pipe the output to grep: `./tally_free_responses.sh | grep '>>>'`. In this case, the output is:

```
>>>Total ( r | r$|r[ ]?studio): 126
>>>Total (unix|linux): 87
>>>Total ( c | c$|c[+][+]): 74
>>>Total (latex|tex): 41
>>>Total (matlab): 44
>>>Total (mathematica): 40
>>>Total ( basic | basic$): 34
>>>Total python|numpy|scipy): 37
>>>Total (monte carlo|mcmc|markov): 21
>>>Total (web|www |internet|tcp): 24
>>>Total (c[.]?o[.]?b[.]?o[.]?l[.]?): 22
>>>Total (google|pagerank): 16
>>>Total (html): 13
>>>Total (lisp): 14
>>>Total (pascal): 12
```

3. `code_survey_graph.R` graphs a CSV created from those top-line results. 
