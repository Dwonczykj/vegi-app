#!/bin/zsh

cd ./ios

# Prompt for stdin input
echo -n "Update major (Y) or minor (n) version? "

# Read the input from stdin
read -r input

# Convert the input to lowercase for case-insensitive comparison
input=${input:l}
update_is_major="y"

# Check the input and echo the appropriate message
if [[ $input == "y" ]]; then
    echo "Updating major version"
    update_is_major="y"
else
    echo "Updating minor version"
    update_is_major="n"
fi

# Input string

# input_string='Found CFBundleShortVersionString of "1.5" in "Runner.xcodeproj/../Runner/Info.plist"'
input_string=$(xcrun agvtool what-marketing-version)

# Pattern to match
pattern='Found CFBundleShortVersionString of "([0-9]+)\.([0-9]+)"'

# Enable extended globbing for regex matching
setopt extended_glob

# Search for the pattern in the input string using regular expressions
if [[ $input_string =~ $pattern ]]; then
    major_release_version="${match[1]}"
    major_product_version="${match[2]}"
    major_version="$major_release_version.$major_product_version"
    echo "Original major version: $major_release_version.$major_product_version"
    if [[ $update_is_major == "y" ]]; then
        # Increment the major version by 1
        ((new_major_version_sub_release = major_product_version + 1))

        # Construct the new major version
        major_version="${major_release_version}.${new_major_version_sub_release}"

        echo "New major version: $major_version"
    fi
else
    echo "No major version match found."
    major_version="0.0"
fi

# Reset the match variable
unset match

# Input string for the second match
input_string=$(xcrun agvtool what-version)

# Pattern for the second match
pattern='([0-9]+)'

# Search for the second match in the input string using regular expressions
if [[ $input_string =~ $pattern ]]; then
    minor_version="${match[1]}"
    echo "Original minor version: $minor_version"
    if [[ $update_is_major != "y" ]]; then
        # Increment the minor version by 1
        ((new_minor_version = minor_version + 1))

        # Construct the new major version
        minor_version="${new_minor_version}"

        echo "New major version: $minor_version"
    fi
else
    echo "No match found."
    minor_version="0"
fi

full_version="$major_version.$minor_version"
echo "Full release version is now: $full_version"

cd ..
