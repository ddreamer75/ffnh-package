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

	supports_color="$(jsonfilter -i /tmp/ffnh-led-control.json -e '@.supports_color' 2>/dev/null)"
	if [ "$supports_color" = "true" ] && [ -n "$color" ]; then
		for led in $targets; do
			case "$led" in
				*"$color"*)
					/lib/ffnh-led-control/apply.sh apply_led_sysfs "$led" "$state" "$brightness"
					;;
				*)
					/lib/ffnh-led-control/apply.sh apply_led_sysfs "$led" "0" "-1"
					;;
			esac
		done
		return 0
	fi

	for led in $targets; do
		/lib/ffnh-led-control/apply.sh apply_led_sysfs "$led" "$state" "$brightness"
	done
}
