#! /bin/zsh

# grep -r 'CURRENT_PROJECT_VERSION = ' ./ios/Runner.xcodeproj | xargs echo

# BuildNumber=25
# NewBuildNumber=$BuildNumber+1

# grep -rl 'project.pbxproj' ./ios | xargs sed -i 's/$BuildNumber/$NewBuildNumber/g'

# ~ https://stackoverflow.com/a/38116261

zsh set_production_config_ids_appstore.sh

cd ./ios

# Commenting out for now as done automatically in iosbuild now ~ https://stackoverflow.com/questions/9258344/better-way-of-incrementing-build-number
# We are currently using: ~ https://stackoverflow.com/a/35617190 appple recommendation, but plenty of other options there.
# echo "Current:"
# xcrun agvtool what-version

# * log the current build version

echo "Current version of builds is (remember increments on every build, not just on publish...):"

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



echo "see https://www.notion.so/gember/xcode-Better-way-of-incrementing-build-number-Stack-Overflow-3bbd3f4a1f9948c287360aa5523685cc for smarter builds"
echo "# xcrun agvtool next-version -all"

cd ..

fvm flutter build ipa --dart-define ENV=production

cd ./ios

echo "Not manually incrementing build for now as xcode uses avgtool to autoincrement of EVERY build call anyways"
# xcrun agvtool next-version -all


echo "Next build will be:"
xcrun agvtool what-version

cd ..

# ~ https://stackoverflow.com/a/43267603
set -a # automatically export all variables
source environment/.env_build
set +a

# ~ https://medium.com/ynap-tech/using-apples-itms-transporter-api-to-upload-builds-to-testflight-60dba18b07bc
# Create the .itmsp folder
ITMSP_DIR="$HOME/appstore_testflights.itmsp"
IPA_FILE="build/ios/ipa/vegi.ipa"
APPLE_ID="<Your Apple ID>"
APPSTORE_CONNECT_USERNAME="<Your username>"
APPSTORE_CONNECT_PASSWORD="<Your password>"
mkdir "$ITMSP_DIR"

# Move your .ipa file into the .itmsp folder
cp "$IPA_FILE" "$ITMSP_DIR"

# Generate the metadata.xml file
fileSize=` stat -f %z "$IPA_FILE"`
md5Checksum=`md5 "$IPA_FILE"  | cut -d "=" -f 2 | awk '{print $1}'`

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $ITMSP_DIR/metadata.xml
echo "<package xmlns=\"http://apple.com/itunes/importer\" version=\"software5.4\">" >> $ITMSP_DIR/metadata.xml
echo "    <software_assets apple_id=\"$APPLE_ID\" app_platform=\"ios\">" >> $ITMSP_DIR/metadata.xml
echo "        <asset type=\"bundle\">" >> $ITMSP_DIR/metadata.xml 
echo "        	<data_file>" >> metadata.xml
echo "                <size>$fileSize</size>" >> $ITMSP_DIR/metadata.xml 
echo "                <file_name>nap.ipa</file_name>" >> $ITMSP_DIR/metadata.xml 
echo "            	  <checksum type=\"md5\">$md5Checksum</checksum>" >> $ITMSP_DIR/metadata.xml
echo "          </data_file>" >> $ITMSP_DIR/metadata.xml 
echo "        </asset>" >> $ITMSP_DIR/metadata.xml
echo "    </software_assets>" >> $ITMSP_DIR/metadata.xml 
echo "</package>" >> $ITMSP_DIR/metadata.xml

# Upload the .itmsp folder to iTunes Connect
/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/itms/bin/iTMSTransporter -m upload -u $APPSTORE_CONNECT_USERNAME 
-p $APPSTORE_CONNECT_PASSWORD -f $ITMSP_DIR -t DAV -t Signiant -k 100000 -v eXtreme

open build/ios/ipa/

open -a Transporter


