#!/bin/sh

get_targets() {
	jsonfilter -i /tmp/ffnh-led-control.json -e '@.leds[*]' 2>/dev/null
}

ledcontrol_apply() {
	state="$1"
	brightness="$2"
	color="$3"

	targets="$(get_targets)"
	[ -n "$targets" ] || return 0

	for led in $targets; do
		/lib/ffnh-led-control/apply.sh apply_led_sysfs "$led" "$state" "-1"
	done
}
