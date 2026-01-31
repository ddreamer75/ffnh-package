# ffnh-led-control

Backend package for Freifunk Nordhessen LED control.

## Features

- Vendor detection via `/tmp/sysinfo/board_name` and `/etc/board.json`
- Generates JSON capabilities at `/tmp/ffnh-led-control.json`
- Applies LED settings (on/off, optional brightness, optional color if supported)
- Vendor handlers for Ubiquiti/TP-Link/Mikrotik/Zyxel with fallback generic handler

## UCI config

File: `/etc/config/ffnh_led_control`

Section: `ffnh_led_control.main`

Options:
- `enabled` (0/1)
- `leds_on` (0/1)
- `brightness` (-1 or 0..100)
- `color` (string, optional: red/green/blue/white)

## Maintainer

Freifunk Nordhessen e.V.  
m.hertel@freifunk-nordhessen.de
