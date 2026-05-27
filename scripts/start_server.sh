#!/bin/bash
cd /home/ubuntu/sample-microservice
npm install
nohup node app.js > app.log 2>&1 &
