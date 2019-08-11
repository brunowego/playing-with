#! /bin/sh
set -e

mkdir -p /etc/security/keytabs

if [ ! -f '/etc/security/keytabs/eniac.keytab' ]; then
  kadmin -w peniac -p eniac -q 'addprinc -randkey workstation/through-keytab'
  kadmin -w peniac -p eniac -q 'ktadd -k /etc/security/keytabs/eniac.keytab workstation/through-keytab'
fi

exec "$@"
