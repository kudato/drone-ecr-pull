#!/bin/bash

check_plugin_param() {
    local var
    var="${1}"
    if [ -n "${!var}" ]
    then
        export "$2"="${!var}"
    fi
}

check_plugin_vars() {
    OLDIFS=$IFS; IFS=','
    for e in \
        PLUGIN_ACCESS_KEY,AWS_ACCESS_KEY_ID \
        PLUGIN_SECRET_KEY,AWS_SECRET_ACCESS_KEY \
        PLUGIN_REGION,AWS_DEFAULT_REGION
    do
        set -- $e
        check_plugin_param "$1" "$2"
    done
    IFS=$OLDIFS
}

pull_counter() {
    export PULL_IMAGES="$1 ${PULL_IMAGES}"
}

if [ ! -S "/var/run/docker.sock" ]; then
    echo "Docker is not running"
    exit 1
else
    check_plugin_vars
    if [ -z "${AWS_DEFAULT_REGION}" ]; then
        export AWS_DEFAULT_REGION=us-east-1
    fi
    $(aws ecr get-login --no-include-email --region "${AWS_DEFAULT_REGION}")
fi

OLDIFS=$IFS
while IFS=',' read -ra IMAGES; do
    for i in "${IMAGES[@]}"; do
        docker pull $i &
        pull_counter $!
    done
done <<< "$PLUGIN_IMAGES"
IFS=$OLDIFS

for i in ${PULL_IMAGES}
do
    wait "$i"
done

exit 0