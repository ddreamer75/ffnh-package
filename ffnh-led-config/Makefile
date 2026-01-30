include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-led-config
PKG_VERSION:=1
PKG_RELEASE:=1

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=FFNH persistent LED apply (trigger=none, brightness 0..100% via Sysfs)
  DEPENDS:=+gluon-core
endef

define Package/$(PKG_NAME)/description
 Applies LED settings at boot for Gluon/OpenWrt using /sys/class/leds.
 - Forces trigger=none
 - Scales brightness (0..100%) -> max_brightness
 - Optionally turns off alternative LEDs listed in 'off_leds'
endef

define Build/Compile
  # nothing to compile
endef

define Package/$(PKG_NAME)/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
