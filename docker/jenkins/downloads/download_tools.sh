#!/usr/bin/env bash

download_if_not_present(){

    file=$1
    url=$2

    echo "Provided $file and $url"
    if test -f "$file"; then
        echo "$file exist, OK"
    else
        echo "$file not present. Downloading from $url"
        curl -O -L $url
        status=$?
        if [ $status -ne 0 ]; then
            echo "Downloading of dependency failed: $file. Please update download URL in jenkins-up.sh script"
            exit 1
        fi
    fi
}

jdk_file=$1
jdk_url=$2
maven_file=$3
maven_url=$4
remove_binaries=$5

cd downloads || : #in case we run from jenkins-up script
if [ -z "$remove_binaries" ];then
    echo "Exisiting binaries will be used if present "
else
    echo "Removing existing binaries"
    rm $jdk_file > /dev/null 2>&1
    rm $maven_file > /dev/null 2>&1
fi

download_if_not_present $maven_file $maven_url
download_if_not_present $jdk_file $jdk_url
ls -alh

