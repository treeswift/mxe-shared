# MXE (M cross environment) - for ARM32 Windows development

This is an UNSTABLE modified version of MXE that comes with fixed scripts and sources that way Windows on ARM32 can have proper development for it. 

MXE (M cross environment) is a GNU Makefile that compiles a cross
compiler and cross compiles many free libraries such as SDL and
Qt. Thus, it provides a nice cross compiling environment for
various target platforms, which:

  * is designed to run on any Unix system
  * is easy to adapt and to extend
  * builds many free libraries in addition to the cross compiler
  * can also build just a subset of the packages, and automatically builds their dependencies
  * downloads all needed packages and verifies them by their checksums
  * is able to update the version numbers of all packages automatically
  * directly uses source packages, thus ensuring the whole build mechanism is transparent
  * allows inter-package and intra-package parallel builds whenever possible
  * bundles [ccache](https://ccache.samba.org) to speed up repeated builds
  * integrates well with autotools, cmake, qmake, and hand-written makefiles.
  
## Supported Toolchains

  * Runtime: Clang disguised as MinGW-w64
  * Host Triplets:
    - `armv7-w64-mingw32`
    
This version of MXE is meant for specifically WoA32 porting only, but to just add more, it's unstable, so packages will not build properly (Especially being that MinGW is NOT GCC. It is Clang.). For Aarch64 development (for NOW), head over to [the Aarch64 development repos](https://github.com/aarch64devel/mxe). For stable(-ish) ARM32 development (for NOW), head over to the [STABLE repo](https://github.com/armdevvel/mxe).

## Setting up

To use this for ARM development easily, first clone this repository to your home directory on any Linux system. [Be sure you have the dependencies installed from the site already](https://mxe.cc/#requirements). Then, download a zip of the current release of LLVM-MinGW (preferably from [here](https://github.com/armdevvel/llvm-mingw/releases)). CD to the MXE folder. Make a directory in the MXE directory called "usr". If you're new to this stuff, /usr is not related to /home/user/youruser/mxe, so don't worry about Linux confusing these. Extract LLVM-MinGW to the usr folder of MXE. Make sure you see armv7-w64-mingw32, bin, lib, and include in the MXE "usr" folder. You should see something like this.

![MXEs usr folder](images/mxeusr2.png?raw=true)

Once done, you can run a make command to build all known working WoA libraries. CD back to the root dir of MXE and run the following.

`make libpng cmake sdl2 sdl tiff jpeg ccache lame libxml++ libxml2 libxslt libyaml libzip libwebp libusb1 sdl_image sdl_mixer sdl2_mixer zlib yasm dbus pcre boost icu4c`

(or if you want to just set it up in one command and already have the Linux dependencies installed, just run this long command (lol) --

-- `cd ~ && git clone https://github.com/armdevvel/mxe-UNSTABLE --depth=1 armmxe-unstable && cd armmxe-unstable && mkdir usr && cd usr && wget https://github.com/armdevvel/llvm-mingw/releases/download/14.0/armv7-only-llvm-mingw-linux-x86_64.tar.xz && tar -xf armv7-only-llvm-mingw-linux-x86_64.tar.xz && cd .. && make libpng cmake sdl2 sdl tiff jpeg ccache lame libxml++ libxml2 libxslt libyaml libzip libwebp libusb1 sdl_image sdl_mixer sdl2_mixer zlib yasm dbus pcre boost icu4c && echo $'\n' >> ~/.bashrc && echo "export PATH=/home/$USER/armmxe-unstable/usr/bin"':$PATH' >> ~/.bashrc` )

(or, if you would rather use a script, you can use the sh script included for Ubuntu! -- 

-- `wget https://raw.githubusercontent.com/armdevvel/mxe-UNSTABLE/master/mxe-ubuntu-install.sh && sh ./mxe-ubuntu-install.sh` )

You should be good to go now! Go have fun with your heart's desires building what you can/please. If there's issues, never be afraid to ask for help by opening an issue.

## Building (configuring) with each build system

  * autoconfigure:
    - use `./configure --host=armv7-w64-mingw32 --prefix=/home/youruser/armmxe-unstable/usr/armv7-w64-mingw32`
  * meson: 
    - use included cross.txt and use as so - `meson --cross-file=/home/youruser/armmxe-unstable/cross.txt --prefix /home/youruser/armmxe-unstable/usr/armv7-w64-mingw32/ builddir`
  * CMake:
    - use `armv7-w64-mingw32-cmake` provided by MXE
  * normal make:
    - for projects that still use this way for some reason, use `make CC=armv7-w64-mingw32-gcc CXX=armv7-w64-mingw32-g++ LD=armv7-w64-mingw32-ld AR=armv7-w64-mingw32-ar AS=armv7-w64-mingw32-as`
  * MXE:
    - this stays the same, but instead of a host triplet being i686-w64-mingw32 or x86_64-w64-mingw32, you use armv7-w64-mingw32. basically, run `make MXE_TARGETS="armv7-w64-mingw32" package`

## Things you should probably know

When you build applications and run them on Windows on ARM (32 or 64), you'll need the UCRT files. It may be included, but some OSes (such as RT8.1) do not have it. For the ARM32 UCRT DLLs, you can snatch them [here](resources/PooCRT.tar.xz).
	
## FAQ

Q: Will this work on WSL?  \
A: Yes! I would *recommend* using Ubuntu 20.04 for this repo if you're using WSL.

Q: Do I need to have a specific distro? \
A: Nope! This is meant for any distro just like the normal MXE, this repo just comes with patches and extras for ARM development.

Q: What if I have trouble with a package while building for ARM32? \
A: You can open an issue here, or try to fix it yourself if you wanted to. We may be busy, but we will get to your issue as soon as we possibly can!

Q: What if I have more questions?? \
A: As said, don't be afraid to open an issue for help. If the question is a good one, we will put it here that way more people do not have to dig through issues for help.

Q: So what libraries don't work? (ARM question) \
A: Check [NOT-SO-WORKING-LIBRARIES](NOT-SO-WORKING-LIBRARIES.md)

Q: So what libraries DO work? (ARM question) \
A: Check [WORKING-LIBRARIES](WORKING-LIBRARIES.md)

Q: So... are we getting an RT browser? \
A: Yes..! To an extent. -ish. The quickest way to explain is that Windows RT (8/8.1) only runs things in THUMB2 mode, meaning it cannot run things such as ARM32 JIT, which makes browsing the web painfully slow. However, the leaked Windows 10 on ARM32 image has no limitations on the CPU (doesn't run in THUMB2 mode) and can run normal ARM32 code. We can build WebKit without JIT, but it is MUCH slower. The best bet is to just upgrade to Windows 10 on ARM32. It's faster, and it allows for much more opportunity, but we know not all people can or want to, so therefore we will maintain a JIT-less QtWebKit. We've got you covered, RT8.1 users! (Users wondering about just writing a JIT in THUMB2, go check [issue 1](https://github.com/armdevvel/mxe/issues/1). It's a discussion, should give a little insight as to thoughts from us.)
	
# Original README

## MXE (M cross environment)

[![License][license-badge]][license-page]

[license-page]: LICENSE.md
[license-badge]: https://img.shields.io/badge/License-MIT-brightgreen.svg

[![Async Chat (Trial))](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://mxe.zulipchat.com/)

MXE (M cross environment) is a GNU Makefile that compiles a cross
compiler and cross compiles many free libraries such as SDL and
Qt. Thus, it provides a nice cross compiling environment for
various target platforms, which:

  * is designed to run on any Unix system
  * is easy to adapt and to extend
  * builds many free libraries in addition to the cross compiler
  * can also build just a subset of the packages, and automatically builds their dependencies
  * downloads all needed packages and verifies them by their checksums
  * is able to update the version numbers of all packages automatically
  * directly uses source packages, thus ensuring the whole build mechanism is transparent
  * allows inter-package and intra-package parallel builds whenever possible
  * bundles [ccache](https://ccache.samba.org) to speed up repeated builds
  * integrates well with autotools, cmake, qmake, and hand-written makefiles.
  * has been in continuous development since 2007 and is used by several projects

## Supported Toolchains

  * Runtime: MinGW-w64
  * Host Triplets:
    - `i686-w64-mingw32`
    - `x86_64-w64-mingw32`
  * Packages:
    - static
    - shared
  * GCC Threading Libraries (`winpthreads` is always available):
    - [posix](https://github.com/mxe/mxe/pull/958) [(default)](https://github.com/mxe/mxe/issues/2258)
    - win32 (supported by limited amount packages)
  * GCC Exception Handling:
    - Default
      - i686: sjlj
      - x86_64: seh
    - [Alternatives (experimental)](https://github.com/mxe/mxe/pull/1664)
      - i686: dw2
      - x86_64: sjlj

Please see [mxe.cc](https://mxe.cc/) for further information and package support matrix.

## Shared Library Notes
There are several approaches to recursively finding DLL dependencies (alphabetical list):
  * [go script](https://github.com/desertbit/gml/blob/master/cmd/gml-copy-dlls/main.go)
  * [pe-util](https://github.com/gsauthof/pe-util) packaged with [mxe](https://github.com/mxe/mxe/blob/master/src/pe-util.mk)
  * [python script](https://github.com/mxe/mxe/blob/master/tools/copydlldeps.py)
  * [shell script](https://github.com/mxe/mxe/blob/master/tools/copydlldeps.md)
