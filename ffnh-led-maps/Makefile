include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-led-maps
PKG_VERSION:=1
PKG_RELEASE:=1

include $(GLUONDIR)/package/gluon.mk

define Package/$(PKG_NAME)
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=FFNH Drop-in LED Mapping files (vendor/model allow-lists)
  DEPENDS:=+gluon-config-mode-core
endef

define Package/$(PKG_NAME)/description
 Installs drop-in LED mapping definitions for the Config Mode Wizard.
 Files placed in files/lib/gluon/config-mode/led-map.d/*.lua
 are copied to the target system.
endef

define Build/Compile
  # nothing to compile
endef

define Package/$(PKG_NAME)/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
