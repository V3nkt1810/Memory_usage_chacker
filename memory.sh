#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 vuser.txt"
    exit 1
fi

server_list=$1

if [ ! -f "$server_list" ]; then
    echo "File $server_list not found!"
    exit 1
fi

# Function to format output in a table-like structure
print_table() {
    printf "%-10s %-20s %-10s %-8s %-s\n" "PID" "USER" "MEM(%)" "COMMAND"
    printf "%-10s %-20s %-10s %-8s %-s\n" "--------" "--------------------" "--------" "-------------------------"
}

while IFS= read -r server_name; do
    echo "---------------------------------------------"
    echo "Checking Memory utilization on $server_name"
    echo "---------------------------------------------"
    
    ssh -q $server_name '
    print_table() {
        printf "%-10s %-20s %-10s %-8s %-s\n" "PID" "USER" "MEM(%)" "COMMAND"
        printf "%-10s %-20s %-10s %-8s %-s\n" "--------" "--------------------" "--------" "-------------------------"
    }
    
    print_table
    
    ps -eo pid,user,%mem,comm --sort=-%mem | head -6 | tail -5 | while read pid user mem cmd; do
        printf "%-10s %-20s %-10s %-8s %-s\n" "$pid" "$user" "$mem" "$cmd"
    done
    '
    echo End "\n"
done < "$server_list"
