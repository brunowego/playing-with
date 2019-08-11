#! /bin/sh
set -e

if [ ! -f '/var/kerberos/krb5kdc/principal' ]; then
  kdb5_util -P "$KDB5_MASTER_PASSWORD" -r EXAMPLE.COM create -s

  kadmin.local -q 'addprinc -pw peniac eniac'
  kadmin.local -q 'addprinc -pw pjohndoe johndoe'
fi

exec "$@"
