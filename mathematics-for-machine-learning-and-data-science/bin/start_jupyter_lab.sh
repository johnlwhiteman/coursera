#!/usr/bin/env bash

echo "Starting jupyter lab"

jupyter lab &

disown

jupyter lab list
