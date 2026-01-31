
include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-led-control
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Freifunk Nordhessen e.V. <m.hertel@freifunk-nordhessen.de>
PKG_LICENSE:=GPL-2.0-or-later

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  TITLE:=FFNH LED backend (status LED control)
  DEPENDS:=
endef

define Package/$(PKG_NAME)/description
Config + procd backend to control status LEDs (color, brightness %, permanent on/off, timer trigger) with hardware detection and quirks.
endef

# Install all runtime files
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/ffnh_ledcontrol $(1)/etc/config/ffnh_ledcontrol
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/ffnh-led-control $(1)/etc/init.d/ffnh-led-control
	$(INSTALL_DIR) $(1)/usr/libexec/ffnh-led-control
	$(INSTALL_BIN) ./files/usr/libexec/ffnh-led-control/apply.sh $(1)/usr/libexec/ffnh-led-control/
	$(INSTALL_BIN) ./files/usr/libexec/ffnh-led-control/detect.sh $(1)/usr/libexec/ffnh-led-control/
	$(INSTALL_BIN) ./files/usr/libexec/ffnh-led-control/quirks.sh $(1)/usr/libexec/ffnh-led-control/
	$(INSTALL_BIN) ./files/usr/libexec/ffnh-led-control/selfcheck.sh $(1)/usr/libexec/ffnh-led-control/
endef

$(eval $(call BuildPackageGluon,$(PKG_NAME)))
