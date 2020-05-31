#!/bin/bash

set -e

echo 'Starting boom ...'
sleep 30
rails db:create
rails db:migrate
rails s
exit $?
