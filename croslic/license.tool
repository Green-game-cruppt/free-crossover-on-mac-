#!/bin/sh -e

if [ ! -d /Applications/CrossOver.app ]; then
  echo "Please install CrossOver!"
  exit 1
fi

# Fix license
cd ~/Library/Preferences/
openssl genrsa -out key.pem 2048
openssl rsa -in key.pem -outform PEM -pubout -out public.pem
sudo mv public.pem /Applications/CrossOver.app/Contents/SharedSupport/CrossOver/share/crossover/data/tie.pub
sudo rm -f com.codeweavers.CrossOver.license com.codeweavers.CrossOver.sha256
printf "[crossmac]\ncustomer=user\nemail=user@apple.com\nexpires=2030/01/01\n[license]\nid=a4xdUZD2bWB00tQI" > com.codeweavers.CrossOver.license
openssl dgst -sha256 -sign key.pem -out com.codeweavers.CrossOver.sha256 com.codeweavers.CrossOver.license
rm key.pem

# Fix updating DB
SELF=$(dirname "$0")
sudo cp "${SELF}/libcxsetup-v3.py" /Applications/CrossOver.app/Contents/Resources

# Resign to avoid corruption
sudo codesign -fs - /Applications/CrossOver.app
