#!/bin/bash
# To Do: Create a powershell version of this with:
# wget --user-agent="<USER AGENT GOES HERE>" --header="<API KEY GOES HERE>" -O downloaded_page.html "https://example.com/osint/osint.html"
# UPDATE: refined this a bit to make sure its extracting the images I want. 

read -p "Enter the URL to extract images from: " url

# Extract the directory path from the URL
directory=$(dirname "$url")

wget --user-agent="<USER AGENT GOES HERE>" --header="<API KEY GOES HERE>" -O downloaded_page.html "$url"

grep -oP '(?<=<img src=")[^"]*' downloaded_page.html | while read -r img_url; do
    if [[ ! "$img_url" =~ ^http ]]; then
        # Ensure the directory is joined correctly with the image URL
        img_url="$directory/$img_url"
        
        # Always use https for the scheme
        img_url=$(echo "$img_url" | sed 's|^http://|https://|')
    fi

    wget "$img_url"
done

echo "Image download completed."
