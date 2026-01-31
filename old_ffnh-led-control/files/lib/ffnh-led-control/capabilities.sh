#!/bin/sh

# Output JSON to stdout.
# Used by detect-json.sh and config-mode UI.

. /usr/share/libubox/jshn.sh

board_name() { cat /tmp/sysinfo/board_name 2>/dev/null; }

model_id() {
	[ -f /etc/board.json ] || return 1
	json_init
	json_load_file /etc/board.json
	json_select model
	json_get_var id id
	echo "$id"
}

# Find LED sysfs objects matching provided patterns
find_led() {
	for p in "$@"; do
		for l in /sys/class/leds/*; do
			[ -d "$l" ] || continue
			n="$(basename "$l")"
			echo "$n" | grep -qi "$p" && echo "$n" && return 0
		done
	done
	return 1
}

detect_device_key() {
	bn="$(board_name)"
	mid="$(model_id)"

	all="$bn $mid"

	case "$all" in
		*ubnt*|*Ubiquiti*|*unifi*|*uap-*|*u6-*|*nano*|*loco*|*rocket*|*bullet*)
			echo "ubnt"
			;;

		*mikrotik*|*routerboard*|*RouterBOARD*|*rb*|*hap*|*wAP*|*wap*|*sxt*|*ltap*)
			echo "mikrotik"
			;;

		*tplink*|*tp-link*|*TP-Link*|*archer*|*cpe*|*eap*|*tl-*)
			echo "tplink"
			;;

		*zyxel*|*ZyXEL*|*nwa*|*nbg*|*wap*|*wre*)
			echo "zyxel"
			;;

		*)
			echo "generic"
			;;
	esac
}

device_capabilities_json() {
	key="$(detect_device_key)"

	json_init
	json_add_string board_name "$(board_name)"
	json_add_string model_id "$(model_id)"
	json_add_string device_key "$key"
	json_add_string vendor "$key"
	json_add_string handler "$key"

	json_add_boolean supported 0
	json_add_boolean supports_brightness 0
	json_add_boolean supports_color 0

	json_add_array colors
	json_close_array

	json_add_array leds
	json_close_array

	pick_status_led() {
		for p in "status" "system" "user" "power" "blue" "white"; do
			for l in /sys/class/leds/*; do
				[ -d "$l" ] || continue
				n="$(basename "$l")"
				echo "$n" | grep -qi "$p" && echo "$n" && return 0
			done
		done
		ls -1 /sys/class/leds 2>/dev/null | head -n1
	}

	[ -d /sys/class/leds ] || { json_dump; return 0; }

	led="$(pick_status_led)"
	[ -n "$led" ] || { json_dump; return 0; }

	json_add_boolean supported 1

	mb="$(cat "/sys/class/leds/$led/max_brightness" 2>/dev/null)"
	if [ -n "$mb" ] && [ "$mb" -gt 1 ] 2>/dev/null; then
		json_add_boolean supports_brightness 1
	else
		json_add_boolean supports_brightness 0
	fi

	r=""
	g=""
	b=""

	case "$key" in
		ubnt|tplink)
			r="$(find_led "red")"
			g="$(find_led "green")"
			b="$(find_led "blue")"

			if [ -n "$r$g$b" ]; then
				json_add_boolean supports_color 1
				json_add_array colors
				[ -n "$r" ] && json_add_string "" "red"
				[ -n "$g" ] && json_add_string "" "green"
				[ -n "$b" ] && json_add_string "" "blue"
				json_add_string "" "white"
				json_close_array
			else
				json_add_boolean supports_color 0
				json_add_array colors
				json_close_array
			fi
			;;
		*)
			json_add_boolean supports_color 0
			json_add_array colors
			json_close_array
			;;
	esac

	json_add_array leds
	if [ -n "$r$g$b" ]; then
		[ -n "$r" ] && json_add_string "" "$r"
		[ -n "$g" ] && json_add_string "" "$g"
		[ -n "$b" ] && json_add_string "" "$b"
	else
		json_add_string "" "$led"
	fi
	json_close_array

	json_dump
}
