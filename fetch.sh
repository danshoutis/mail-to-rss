#!/bin/sh
SCRIPT=$(readlink -f $0)
ROOT=`dirname $SCRIPT`

# read config vars
. $ROOT/config.user
. $ROOT/config.system

# Make sure HTML folder exists.
mkdir -p $HTMLPATH/$LABEL

# Add mhonarc to path:
PERL5LIB=$MHONARC/lib $PERL5LIB
export PERL5LIB

# Run fetchmail w/ stdin config
fetchmail --fetchmailrc - <<EOF
poll $SERVER protocol IMAP
  user $ADDR with password "$SECRET"
  folder $LABEL
  ssl
  keep
mda "perl $MHONARC/examples/mha-preview -main -folrefs -outdir $HTMLPATH/$LABEL -otherindexes $ROOT/mhonarc-rss.rc --add"

EOF

