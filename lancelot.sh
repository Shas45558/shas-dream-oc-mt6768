#!/bin/bash

echo "Hi lancelot user just wait and watch "

mkdir outL
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
make O=outL ARCH=arm64 lancelot_defconfig
export PATH="${PWD}/bin:${PWD}/toolchain/bin:${PWD}/toolchain32/bin:${PATH}"
make -j$(nproc --all) O=outL \
                       ARCH=arm64 \
                       CC=clang \
                       CLANG_TRIPLE=aarch64-linux-gnu- \
                       CROSS_COMPILE=aarch64-linux-android- \
                       CROSS_COMPILE_ARM32=arm-linux-androideabi-
bp=${PWD}/outL
DATE=$(date "+%Y%m%d-%H%M")
ZIPNAME="Shas-Dream-Lancelot-Q-vendor"
cd ${PWD}/AnyKernel3-master
rm *.zip *-dtb *dtbo.img
cp $bp/arch/arm64/boot/Image.gz-dtb .
cp $bp/arch/arm64/boot/dtbo.img .
zip -r9 "$ZIPNAME"-"${DATE}".zip *
cd - || exit
