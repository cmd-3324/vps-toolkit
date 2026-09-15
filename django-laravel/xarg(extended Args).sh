find . -name "*.log" | xargs grep "error"

#@
ls *.sh | xargs wc -l

#3

find ~/mini-digi -name "*.py" | xargs chmod 644

#4

find ~/backups -name "*.tar.gz" -mtime +25 -print0 | xargs -0 rm

#-0 — that's a zero (the digit), not the letter O. Easy mix-up given the font
