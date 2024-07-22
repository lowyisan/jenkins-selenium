#!/usr/bin/env sh

set -x
docker run -d -p 8082:80 --name my-apache-php-app -v /Users/yisanlow/Desktop/Y2T3/2216\ Secure\ Software\ Development/labs/jenkins-selenium/src:/var/www/html php:7.2-apache
sleep 1
set +x

echo 'Now...'
echo 'Visit http://localhost:8081 to see your PHP application in action.'
