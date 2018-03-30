#!/bin/bash

export PORT=5680

cd ~/www/othello
./bin/othello stop || true
./bin/othello start

