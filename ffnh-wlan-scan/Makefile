# SPDX-FileCopyrightText: 2025, Michael Hertel
# SPDX-License-Identifier: BSD-2-Clause
include $(TOPDIR)/rules.mk

PKG_NAME:=ffnh-wlan-scan
PKG_VERSION:=1
PKG_LICENSE:=BSD-2-Clause

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Simple wireless scan tool
  DEPENDS:=+gluon-core
endef

define Package/$(PKG_NAME)/description
	Allows scanning the wireless environment.
endef

$(eval $(call BuildPackageGluon,$(PKG_NAME)))
