#!/bin/bash

echo 'Starting boom test suite ...'
sleep 30
rails db:test:load
rails test:db
exit $?
