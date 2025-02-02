#!/bin/bash


read -p "Enter the URL to extract images from: " url


root_domain=$(echo "$url" | awk -F/ '{print $1"//"$3}')


wget --user-agent="NYNEX/1995 (Windows 95; x32) MacOS/7.5.1 (KHTML, like Gecko) Netscape Navigator" --header="X-Api-Key: 08061963-07162023KM" -O downloaded_page.html "$url"


grep -oP '(?<=<img src=")[^"]*' downloaded_page.html | while read -r img_url; do

    if [[ ! "$img_url" =~ ^http ]]; then
        img_url="$root_domain/$img_url"
    fi

    wget "$img_url"
done


echo "Image download completed."
