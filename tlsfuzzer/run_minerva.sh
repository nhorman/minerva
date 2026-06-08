#!/bin/bash
./scripts/test_tls13_minerva.py -h localhost -p 4443 --repeat 500000 --priv-key /certs/ecdsa.key -i lo -o /results --curve P-256 --verbose  
