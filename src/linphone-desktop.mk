# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := linphone-desktop
$(PKG)_WEBSITE  := https://linphone.org
$(PKG)_DESCR    := An open-source Qt-based SIP softphone.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.4.10
$(PKG)_CHECKSUM := acd028d135d9ca86bda72f1683275daf4f73cb2d05234f9cf494065e522586db
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/BelledonneCommunications/$(PKG)/archive/refs/tags/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc qtbase # qtdeclarative qtquickcontrols

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
