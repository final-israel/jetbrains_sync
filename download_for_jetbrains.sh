#!/bin/bash

# Ensure jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install it first."
    exit
fi

# Function to extract version numbers from the JSON file using jq
extract_versions() {
    local product_filter=$1
    jq -r ".versions.${product_filter}.version_numbers[]" config.json
}

# Base directory for downloads
download_dir="/mnt/d/jetbrains-clients-downloader/downloads/"

# Function to run the download commands for a given product filter
run_downloads() {
    local product_filter=$1
    
    echo "Starting download for product filter: $product_filter"
    
    # Load version numbers for this product filter
    version_number_list=$(extract_versions "$product_filter")
    
    echo "Version numbers to be processed: $version_number_list"
    
    for version_number in $version_number_list
    do
        echo "Processing version number: $version_number for product filter: $product_filter"
        
        # First command with --download-backends
        echo "Running command: ./jetbrains-clients-downloader --products-filter \"$product_filter\" --include-eap-builds --platforms-filter linux-x64 --versions-filter \"$version_number\" --download-backends \"$download_dir\""
        ./jetbrains-clients-downloader --products-filter "$product_filter" --include-eap-builds --platforms-filter linux-x64 --versions-filter "$version_number" --download-backends "$download_dir"
        
        if [ $? -ne 0 ]; then
            echo "Error: The first command failed for version number: $version_number with product filter: $product_filter" >&2
            continue
        fi

        echo "First command completed for version number: $version_number"
        
        # Second command without --download-backends, placing directory at the end
        echo "Running command: ./jetbrains-clients-downloader --products-filter \"$product_filter\" --include-eap-builds --platforms-filter linux-x64 --versions-filter \"$version_number\" \"$download_dir\""
        ./jetbrains-clients-downloader --products-filter "$product_filter" --include-eap-builds --platforms-filter linux-x64 --versions-filter "$version_number" "$download_dir"
        
        if [ $? -ne 0 ]; then
            echo "Error: The second command failed for version number: $version_number with product filter: $product_filter" >&2
            continue
        fi

        echo "Second command completed for version number: $version_number"
    done
    
    echo "Download completed for product filter: $product_filter"
}

# Run download blocks for each product filter

# Download block for PY
run_downloads "PY"

# Download block for CL
run_downloads "CL"

# Download block for RM
run_downloads "RM"

# Download block for RR
run_downloads "RR"

echo "All downloads completed."

