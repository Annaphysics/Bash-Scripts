#!/bin/bash

echo "|===============================================================================================|"
echo "|------------------------------------WELCOME VISITOR--------------------------------------------|"
echo "|===============================================================================================|"
read -p 'Give File Permision Code No: ' n1
echo "================================================================================================"
read -p 'How many days since Files last  modification: ' n2
echo "================================================================================================"
PS3='Please enter your choice: '
options=("Files with given permission" "Modified Files" "Accessed SubFolders" "Readable Files for all users" "Free access SubFolders" "Quit")
uc="y"
t1=0
t3=0
t4=0
t7=0
t8=0
t9=0
while [ ${uc} = "y" ];
do 
  read -p 'Give the name of Folder you want to search: ' dname
  echo "=============================================================================================="
  echo "--------------------------------------OPERATION MENU------------------------------------------"
  echo "=============================================================================================="
select opt in "${options[@]}"
do 
    case $opt in
        "Files with given permission")
            
            if [ ! -d $dname ]
               then
                    echo file does not exist
                     else
                     t1=$(find $dname -maxdepth 1 -type f -perm $n1 | wc -l) 
                     
                     echo $t1 Files have the given permission  $n1  in Folder $dname 
                     find $dname -perm $n1 
            
                     echo "=============================================================================================="
            fi
    ;;
        "Modified Files")
            t3=$(find ./$dname -maxdepth 1 -type f -mtime -$n2 | wc -l)
            echo $t3 Files were modified the last $n2 days in Folder $dname 
            find $dname -maxdepth 1 -type f -mtime -$n2
            
            echo "=============================================================================================="
    ;;
        "Accessed SubFolders")
             t4=$(find ./$dname -maxdepth 1 -type d -atime -$n2 | wc -l) 
            echo $t4 SubFolders were modified during the last $n2 days in directory $dname 
            
            find $dname -type d -atime -$n2 
           
            echo "=============================================================================================="
            ;;
        "Readable Files for all users")
             t7=$(find ./$dname -maxdepth 1 -type f -exec ls -l {} \; | grep -e ^-r--r--r-- | wc -l)       
             echo $t7 Files are Readable by everyone in Folder $dname 
             find $dname -type f -exec ls -l {} \; | grep -e ^-r--r--r--    
             
            echo "=============================================================================================="
            ;;
        "Free access SubFolders")

            t8=$(find ./$dname -type d -exec ls -l {} \; | grep ^d |grep -e ^drwxrwxrwx |wc -l)    

             echo $t8 SubFolders are Readable by everyone in Folder $dname 

             find $dname -type d -exec ls -l {} \; | grep ^d |grep -e ^drwxrwxrwx   
             
            #-type d -exec ls -la {} \; | grep ^d | grep -v ^drwxrwxr-x
            echo "=============================================================================================="
            ;;
        "Quit")
            break
            ;;
        *)
         echo "invalid option $REPLY";;
    esac
     done
     let t9=$t1+$t3+$t4+$t7+$t8
     echo "=============================================================================================="
     echo $t9 total Files and SubFolders of $dname  being searched by User
     echo "=============================================================================================="
read -p 'Do you want to continue ? (y/n): ' uc
if [ ${uc} = "n" ]
then 
echo "=============================================================================================="
echo "-------------------Good Bye!! See you soon with another Cartoon!!-----------------------------"
echo "=============================================================================================="
fi
done
