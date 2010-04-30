#!/bin/sh
SCRIPT=$(readlink -f $0)
ROOT=`dirname $SCRIPT`

# read config vars
. $ROOT/config

# make sure delivery folder exists
mkdir -p $DELIVERY

PROCMAILRC=$ROOT/procmailrc

echo "GMail addr is: " $ADDR
echo "Procmail at: " $PROCMAILRC

FETCHALL=""
[ -f $DELIVERY/$LABEL ] || FETCHALL="fetchall"
echo "Fetchall is: " $FETCHALL


# Run fetchmail w/ stdin config
fetchmail --fetchmailrc - <<EOF
poll $SERVER protocol IMAP
  user $ADDR with password "$SECRET"
  folder $LABEL
  ssl
  keep
  $FETCHALL
mda "procmail -m MAILDIR=$DELIVERY DEFAULT=$LABEL $PROCMAILRC"
EOF
