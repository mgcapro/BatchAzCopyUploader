# Upload folders from text file with full paths to blob storage
#!/bin/bash
filename="datasets.txt"
lines=$(cat $filename)
sas1="https://blablabla.blob.core.windows.net/containername/"
sas2="SAS KEY"

for line in $lines
do
    path=$(echo "$line" | cut -d'/' -f4- | rev | cut -d'/' -f2- | rev)
    dest="$sas1$path$sas2"
    echo "UPLOADING " $line "TO" $path
    azcopy copy $line $dest --follow-symlinks=true --recursive=true --overwrite=false --log-level=NONE --check-length=true
    sudo azcopy jobs clean
done