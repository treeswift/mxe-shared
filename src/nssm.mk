# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nssm
$(PKG)_WEBSITE  := https://www.nssm.cc/
$(PKG)_DESCR    := NSSM - the Non-Sucking Service Manager
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.24
$(PKG)_CHECKSUM := 727d1e42275c605e0f04aba98095c38a8e1e46def453cdffce42869428aa6743
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).zip
$(PKG)_URL      := $($(PKG)_WEBSITE)/release/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD)
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
	cd $(BUILD_DIR)
endef