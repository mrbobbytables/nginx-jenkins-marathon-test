#!/bin/bash

echo "hostname: $(hostname)" > /usr/share/nginx/html/index.html
echo "build: $(cat ./build)" >> /usr/share/nginx/html/index.html

exec nginx -g 'daemon off;'
