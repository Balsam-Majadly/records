#!/bin/bash
source add.sh
source validation_file.sh
source search.sh
source printAll.sh
source amount.sh
source rename.sh
source search_amount.sh
source delete.sh


function menu {
local file_name="$1"
while true
do
    clear
    echo "Welcome to the Record Collection Menu"
    echo "1. Add Entry"
    echo "2. Delete Entry"
    echo "3. Search by Name"
    echo "4. Change Name"
    echo "5. Change Amount"
    echo "6. Print records sum amount"
    echo "7. Print ALL of them"
    echo "8. Exit"
    read -p "Please choose an option: " choice
    case $choice in
        1)
            add "$file_name"
            read -p "Press Enter to continue"
            ;;
        2)
            delete "$file_name"
            read -p "Press Enter to continue"
            ;;
        3)
            menu_search $file_name
            read -p "Press Enter to continue"
            ;;
        4)
            rename "$file_name"
            read -p "Press Enter to continue"
            ;;
        5)
            amount "$file_name"
            read -p "Press Enter to continue"
            ;;
        6)
            Print_Amount "$file_name"
            read -p "Press Enter to continue"
            ;;
        7)
            print_All "$file_name"
            read -p "Press Enter to continue"
            ;;
        8)
            echo "Exiting Record Collection Menu"
            exit 5
            ;;
        *)
            echo "Choose nums between 1-9"
            sleep 3
            read -p "Press Enter to continue"
            ;;
    esac
done
}
