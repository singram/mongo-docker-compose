#!/usr/bin/env sh

echo "Stalling for MongoDB"
while true; do
    nc -q 1 database 27017 >/dev/null && break
done

/usr/bin/supervisord
