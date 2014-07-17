#!/bin/bash

if [ $# -ne 1 ]
then
  echo -e "Usage: $(basename $0) certfile.pfx\n"
  exit 1
fi


CERTNAME="$(dirname $1)/$(basename $1 .pfx)"
CERTPASS="$(basename $1 .pfx)"

openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTPASS} -out ${CERTNAME}.key.pem -nocerts -nodes
openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTPASS} -out ${CERTNAME}.crt.pem -clcerts -nodes -nokeys
openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTPASS} -out ${CERTNAME}.ca.pem -cacerts -nodes -nokeys
openssl rsa -in ${CERTNAME}.key.pem -out ${CERTNAME}.pubkey.pem -pubout

