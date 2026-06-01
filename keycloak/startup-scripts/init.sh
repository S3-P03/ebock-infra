#!/bin/bash

# Appel du processus d'attente du démarrage de keycloak et ajout des usage
echo "beginning of installation..."

envsubst < /var/tmp/backend.template.json > /var/tmp/backend.json
envsubst < /var/tmp/frontend.template.json > /var/tmp/frontend.json

/var/tmp/setdata.sh &
/opt/keycloak/bin/kc.sh start-dev --http-port "$KEYCLOAK_PORT" --health-enabled=true
