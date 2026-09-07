#!/bin/bash
threshold=70
usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$usage" -gt "$threshold" ]; then
    echo "Warning: Disk Usage is at ${usage}%"
else
    echo "Disk Okay: ${usage}%"
fi
# tail -1 chooses last line of df / as plain text, then awk chooses 5th col of last line and tr -d  deleted (trims) % from n%
#disk usage

# if we want our var to be in a string and if it is gonna be followed by a char like % , it must be in () or { }
 
