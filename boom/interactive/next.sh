#!/bin/bash

source './interactive/helpers.sh'

token_required

curl -X GET \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer $TOKEN" \
  "${REACT_APP_BOOM_URL}/next"
echo
