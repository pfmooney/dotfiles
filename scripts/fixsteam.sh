#!/bin/sh -e
# Copyright (C) 2013-2014 Michael Gilbert <mgilbert@debian.org>
# License: MIT

# Fedora path
config=$HOME/.local/share/Steam
# Debian path
# config=$HOME/.steam

ubuntu32=$config/ubuntu12_32

# remove steam-runtime's libstdc++, which is incompatible with newer mesa drivers
# (https://bugs.freedesktop.org/78242)
rm -f $ubuntu32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6*
rm -f $ubuntu32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.6*
