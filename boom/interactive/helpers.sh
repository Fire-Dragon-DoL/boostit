#!/bin/bash

token_required() {
  if [ -z "$TOKEN" ]; then
    echo "TOKEN needs to be set"
    exit 1
  fi
  return 0
}

api_url_required() {
  if [ -z "$REACT_APP_BOOM_URL" ]; then
    export REACT_APP_BOOM_URL='http://localhost:3001/v1'
    echo "REACT_APP_BOOM_URL is unset"
    echo "Defaulting to: $REACT_APP_BOOM_URL"
  fi
  return 0
}

default_user() {
  echo 'foo@bar.com'
}

default_password() {
  echo 'foobarbaz'
}

api_url_required

tmp_default_user_email='foo@bar.com'
export DEFAULT_USER_EMAIL="${DEFAULT_USER_EMAIL:-$tmp_default_user_email}"
tmp_default_user_pass='foobarbaz'
export DEFAULT_USER_PASS="${DEFAULT_USER_PASS:-$tmp_default_user_pass}"
