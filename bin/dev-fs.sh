#!/bin/bash

# where to store the sparse-image
DEV_FS=~/dev-fs.dmg.sparseimage
MOUNT_POINT=/Users/brian/dev

create() {
    hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size 100g -volname dev ${DEV_FS}
}

detach() {
    m=$(hdiutil info | grep -v ":" | grep ${MOUNT_POINT} | cut -f1)
    if [ ! -z "$m" ]; then
        hdiutil detach $m
    fi
}

attach() {
    hdiutil attach -mountpoint ${MOUNT_POINT} ${DEV_FS}
}

compact() {
    detach
    hdiutil compact ${DEV_FS} -batteryallowed
    attach
}

case "$1" in
    create) create;;
    attach) attach;;
    detach) detach;;
    compact) compact;;
    *) ;;
esac