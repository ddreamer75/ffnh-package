
# ffnh-config-mode-led

Freifunk Nordhessen e.V. branded Gluon Config Mode Wizard page to configure **LED color** (for multi-color LEDs) and **brightness (0–100%)**.

- Auto-detects LEDs from `/sys/class/leds/`
- Supports per-device color whitelists via drop-in maps in `/lib/gluon/config-mode/led-map.d/*.lua`
- Persists settings through the backend service **ffnh-led-config**

## Dependencies
- `gluon-config-mode-core`
- `gluon-web-model`
- `ffnh-led-config` (applies triggers/brightness at boot)

## Install (site)
In `image-customization.lua`, add: ffnh-config-mode-led, ffnh-led-config
