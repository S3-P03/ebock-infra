#!/bin/bash

cd ../ebock-frontend

npm install
npm run build

cd ../ebock-infra

cp -a ../ebock-frontend/build/. ./webserver/html

docker compose down
docker compose up -d