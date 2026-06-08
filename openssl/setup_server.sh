#!/bin/bash

openssl --version -a

if [ ! -f /certs/ecdsa.key ]
then
    openssl req -x509 -newkey ec:<(openssl ecparam -name prime256v1) -nodes -keyout /certs/ecdsa.key -out /certs/ecdsa.crt -days 365 -sha256 -subj "/C=US/ST=State/L=City/O=Company/CN=example.com"
fi

openssl s_server -accept 0.0.0.0:4443 -cert /certs/ecdsa.crt -key /certs/ecdsa.key -WWW

