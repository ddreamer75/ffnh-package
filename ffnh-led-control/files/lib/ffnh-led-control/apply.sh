#!/bin/sh

CONFIG=ffnh_led_control

uci_get() { uci -q get "${CONFIG}.main.$1"; }

enabled="$(uci_get enabled)"
leds_on="$(uci_get leds_on)"
brightness="$(uci_get brightness)"
color="$(uci_get color)"

[ "$enabled" = "1" ] || exit 0

/lib/ffnh-led-control/detect-json.sh >/dev/null 2>/dev/null

apply_led_sysfs() {
	led="$1"
	state="$2"
	brightness_pct="$3"

	ledpath="/sys/class/leds/$led"
	[ -d "$ledpath" ] || return 1

	[ -w "$ledpath/trigger" ] && echo none > "$ledpath/trigger"

	if [ "$state" = "0" ]; then
		echo 0 > "$ledpath/brightness" 2>/dev/null
		return 0
	fi

	if [ "$brightness_pct" -ge 0 ] 2>/dev/null && [ -r "$ledpath/max_brightness" ]; then
		max="$(cat "$ledpath/max_brightness" 2>/dev/null)"
		[ -n "$max" ] || max=1
		val=$((brightness_pct * max / 100))
		[ "$val" -lt 1 ] && val=1
		echo "$val" > "$ledpath/brightness" 2>/dev/null
	else
		echo 1 > "$ledpath/brightness" 2>/dev/null
	fi
	return 0
}

handler="$(jsonfilter -i /tmp/ffnh-led-control.json -e '@.handler' 2>/dev/null)"
[ -n "$handler" ] || handler="generic"

handler_path="/lib/ffnh-led-control/handlers/${handler}.sh"
[ -x "$handler_path" ] || handler_path="/lib/ffnh-led-control/handlers/generic.sh"

. "$handler_path"

ledcontrol_apply "$leds_on" "$brightness" "$color"
