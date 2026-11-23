# dnscrypt-proxy-tak
[![dnscrypt-proxy-tak](https://snapcraft.io/dnscrypt-proxy-tak/badge.svg)](https://snapcraft.io/dnscrypt-proxy-tak)
![snap arch](https://badgen.net/snapcraft/architecture/dnscrypt-proxy-tak)
![snap size](https://badgen.net/snapcraft/size/dnscrypt-proxy-tak/amd64/stable)

## Snap Description
UnOfficial release of DNSCrypt-Proxy with auto-update blocklists\
https://snapcraft.io/dnscrypt-proxy-tak

## DNSCrypt-Proxy Description
<img src="/icon.svg" width="100">
A flexible DNS proxy, with support for modern encrypted DNS protocols\
such as DNSCrypt v2 including Post-Quantum DNSCrypt (DNSCrypt 2026), DNS-over-HTTPS, Anonymized DNSCrypt and ODoH (Oblivious DoH).\
It includes auto-update blocklists.

See https://github.com/DNSCrypt/dnscrypt-proxy for more details.

## Information
The web interface is accessible by default at http://localhost:4533

DNSCrypt-Proxy Release\
Configure DNSCrypt-proxy through '$SNAP_DATA/dnscrypt-proxy.toml' config file\
Configure auto-update blocklists through config files in '$SNAP_DATA/utils/generate-domains-blocklist/' folder\
Auto-update blocklists Service runs twice a day and generates '$SNAP_DATA/config/generated-blocked-names.txt'\
Block list is not activated by default. (Check 'dnscrypt-proxy.toml' toml-integrated doc and official doc)\
You need to manually change your system to use this dnscrypt-proxy (see doc).\
Service is restarted on any condition.

## FAQ
See common doc about [FAQ](https://github.com/TehAppKiller/Snapcraft-common-doc/tree/main#FAQ).

### How to access Configuration files
You can access the snap data in 2 ways:

#### - Directly
With default snapd installation:
```
/var/snap/dnscrypt-proxy-tak/current/config/
```

#### - Via shell
In shell mode you can edit the file with Vim:
```
sudo snap run --shell dnscrypt-proxy-tak.dnscrypt-proxy
vi $SNAP_DATA/config/{config_file}
```
One help sheet of Vim commands available [here](https://devhints.io/vim).

### How to check your configuration

Check config file:
```
snap run dnscrypt-proxy-tak.dnscrypt-proxy-call -check
```

Check resolution:
```
snap run dnscrypt-proxy-tak.dnscrypt-proxy-call -resolve example.com
```

### How to use this dnscrypt-proxy

Check you distribution documentation for more help.

Change the system DNS:
```
sudo nano /etc/systemd/resolved.conf
```

Uncomment and Specify the dnscrypt-proxy server address:
```
DNS=127.0.0.1
```

At startup (while the snap is not loaded) or if DNScrypt-proxy fails, you may need a fallback DNS to access internet.\
Uncomment and Specify a fallback DNS (e.g. with CloudFlare):
```
FallbackDNS=1.1.1.3
```

Save the file.

Restart the system DNS to apply the changes:
```
sudo systemctl restart systemd-resolved
```

Check your DNS:
```
resolvectl status
```
It should return your DNS and Fallback (if specified) configuration in 'Global'

```
nslookup example.com
```
It should begin with your configuration:\
Server:         127.0.0.1\
Address:        127.0.0.1#53\
and be able to resolve it without error.

### Commands

#### Check logs
```
sudo snap logs dnscrypt-proxy-tak.dnscrypt-proxy
```

#### Force blocklist generation
```
sudo snap run dnscrypt-proxy-tak..update-blocklists
```

#### Send custom commands
```
snap run dnscrypt-proxy-tak.dnscrypt-proxy-call {command}

e.g.:
snap run dnscrypt-proxy-tak.dnscrypt-proxy-call -resolve example.com
```

### Information:
Configuration files are automatically created, if not found, in "$SNAP_DATA/config/" ; copied from original source configuration files.\
Configuration files are never updated (for now) ; if changes are required with new software release, it is your full responsibility to update them (for now).

## Building
See common doc about [building a snap](https://github.com/TehAppKiller/Snapcraft-common-doc/tree/main#Building).

## Versionning
See common doc about [versionning](https://github.com/TehAppKiller/Snapcraft-common-doc/tree/main#Versionning).