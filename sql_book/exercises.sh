#!/bin/zsh

# Execute using: ./exercises.sh encyclopedia (or other db name)
# Must have encyclopedia.sql and a corresponding encyclopedia db in Postgres.
# May need to run: sudo chmod +x exercises.sh  

DATABASE_NAME=$1

dropdb $DATABASE_NAME
createdb $DATABASE_NAME

psql $DATABASE_NAME -f $DATABASE_NAME.sql