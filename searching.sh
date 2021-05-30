#!/bin/bash
#4. Να γραφτεί script με το όνομα searching το οποίο (α) να δέχεται ως ορίσματα δύο ακεραίους αριθμούς και 
#(β) να ζητάει από το χρήστη το όνομα ενός καταλόγου, 
#και με βάση αυτά να εμφανίζει στην οθόνη τα ακόλουθα 
#(τα 1-3 με χρήση της εντολής find και τα 4-5 με συνδυασμό των εντολών ls και grep): 
#1. Τα αρχεία του δέντρου του δοθέντος καταλόγου με εξουσιοδοτήσεις (permissions) τον πρώτο αριθμό (όρισμα) 
#θεωρώντας τον ως οκταδικό ισοδύναμο.
#2. Τα αρχεία του δέντρου του δοθέντος καταλόγου που άλλαξαν (modify) περιεχόμενα κατά τις ‘x’ τελευταίες μέρες, 
#όπου ‘x’ ο δεύτερος αριθμός (όρισμα).
#3. Τους υποκαταλόγους του δέντρου του δοθέντος καταλόγου που προσπελάστηκαν (access) κατά τις ‘x’ τελευταίες μέρες, 
#όπου ‘x’ ο δεύτερος αριθμός (όρισμα).
#4. Τα αρχεία του δοθέντος καταλόγου στα οποία έχουν δικαίωμα ανάγνωσης όλοι οι χρήστες.
#5. Τους υποκαταλόγους του δοθέντος καταλόγου στους οποίους έχουν δικαίωμα αλλαγών (create/rename/delete files)
#εκτός από τον ιδιοκτήτη και άλλοι χρήστες του συστήματος. 
#Πριν από τον εκτύπωση κάθε λίστας από τις παραπάνω (1 έως 5) 
#να τυπώνεται κατάλληλη επικεφαλίδα η οποία να αναφέρει μεταξύ άλλων και τον αριθμό των αρχείων (ή υποκαταλόγων) 
#που πρόκειται να τυπωθούν. Το script να εκτελείται επαναληπτικά όσο επιθυμεί ο χρήστης (για διαφορετικούς καταλόγους) 
#και στο τέλος (πριν την τελική έξοδο) να εμφανίζει αθροιστικά το συνολικό αριθμό των ευρεθέντων (αρχείων / υποκαταλόγων) 
#κάθε περίπτωσης (από τις 1 έως 5) για όλους τους καταλόγους στους οποίους έψαξε.>>

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
