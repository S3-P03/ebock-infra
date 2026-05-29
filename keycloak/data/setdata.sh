#!/bin/bash

timeout 300 /bin/bash -c 'until curl -sI -o /dev/null -w "%{http_code}\n" "$KEYCLOAK_URL"; do sleep 5; done;'

echo "beginning of finalisation ...."
/opt/keycloak/bin/kcadm.sh config credentials --server "$KEYCLOAK_URL" --realm master --user "$KEYCLOAK_ADMIN" --password "$KEYCLOAK_ADMIN_PASSWORD"
/opt/keycloak/bin/kcadm.sh create realms -s realm=ebock -s enabled=true -o

/opt/keycloak/bin/kcadm.sh create clients -r ebock -f /var/tmp/frontend.json
/opt/keycloak/bin/kcadm.sh create clients -r ebock -f /var/tmp/backend.json

/opt/keycloak/bin/kcadm.sh create partialImport -r ebock -s ifResourceExists=OVERWRITE -f /var/tmp/users.json

echo -e -n "\r"
echo "server running ...."