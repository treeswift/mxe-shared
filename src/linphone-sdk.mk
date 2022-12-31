# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := linphone-sdk
$(PKG)_WEBSITE  := https://github.com/BelledonneCommunications/$(PKG)
$(PKG)_DESCR    := An open-source Qt-based SIP SDK.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.1.62
$(PKG)_CHECKSUM := a9fae18ba1947b3932ab59f0d756a41982ce2df61438ea4fd2690e50bae21398
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := $($(PKG)_WEBSITE)/archive/refs/tags/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc qtbase qtdeclarative qtquickcontrols

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
