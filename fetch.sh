#!/bin/sh
SCRIPT=$(readlink -f $0)
ROOT=`dirname $SCRIPT`

# read config vars
. $ROOT/config.user
. $ROOT/config.system



# Add mhonarc to path:
PERL5LIB=$MHONARC/lib $PERL5LIB
export PERL5LIB

# Impl function: Run fetchmail w/ stdin config
go()
{
    LABEL=$1
    # Make sure HTML folder exists.
    mkdir -p $HTMLPATH/$LABEL

    fetchmail --fetchmailrc - <<EOF
poll $SERVER protocol IMAP
  user $ADDR with password "$SECRET"
  folder $LABEL
  ssl
  keep
mda "perl $MHONARC/examples/mha-preview -main -folrefs -outdir $HTMLPATH/$LABEL -otherindexes $ROOT/mhonarc-rss.rc --add"

EOF
}

# Actually do the work:
for l in $LABELS; do go $l; done