#! /bin/sh

# ./firebase_emulator.sh
emulator_cache="./emulators_data/"
read response"Do you want to import & export existing emulator state from $emulator_cache ? (y/n): "

if [ "$response" = "y" ]; then
    # Check if the file "./docker/Dockerfile.$dockerFileExt" exists
    if [ ! -f $emulator_cache ]; then
        echo "No import cache exists yet for firebase emulator, will export data to \"$emulator_cache\""
        firebase emulators:start --export-on-exit $emulator_cache
        # exit 1
    else
        firebase emulators:start --import $emulator_cache --export-on-exit $emulator_cache
    fi
else
    firebase emulators:start
fi
# unset response


open "http://localhost:4000"