#!/bin/sh
SCRIPT=$(readlink -f $0)
ROOT=`dirname $SCRIPT`

# read config vars
. $ROOT/config.system
. $ROOT/config.user


# Add mhonarc to path:
PERL5LIB=$MHONARC/lib:$PERL5LIB
export PERL5LIB

# Impl function: Run fetchmail w/ stdin config
go()
{
    LABEL=$1
    # Make sure HTML folder exists.
    mkdir -p $HTMLPATH/$LABEL
    export LABEL
    export URLROOT
    fetchmail --fetchmailrc - <<EOF
poll $SERVER protocol $PROTO
  user $ADDR with password "$SECRET"
  folder $LABEL
  $SSL
  keep
mda "perl $MHONARC/examples/mha-preview -prv-maxlen 2048 -main -folrefs -outdir $HTMLPATH/$LABEL -otherindexes $ROOT/mhonarc-rss.rc --add"

EOF
}

# Actually do the work:
for l in $LABELS; do go $l; done