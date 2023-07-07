#!/bin/zsh

# from production to test

# TODO: TEST THIS SCRIPT ON A COPY OF THE REPO WITH THE .git folder deleted so that doesnt update both folders...

appIdProd="1:526129377:ios:b603d00494434cb770bfa0"
appIdTest="1:526129377:ios:7fdd83bd162d99c470bfa0"
appIdProdEncoded="app-1-526129377-ios-b603d00494434cb770bfa0"
appIdTestEncoded="app-1-526129377-ios-7fdd83bd162d99c470bfa0"

bundleIdProd="com.vegiapp.vegi"
bundleIdTest="com.vegi.vegiappTest"

# NOTE the -i'' (NO SPACE FOR THIS OPTION) sets the backup created to be the same file, i.e. no backup file created pre sed replace DANGER
# NOTE the {} placeholder inserts the argument filename piped from the find command to the sed command
# NOTE the + command lets us run the next sed command from the find results.
LIST=( -name AndroidManifest.xml -o -name \*.plist -o -name \*.pbxproj)
find -L ./ios \( "${LIST[@]}" \) -exec \
    sed -i'' -e "s|com\.vegi\.vegiappTest|com.vegiapp.vegi|ig w /dev/stdout" {} \;

find -L ./ios \( "${LIST[@]}" \) -print0 | xargs -0 \
    sed -i'' -e "s|${appIdTestEncoded}|${appIdProdEncoded}|ig w /dev/stdout"

# Certainly! Here's a Zsh shell script that recursively copies all files 
# from the relative file directory "service_files/test/ios" to the relative file directory "ios," 
# preserving the folder structure below the "ios" directory. 
# 
# Only files that need to be replaced 
# (can check for later timestamps using the traverse_directory_and_replace_newer function instead) 
# will be updated, while the contents of the destination "ios" directory will remain unchanged:

# Function to copy files while preserving the directory structure NOT_USED
copy_files() {
    local source="$1"
    local destination="$2"

    # Create the destination directory if it doesn't exist
    mkdir -p "$destination"

    # Copy files from the source directory to the destination directory
    cp -n -R "$source" "$destination"
}

# Recursive function to traverse the source directory and replace files if exist 
# or if the destination file doesn't exist, copy it
traverse_directory() {
    local source="$1"
    local destination="$2"
    echo "traverse '$source' directory..."
    for file in "$source"/*; do
        if [[ -d "$file" ]]; then
            # If the item is a directory, recursively traverse it
            local subdir="${file##*/}"
            # traverse_directory "$file" "$destination/$subdir"
            traverse_directory "$file" "$destination"
        elif [[ -f "$file" ]]; then
            # If the item is a file, check if it needs to be replaced
            local relative_path="${file#$source_dir}"  # remove $source_dir section of relative file path for $file i.e. service_files/prod/ios/Runner/**/*.png -> Runner/**/*.png
            # instead of destination = ios/Runner/Assets.xcassets/AppIcon.appiconset/ want destination = ios
            local dest_file="$destination$relative_path"
            if [[ -f "$dest_file" ]]; then
                echo "Replacing file at $dest_file [using $file]"
                cp -f "$file" "$dest_file"
            else
                # If the destination file doesn't exist, copy it
                echo "Copying file: $dest_file [from $file]"
                cp "$file" "$dest_file"
            fi
        fi
    done
}

# Recursive function to traverse the source directory and replace files if exist and If the source file is newer, replace the destination file or  If the destination file doesn't exist, copy it
traverse_directory_and_replace_newer() {
    local source="$1"
    local destination="$2"

    for file in "$source"/*; do
        if [[ -d "$file" ]]; then
            # If the item is a directory, recursively traverse it
            local subdir="${file##*/}"
            traverse_directory_and_replace_newer "$file" "$destination/$subdir"
        elif [[ -f "$file" ]]; then
            # If the item is a file, check if it needs to be replaced
            local relative_path="${file#$source_dir}"
            local dest_file="$destination$relative_path"
            if [[ -f "$dest_file" ]]; then
                # If the destination file already exists, compare timestamps
                local source_mtime=$(stat -c %Y "$file")
                local dest_mtime=$(stat -c %Y "$dest_file")
                if (( source_mtime > dest_mtime )); then
                    # If the source file is newer, replace the destination file
                    echo "Replacing file using $dest_file [to replace $file]"
                    cp -f "$file" "$dest_file"
                fi
            else
                # If the destination file doesn't exist, copy it
                echo "Copying file: $dest_file [from $file]"
                cp "$file" "$dest_file"
            fi
        fi
    done
}

# * first save existing test app service files to ./service_files/test/ios
source_dir="ios"
destination_dir="service_files/test/ios"
traverse_directory "$source_dir" "$destination_dir"

source_dir="service_files/prod/ios"
destination_dir="ios"


# Start traversing the source directory
traverse_directory "$source_dir" "$destination_dir"

