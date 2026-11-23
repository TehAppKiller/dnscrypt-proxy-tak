#!/bin/bash -e

# Run blocklist generation once if does not exist (because blocklist daemon timer prevent to launch it once at launch)
if [ ! -f $SNAP_DATA/config/generated-blocked-names.txt ]; then
    echo "! Blocklist does not exist !"
	echo "Run blocklist generator once..."
	sh $SNAP/bin/run-update-blocklists.sh
	echo "First blocklist generated."
fi

# Check configuration file
if [ ! -f $SNAP_DATA/config/dnscrypt-proxy.toml ]; then
    echo "! Configuration file does not exist !"
	echo "Making configuration directory..."
	mkdir -p $SNAP_DATA/config
	echo "Create original configuration file..."
	cp $SNAP/etc/dnscrypt-proxy/example-dnscrypt-proxy.toml $SNAP_DATA/config/dnscrypt-proxy.toml
	echo "Configuration file initialized."
	
	echo "Copying examples..."
	cp -f $SNAP/etc/dnscrypt-proxy/*.txt $SNAP_DATA/config/
	echo "Examples copied."
fi

# Check configuration
echo "Checking config..."
$SNAP/usr/bin/dnscrypt-proxy -check -config $SNAP_DATA/config/dnscrypt-proxy.toml

# Launch app
echo "Launching app..."
$SNAP/usr/bin/dnscrypt-proxy -config $SNAP_DATA/config/dnscrypt-proxy.toml
