# Bash-Scripts
Searching Files Techniques 
A script with the name searching which 
(a) accepts as arguments two integers 
(b) ask the user for the name of a directory;
and based on them display the following on the screen:
(1-3 using the find command and 4-5 with a combination of the ls and grep commands)

1. The files of the given directory tree with authorizations (permissions) the first number (argument) considering it as an octal equivalent.
2. The files in the given directory tree that changed (modified) contents during the last ‘x’ days,  where ‘x’ is the second number (argument).
3. The subdirectories of the given directory tree accessed during the last ‘x’ days,  where ‘x’ is the second number (argument).
4. The files in the given directory in which all users have the right to read.
5. The subdirectories of the given directory to which they have the right to change (create / rename / delete files)  other than the owner and other users of the system.
Before printing any list of the above (1 to 5)  prints an appropriate heading stating the number of files (or subdirectories) to be printed.
Runs the script as many times as the user wishes (for different directories) and at the end (before the final output) displays the total number of found (files / subdirectories)
for each case (from 1 to 5) and for all the directories in which are being  searched. >> 
