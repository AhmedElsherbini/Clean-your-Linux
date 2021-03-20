#!/bin/bash
# Removes old revisions of snaps
#remove journals

apt-get autoremove --purge
apt-get autoclean
journalctl --vacuum-time=1seconds

du -h /var/lib/snapd/snaps
rm -rf ~/.cache/thumbnails/*

set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
