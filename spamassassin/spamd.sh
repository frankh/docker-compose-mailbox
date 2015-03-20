#!/bin/bash
exec spamd --create-prefs --max-children 2 --helper-home-dir --listen-ip=0.0.0.0 --allowed-ips=0.0.0.0/0