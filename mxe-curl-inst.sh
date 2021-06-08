echo "Clone MXE from my source that way ARM is included :)"
git clone https://github.com/armdevvel/mxe --depth=1
echo "Install all necessary packages! -- Ubuntu distros"
sudo apt-get install \
    autoconf \
    automake \
    autopoint \
    bash \
    bison \
    bzip2 \
    flex \
    g++ \
    g++-multilib \
    gettext \
    git \
    gperf \
    intltool \
    libc6-dev-i386 \
    libgdk-pixbuf2.0-dev \
    libltdl-dev \
    libssl-dev \
    libtool-bin \
    libxml-parser-perl \
    lzip \
    make \
    openssl \
    p7zip-full \
    patch \
    perl \
    python \
    ruby \
    sed \
    unzip \
    wget \
    xz-utils
echo "cd mxe!"
cd mxe
echo "Download LLVM-MinGW!"
mkdir usr && cd usr && wget https://github.com/armdevvel/llvm-mingw/releases/download/12.0/llvm-mingw-20210423-ucrt-ubuntu-18.04-x86_64-fixed.tar.gz
echo "Extract LLVM-MinGW!"
tar -xf llvm-mingw-20210423-ucrt-ubuntu-18.04-x86_64-fixed.tar.gz
echo "Setup known packages that work! This may take a while... Hold on tight!~"
cd .. && make MXE_TARGETS="armv7-w64-mingw32" libpng cmake sdl2 sdl tiff jpeg ccache lame libxml++ libxml2 libxslt libyaml libzip libwebp libusb1 sdl_image sdl_mixer sdl2_mixer zlib yasm dbus pcre boost icu4c
echo "Finished! Be sure to add /home/$USER/mxe/usr/bin to your path!"