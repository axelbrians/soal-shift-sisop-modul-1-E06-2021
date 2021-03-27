keyPassword=$(date +"%m%d%Y")
zip -r -P "$keyPassword" Koleksi.zip *_*
rm -r *_*