include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-config-mode-led
PKG_VERSION:=1
PKG_RELEASE:=1

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=FFNH LED color/brightness Config Mode Wizard
  DEPENDS:=+gluon-config-mode-core +gluon-web-model +ffnh-led-config
endef

define Package/$(PKG_NAME)/description
 FFNH-branded Config Mode Wizard page to select LED color (if available) and brightness.
 Writes UCI for gluon-led-config which applies settings persistently at boot.
endef

define Build/Compile
  # nothing to compile
endef

define Package/$(PKG_NAME)/install
    $(CP) ./luasrc/* $(1)/usr/lib/lua/
    # Falls du ggf. i18n-Dateien hinzufügen willst, hier ergänzen:
    # $(CP) ./i18n/* $(1)/lib/gluon/config-mode/i18n/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
