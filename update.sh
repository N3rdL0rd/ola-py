#!/bin/bash

rm -Rf examples/
rm -Rf ola/
tmp=$(mktemp -d)
git clone https://github.com/OpenLightingProject/ola $tmp
pushd $tmp
    protoc --python_out=python/ola -I plugins/artnet/messages plugins/artnet/messages/ArtNetConfigMessages.proto
    protoc --python_out=python/ola -I common/protocol common/protocol/Ola.proto
    protoc --python_out=python/ola -I common/rdm common/rdm/Pids.proto
    protoc --python_out=python/ola/rpc -I common/rpc common/rpc/Rpc.proto
    protoc --python_out=python/ola -I plugins/usbpro/messages plugins/usbpro/messages/UsbProConfigMessages.proto
popd
cp -r $tmp/python/examples/ .
cp -r $tmp/python/ola/ .
rm -Rf $tmp
rm -f examples/Makefile*
rm -f ola/Makefile*
