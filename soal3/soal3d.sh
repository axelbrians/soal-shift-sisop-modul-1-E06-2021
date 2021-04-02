#!/bin/bash

file=$(ls | grep -E "Kelinci_|Kucing_|-|Foto.log|Koleksi_")
keyPassword=$(date +"%m%d%Y")
zip -r -P "$keyPassword" Koleksi.zip $file
rm -r $file