include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-banner
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_LICENSE:=MIT

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  TITLE:=Creates a custom banner for SSH login
  DEPENDS:=+gluon-core +lua-jsonc
endef

$(eval $(call BuildPackageGluon,$(PKG_NAME)))
