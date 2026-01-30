include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-support-enable
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DEPENDS := gluon-config-mode-core gluon-web-model

include ../gluon.mk

define Package/ffnh-support-enable
  TITLE:=Support-Funktion für Freifunk Nordhessen
  DEPENDS:=+gluon-config-mode-core +gluon-web-model
endef

$(eval $(call BuildPackage,ffnh-support-enable))
