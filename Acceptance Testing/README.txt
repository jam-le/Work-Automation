Instructions to use these scripts:

1.) Open the run.rb file as a text file to edit the code. List your commands under the string of hash marks (#).
2.) Open the variables.rb file as a text file.


Commands that you can type into the run.rb file:

start               Selects database and opens the ppt in GUI
set_emplstat        Sets the various employment statuses through HEDAT



If you type the command start in run.rb, you must set the variable INTN_ID and TEST_DB equal to the desired values. These variables can be found in the variables.rb text file. For the TEST_DB, the 3rd trans will always be chosen b/c I set it up that way.

If you type the set_emplstat command into run.rb, you must specify all of the employment statuses listed in the variables.rb text file. If you wish to skip a field, set the value to nil.

When you are ready to run your code, enter "ruby run.rb" inside the cmd line. (Go to the Windows "Start" menu and search "cmd").