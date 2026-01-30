# ffnh-led-config

Persistent LED application service for Gluon/OpenWrt.

## What it does
- Sets **trigger = none**
- Applies **brightness 0–100%**, scaled to `/sys/class/leds/<led>/max_brightness`
- Optionally turns **off** additional LEDs listed as `off_leds` (e.g. other colors of a multicolor LED)

## UCI
`/etc/config/ffnh-led-config`:

```sh
config led 'main'
        option sysfs 'ubnt:blue:dome'  # sysfs LED name
        option brightness '30'          # 0..100 percent
        list off_leds 'ubnt:white:dome' # optional additional LEDs to switch off
