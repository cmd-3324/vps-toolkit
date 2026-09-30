ask_user() {
    echo "Are you okay?"
    echo "1) Yes"
    echo "2) No"
    echo "3) We'll see"

    read -p "Choose: " choice

    case "$choice" in
        1) echo "You chose Yes" ;;
        2) echo "You chose No" ;;
        3) echo "You chose We'll see" ;;
        *) echo "Invalid choice" ;;
    esac
}

ask_user

# This is a demo , sample Shell script for Devs.
# I know it is rediclouse But This is just a fun - one time thign I created During This Long But SHort Jounrey.
# People Know What I mean; 30 Sep 
