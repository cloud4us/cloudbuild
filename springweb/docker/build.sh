#!/bin/bash

# script below assumes you have docker installed
docker  build .
docker tag springweb cloud4usspringweb/base:latest