# ffnh-led-control-config-mode

Config mode UI integration for `ffnh-led-control`.

## Features

- Adds LED control page to Gluon config mode admin UI
- Reads capabilities from `/tmp/ffnh-led-control.json`
- Disables UI elements if no controllable LEDs are available
- Options:
  - LED on/off
  - Brightness (only if supported)
  - Color dropdown (only if supported)

## Maintainer

Freifunk Nordhessen e.V.  
m.hertel@freifunk-nordhessen.de
