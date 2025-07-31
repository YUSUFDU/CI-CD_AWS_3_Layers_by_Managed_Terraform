#!/bin/bash
set -e

echo "Packaging geo-redirect Lambda function..."
cd ../lambda/geo-redirect-src
zip -r ../geo-redirect.zip .
cd -

echo "Packaging whatsapp-alert Lambda function..."
cd ../lambda/whatsapp-alert-src
zip -r ../whatsapp-alert.zip .
cd -

echo "Packaging completed!"
