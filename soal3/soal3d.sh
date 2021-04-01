#!/bin/bash

keyPassword=$(date +"%m%d%Y")
zip -r -P "$keyPassword" Koleksi.zip *-*
rm -r *-*