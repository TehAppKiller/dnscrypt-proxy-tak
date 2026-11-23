#!/bin/bash -e

# Check configuration file
if [ ! -f $SNAP_DATA/config/utils/generate-domains-blocklist/domains-blocklist.conf ]; then
    echo "! Configuration file does not exist !"
	echo "Making configuration directory..."
	mkdir -p $SNAP_DATA/config/utils/generate-domains-blocklist/
	echo "Copying original configuration files..."
	cp -f $SNAP/etc/dnscrypt-proxy/utils/generate-domains-blocklist/* $SNAP_DATA/config/utils/generate-domains-blocklist/
	echo "Configuration file initialized."
fi

# Launch app
echo "Generate blocklist..."
cd $SNAP_DATA/config/utils/generate-domains-blocklist/ # required to be in config files directory for 'file:' tag to be able to load local files
python3 $SNAP/usr/bin/generate-domains-blocklist.py --config "$SNAP_DATA/config/utils/generate-domains-blocklist/domains-blocklist.conf" --allowlist "$SNAP_DATA/config/utils/generate-domains-blocklist/domains-allowlist.txt" --time-restricted "$SNAP_DATA/config/utils/generate-domains-blocklist/domains-time-restricted.txt" --output-file "$SNAP_DATA/config/generated-blocked-names.txt"
echo "Blocklist generated."