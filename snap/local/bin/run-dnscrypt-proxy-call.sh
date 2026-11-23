#!/bin/bash -e

cd $SNAP_DATA/config
$SNAP/usr/bin/dnscrypt-proxy $@
