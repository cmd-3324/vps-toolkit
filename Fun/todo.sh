#!/bin/bash

TODO_FILE="$HOME/Sh/todos.txt"
mkdir -p "$HOME/Sh"
touch "$TODO_FILE"

add_task() {
    read -p "Task: " task
    read -p "Priority (low/medium/high): " priority
    read -p "Due date (YYYY-MM-DD): " due_date

    case "$priority" in
        low|medium|high) ;;
        *)
            echo "Invalid priority."
            return
            ;;
    esac

    local id
    if [ -s "$TODO_FILE" ]; then
        id=$(awk -F'|' 'BEGIN {max=0} $1+0 > max {max=$1} END {print max+1}' "$TODO_FILE")
    else
        id=1
    fi

    echo "$id|$task|pending|$priority|$due_date" >> "$TODO_FILE"
    echo "Task #$id added."
}

list_tasks() {
    if [ ! -s "$TODO_FILE" ]; then
        echo "No tasks."
        return
    fi

    printf "%-4s %-30s %-12s %-10s %-12s\n" "ID" "TASK" "STATUS" "PRIORITY" "DUE"
    printf '%s\n' "--------------------------------------------------------------------------"

    awk -F'|' '{
        printf "%-4s %-30s %-12s %-10s %-12s\n", $1, $2, $3, $4, $5
    }' "$TODO_FILE"
}

list_pending() {
    grep '|pending|' "$TODO_FILE" || echo "No pending tasks."
}

list_completed() {
    grep '|completed|' "$TODO_FILE" || echo "No completed tasks."
}

complete_task() {
    read -p "Task ID: " id

    if ! grep -q "^$id|" "$TODO_FILE"; then
        echo "Task not found."
        return
    fi

    sed -i "s/^$id|\\([^|]*\\)|pending|/$id|\\1|completed|/" "$TODO_FILE"
    echo "Task #$id completed."
}

reopen_task() {
    read -p "Task ID: " id

    if ! grep -q "^$id|" "$TODO_FILE"; then
        echo "Task not found."
        return
    fi

    sed -i "s/^$id|\\([^|]*\\)|completed|/$id|\\1|pending|/" "$TODO_FILE"
    echo "Task #$id reopened."
}

delete_task() {
    read -p "Task ID: " id

    if ! grep -q "^$id|" "$TODO_FILE"; then
        echo "Task not found."
        return
    fi

    sed -i "/^$id|/d" "$TODO_FILE"
    echo "Task #$id deleted."
}

delete_completed() {
    sed -i '/|completed|/d' "$TODO_FILE"
    echo "Completed tasks deleted."
}

delete_all() {
    read -p "Delete ALL tasks? (y/n): " confirm

    if [ "$confirm" = "y" ]; then
        > "$TODO_FILE"
        echo "All tasks deleted."
    else
        echo "Cancelled."
    fi
}

search_tasks() {
    read -p "Search: " query

    grep -i "$query" "$TODO_FILE" || echo "No matching tasks."
}

edit_task() {
    read -p "Task ID: " id

    if ! grep -q "^$id|" "$TODO_FILE"; then
        echo "Task not found."
        return
    fi

    old_task=$(grep "^$id|" "$TODO_FILE" | cut -d'|' -f2)
    old_status=$(grep "^$id|" "$TODO_FILE" | cut -d'|' -f3)
    old_priority=$(grep "^$id|" "$TODO_FILE" | cut -d'|' -f4)
    old_due=$(grep "^$id|" "$TODO_FILE" | cut -d'|' -f5)

    read -p "Task [$old_task]: " task
    read -p "Priority [$old_priority]: " priority
    read -p "Due date [$old_due]: " due_date

    task=${task:-$old_task}
    priority=${priority:-$old_priority}
    due_date=${due_date:-$old_due}

    case "$priority" in
        low|medium|high) ;;
        *)
            echo "Invalid priority."
            return
            ;;
    esac

    sed -i "s|^$id|.*|$id|$task|$old_status|$priority|$due_date|" "$TODO_FILE"

    echo "Task #$id updated."
}

filter_priority() {
    read -p "Priority (low/medium/high): " priority

    grep "|$priority|" "$TODO_FILE" || echo "No matching tasks."
}

filter_due_date() {
    read -p "Due date (YYYY-MM-DD): " date

    grep "|$date$" "$TODO_FILE" || echo "No matching tasks."
}

sort_priority() {
    awk -F'|' '
    $4=="high" {print "1|" $0}
    $4=="medium" {print "2|" $0}
    $4=="low" {print "3|" $0}
    ' "$TODO_FILE" |
    sort -t'|' -k1,1n |
    cut -d'|' -f2-
}

sort_due_date() {
    sort -t'|' -k5,5 "$TODO_FILE"
}

statistics() {
    total=$(wc -l < "$TODO_FILE")
    completed=$(grep -c '|completed|' "$TODO_FILE")
    pending=$(grep -c '|pending|' "$TODO_FILE")
    high=$(grep -c '|high|' "$TODO_FILE")
    medium=$(grep -c '|medium|' "$TODO_FILE")
    low=$(grep -c '|low|' "$TODO_FILE")

    echo
    echo "===== STATISTICS ====="
    echo "Total:     $total"
    echo "Pending:   $pending"
    echo "Completed: $completed"
    echo
    echo "High:      $high"
    echo "Medium:    $medium"
    echo "Low:       $low"
}

while true; do
    echo
    echo "========== TODO =========="
    echo "1.  Add task"
    echo "2.  List all tasks"
    echo "3.  List pending"
    echo "4.  List completed"
    echo "5.  Complete task"
    echo "6.  Reopen task"
    echo "7.  Edit task"
    echo "8.  Delete task"
    echo "9.  Delete completed"
    echo "10. Delete all"
    echo "11. Search"
    echo "12. Filter priority"
    echo "13. Filter due date"
    echo "14. Sort priority"
    echo "15. Sort due date"
    echo "16. Statistics"
    echo "17. Exit"
    echo

    read -p "Choose: " choice

    case "$choice" in
        1) add_task ;;
        2) list_tasks ;;
        3) list_pending ;;
        4) list_completed ;;
        5) complete_task ;;
        6) reopen_task ;;
        7) edit_task ;;
        8) delete_task ;;
        9) delete_completed ;;
        10) delete_all ;;
        11) search_tasks ;;
        12) filter_priority ;;
        13) filter_due_date ;;
        14) sort_priority ;;
        15) sort_due_date ;;
        16) statistics ;;
        17)
            echo "Goodbye."
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
