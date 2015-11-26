#!/bin/bash
mkdir -p zip;

COM="$(git rev-parse --short HEAD)"
NAME="coinsecrets"
zip -r "zip/"$NAME"_"$COM".zip" views
echo "production folder is zip/"$NAME"_"$COM".zip"