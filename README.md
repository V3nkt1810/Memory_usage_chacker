Memory Utilization Monitoring Script

This Bash script is designed to monitor memory utilization on multiple servers remotely using SSH. It reads a list of server hostnames from a text file, connects to each server, and retrieves the top 5 processes consuming the most memory. The output is displayed in a formatted table with columns for PID, USER, MEM(%), and COMMAND.

Features:

Reads a list of server hostnames from a text file.
Connects to each server via SSH and retrieves memory utilization details per process.
Displays the top 5 memory-consuming processes in a structured table format.
Provides error handling for missing or invalid input files.
