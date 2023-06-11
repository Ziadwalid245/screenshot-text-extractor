#!/bin/bash 
screenshot_directory="/path/to/screenshots"

inotifywait -m -e create --format "%w%f" "$screenshot_directory" | while read -r filepath; do
    response=$(curl -H "apikey:yourAPIkey" --form "file=@$filepath;type=image/png" --form "language=chs" --form "isOverlayRequired=true" https://api.ocr.space/Parse/Image)
    #jq is to read the JSON output
    # -r is to remove the curly braces , colons etc from the output

    parsed_text=$(echo "$response" | jq -r  '.ParsedResults[0].ParsedText')

    echo $parsed_text
done




