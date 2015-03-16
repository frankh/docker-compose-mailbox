#!/bin/bash
# Have to copy cert to non-volume mounted folder or it causes permissions errors
cp /etc/certs/dkim.private /etc/ssl/certs/dkim.private