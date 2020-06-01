#!/bin/bash

echo 'Starting poke ...'
sleep 30
serve -p 3002 -s ./build
echo 'Poke shutting down ...'
exit $?
