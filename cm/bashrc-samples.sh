
empty() {
    for file in "$@"; do
        > "$file"
    done
}
alias home="cd ~"
netman() { ping -c3 -W3 www.google.com;}
alias c="clear"
mkcd() { mkdir "$1" && cd "$1"; }
alias synpatic='synpatic'
alias pochome='cd ~' 
test-path() {
    if [ -e "$1" ]; then
        echo "exists"
    else
        echo "not exists"
    fi
}
