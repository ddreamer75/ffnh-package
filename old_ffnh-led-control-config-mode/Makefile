include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-led-control-config-mode
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/../package/gluon.mk

define Package/ffnh-led-control-config-mode
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Freifunk Nordhessen LED Control (Config Mode)
  MAINTAINER:=Freifunk Nordhessen e.V. <m.hertel@freifunk-nordhessen.de>
  DEPENDS:=+ffnh-led-control +gluon-config-mode-core +gluon-web-model +gluon-web-admin +jsonfilter
endef

define Build/Compile
endef

define Package/ffnh-led-control-config-mode/install
	$(CP) ./luasrc $(1)/usr/lib/lua/
	$(CP) ./i18n $(1)/
endef

$(eval $(call BuildPackage,ffnh-led-control-config-mode))
