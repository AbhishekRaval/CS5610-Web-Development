#!/bin/bash

export PORT=5678

cd ~/www/tasks1
./bin/tasks1 stop || true
./bin/tasks1 start

