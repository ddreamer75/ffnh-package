local uci = require('simple-uci').cursor()
local fs = require("nixio.fs")

local M = {}

local function jsonget(expr)
  local cmd = "jsonfilter -i /tmp/ffnh-led-control.json -e '" .. expr .. "' 2>/dev/null"
  local f = io.popen(cmd)
  if not f then return nil end
  local out = f:read("*a")
  f:close()
  if not out then return nil end
  out = out:gsub("%s+$", "")
  if out == "" then return nil end
  return out
end

local function ensure_json()
  if fs.stat("/tmp/ffnh-led-control.json") == nil then
    os.execute("/lib/ffnh-led-control/detect-json.sh >/dev/null 2>/dev/null")
  end
end

function M.section(form)
  ensure_json()

  local supported = (jsonget("@.supported") == "true")
  local supports_brightness = (jsonget("@.supports_brightness") == "true")
  local supports_color = (jsonget("@.supports_color") == "true")

  local s = form:section(uci:get_first("ffnh_led_control", "ffnh_led_control", "name") or "ffnh_led_control", "LED Control")

  local o

  o = s:option(form.Flag, "leds_on", "LEDs enabled")
  o.default = uci:get("ffnh_led_control", "main", "leds_on") or "1"
  o.disabled = not supported
  if not supported then
    o.description = "No controllable LEDs available."
  else
    o.description = "Switches the device status LEDs on or off."
  end

  o = s:option(form.Value, "brightness", "Brightness (%)")
  o.datatype = "range(0,100)"
  o.default = uci:get("ffnh_led_control", "main", "brightness") or "-1"
  o.disabled = (not supported) or (not supports_brightness)
  o.optional = true
  o.placeholder = "e.g. 50"
  if supports_brightness then
    o.description = "Optional. Supported by this device."
  else
    o.description = "Not supported by this device."
  end

  o = s:option(form.ListValue, "color", "LED color")
  o.default = uci:get("ffnh_led_control", "main", "color") or ""
  o.disabled = (not supported) or (not supports_color)
  o.optional = true
  o:value("", "Automatic / default")

  if supports_color then
    local colors_raw = jsonget("@.colors[*]")
    if colors_raw ~= nil then
      for c in colors_raw:gmatch("[^\n]+") do
        o:value(c, c:sub(1,1):upper() .. c:sub(2))
      end
    end
    o.description = "Only shown if the device provides multi-color LEDs."
  else
    o.description = "Not supported by this device."
  end

  return s
end

function M.handle(data)
  uci:section("ffnh_led_control", "ffnh_led_control", "main", {
    enabled = "1",
    leds_on = data.leds_on or "1",
    brightness = data.brightness or "-1",
    color = data.color or "",
  })
  uci:commit("ffnh_led_control")
  os.execute("/etc/init.d/ffnh-led-control reload >/dev/null 2>/dev/null")
end

return M
