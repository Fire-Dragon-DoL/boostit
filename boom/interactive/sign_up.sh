#!/bin/bash

source './interactive/helpers.sh'

curl -X POST \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -i \
  --data-raw "{ \"user\": { \"email\": \"$DEFAULT_USER_EMAIL\", \"password\": \"$DEFAULT_USER_PASS\", \"password_confirmation\": \"$DEFAULT_USER_PASS\" } }" \
  "${REACT_APP_BOOM_URL}/users"
echo

echo 'Please export the TOKEN as given in the headers (without `Bearer `)'
echo 'export TOKEN=""'
