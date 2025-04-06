#!/usr/bin/env bash

echo "Starting jupyter lab"

echo $PDIR
jupyter lab &

disown

jupyter lab list
