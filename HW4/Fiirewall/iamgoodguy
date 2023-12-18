#!/bin/sh

# Check for correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: iamgoodguy <IP> -p <ssh|web>"
    exit 1
fi

# Assign arguments to variables
IP=$1
PROTOCOL=$3

# Define Fail2Ban jail name based on protocol
case $PROTOCOL in
    ssh)
        JAIL="sshd"
        ;;
    web)
        JAIL="nginx-http-auth" # or nginx, depending on the web server
        ;;
    *)
        echo "Invalid protocol. Use 'ssh' or 'web'."
        exit 1
        ;;
esac

# Unban the IP
sudo fail2ban-client set $JAIL unbanip $IP

# Check if the unban command was successful
if [ $? -eq 0 ]; then
    echo "IP $IP has been unbanned from $JAIL."
else
    echo "Failed to unban IP $IP from $JAIL."
fi