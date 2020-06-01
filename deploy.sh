#!/bin/bash

set -e
set -a

git subtree push --prefix boom heroku-boom master
# Buildpack: https://github.com/mars/create-react-app-buildpack.git
git subtree push --prefix poke heroku-poke master
