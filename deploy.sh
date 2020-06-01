#!/bin/bash

set -e
set -a

git subtree push --prefix boom heroku-boom master
git subtree push --prefix poke heroku-poke master
