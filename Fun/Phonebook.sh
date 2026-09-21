#!/bin/bash
PHONEBOOK="$HOME/Sh/phone_book.txt"
mkdir -p "$HOME/Sh"
touch "$PHONEBOOK"
while true; do
    echo
    echo "===== PHONEBOOK ====="
    echo "1. Add contact"
    echo "2. List contacts"
    echo "3. Search contact (Using Name)"
    echo "4. Delete contact"
    echo "5. Delete All"
    echo "6. Exit"
    read -p "Choose: " choice
    case "$choice" in
       1)
            read -p "Name: " name
            read -p  "Phone Number: " phone
            echo "$name|$phone" >> "$PHONEBOOK"
            echo "Contact With Name $name & Phone Number $phone added."
            ;;
        2)
            cat "$PHONEBOOK"
            ;;
        3)
            read -p "Search Contact: " name_
            grep -i "$name_" "$PHONEBOOK" 
            ;;
        4)
            sed -i "/^$name|/d" "$PHONEBOOK"
            echo "Contact With Name : $name was deleted"
            ;;
        5)
            read -p "Are You Sure ?(y/n) " confirm
            if [ "$confirm" = "y" ]; then 
            	> "$PHONEBOOK"
            	echo "Deleted All Contacts"
            elif [ "$confirm" = "n" ]; then
               echo "Rejected to Delete All Users"
            else
              echo "Invalide Input"
            fi
            ;;
        6)
            echo "Goodbye."
            break
            ;;
            
        *)
            echo "Invalid Input"
            ;;
     esac
done
            
            
            
            
            
