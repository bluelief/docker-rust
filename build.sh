#!/bin/bash

USER=$(id -u)
GROUP=$(id -g)

docker build \
  --build-arg USER=$USER \
  --build-arg GROUP=$GROUP \
  --tag rust:latest \
  .
