#!/bin/bash

echo 'Starting boom ...'
sleep 30
rails db:schema:load
rails s
echo 'Boom shutting down ...'
exit $?
