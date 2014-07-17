#!/bin/bash

if [ $# -ne 1 ]
then
  echo -e "Usage: $(basename $0) certfile.pfx\n"
  exit 1
fi


CERTNAME="$(basename $1 .pfx)"

openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTNAME} -out ${CERTNAME}.key.pem -nocerts -nodes
openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTNAME} -out ${CERTNAME}.crt.pem -clcerts -nodes -nokeys
openssl pkcs12 -in ${CERTNAME}.pfx -passin pass:${CERTNAME} -out ${CERTNAME}.ca.pem -cacerts -nodes -nokeys

