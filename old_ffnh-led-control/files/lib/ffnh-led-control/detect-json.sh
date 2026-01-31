#!/bin/sh
OUT=/tmp/ffnh-led-control.json

. /lib/ffnh-led-control/capabilities.sh

device_capabilities_json > "$OUT"
exit 0
