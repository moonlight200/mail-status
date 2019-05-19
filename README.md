# mail-status

This script will send an email with a summary of the current system status. If sent frequently these status emails might help investigating in case of an error on the system.

## Usage

```
./mail_status.sh <recipient>
```

## Installation

1. Make sure the `mailutils` package is installed and your system is capable of sending emails.
2. Copy the script into a folder of your liking on your system. (In this example `/root/scripts`)
3. Add a new cronjob to execute the script every so often. Make sure to run the script as the root user.  
E.g. to run the script once a day:  
```
0 0 * * * /root/scripts/mail_status.sh foo@example.com > /dev/null
```
