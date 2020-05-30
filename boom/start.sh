#!/bin/bash

sleep 30
rails db:create
rails db:migrate
rails s
exit $?
