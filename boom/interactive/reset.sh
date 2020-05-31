#!/bin/bash

curl -X PUT \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer $TOKEN" \
  --data-raw '{ "current": 1000 }' \
  'http://localhost:3001/v1/current'
echo

curl -X PUT \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer $TOKEN" \
  'http://localhost:3001/v1/current?current=1000'
echo
