#!/bin/bash

pushd DRISEE
git pull origin master
cp *.py ../scripts/.
cp *.pl ../scripts/.
popd
