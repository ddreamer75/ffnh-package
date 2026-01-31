#!/bin/sh

ledcontrol_apply() {
	state="$1"
	brightness="$2"
	color="$3"

	for led in $(ls -1 /sys/class/leds 2>/dev/null); do
		/lib/ffnh-led-control/apply.sh apply_led_sysfs "$led" "$state" "$brightness" 2>/dev/null
	done
}
