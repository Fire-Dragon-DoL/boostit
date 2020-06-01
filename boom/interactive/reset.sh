#!/bin/bash

source './interactive/helpers.sh'

token_required

current=${1:-'1000'}

echo "Current will be set to: ${current}, change it by passing a different value in the first argument"

echo 'Setting through JSON body ...'
curl -X PUT \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer $TOKEN" \
  --data-raw "{ \"current\": ${current} }" \
  "${REACT_APP_BOOM_URL}/current"
echo

echo 'Setting through URL query parameters ...'
curl -X PUT \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer $TOKEN" \
  "${REACT_APP_BOOM_URL}/current?current=${current}"
echo
