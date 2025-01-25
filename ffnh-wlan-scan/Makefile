include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-wlan-scan
PKG_VERSION:=1
PKG_RELEASE:=$(GLUON_BRANCH)

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(TOPDIR)/../package/gluon.mk


define Package/$(PKG_NAME)
  SECTION:=gluon
  CATEGORY:=Addon
  DEPENDS:=+gluon-core
  TITLE:=Simple wifi scanner
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
	$(call GluonSrcDiet,./luasrc,$(PKG_BUILD_DIR)/luadest/)
endef

define Package/$(PKG_NAME)/install
	$(CP) ./luasrc/* $(1)/
	$(CP) $(PKG_BUILD_DIR)/luadest/* $(1)/
endef

$(eval $(call BuildPackage,ffnh-wlan-scan))
