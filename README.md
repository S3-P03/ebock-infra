# ebock-infra
This repository contains the files for deployment of containers for the app.

## Requirements
Make sure you have these installed before proceeding with this repository :

    - Docker
    - Docker Compose
    - Node.js

Copy the .env file from the Teams group into the root of this project. This file contains environment variables that are required to run the projet.

## Structure
The app runs with multiple containers : 

    - ebock-frontend : Frontend client (Based on build)
    - ebock-backend : Frontend server (Based on Dockerfile)
    - migrate : One-time execution database migration scripts
    - ebock-db : PostgreSQL database for application and auth data
    - auth : Keycloak server for authentication and authorizations


## Deployment

To run containers, use the command 
`docker compose up`

For the first time and when frontend or backend changes, use the file deploy.sh. The script rebuilds the application then runs the containers.

## Contribution

Any work must be done on the dev branch.
Changes to the database must be done through migrations named : 
**###_description_of_migration.sql**, ### being the number of the last migration + 1.
The migrations will be executed on the next docker compose up.

## Data

Data is saved using a docker volume, which can be reset with the command
`docker compose down -v`