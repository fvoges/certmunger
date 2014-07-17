#!/bin/bash

if [ $# -ne 1 ]
then
  echo -e "Usage: $(basename $0) certfile.pfx\n"
  exit 1
fi


CERTNAME="$(dirname $1)/$(basename $1 .pfx)"
CERTPASS="$(basename $1 .pfx)"

openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTPASS} -out ${CERTNAME}.private_key.pem -nocerts -nodes
openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTPASS} -out ${CERTNAME}.cert.pem -clcerts -nodes -nokeys
openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTPASS} -out ${CERTNAME}.ca_cert.pem -cacerts -nodes -nokeys
openssl rsa -in ${CERTNAME}.private_key.pem -out ${CERTNAME}.public_key.pem -pubout

