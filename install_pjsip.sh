#!/bin/sh


# clone lastest pjsip source
if [ ! -d pjproject ];then
    git clone https://github.com/pjsip/pjproject.git
fi


cd pjproject

# build and install
JOBS=8
export CFLAGS="-fPIC"
./configure  \
    --disable-libuuid \
    --disable-gsm-codec \
    --disable-speex-codec --disable-speex-aec \
    --disable-l16-codec \
    --disable-g722-codec \
    --disable-g7221-codec \
    --disable-ilbc-codec \
    --disable-bcg729 \
    --disable-silk \
    --disable-video \
    --disable-libwebrtc \
    --disable-sound \
    --disable-ssl \
    --disable-libsrtp \
    --disable-upnp \
    --disable-opus

make dep
make -j $JOBS
sudo make install


cd -
