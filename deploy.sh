#!/bin/bash

set -e
set -a

if [ "$FORCE" == 'on' ]; then
  git push heroku-boom $(git subtree split --prefix boom master):master --force
  git push heroku-poke $(git subtree split --prefix poke master):master --force
else
  git subtree push --prefix boom heroku-boom master
  # Buildpack: https://github.com/mars/create-react-app-buildpack.git
  git subtree push --prefix poke heroku-poke master
fi
