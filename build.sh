#! /bin/sh
set -e

# NOTE
# build script for cli interface with cross-compile environment
#		for arm 	: ./build.sh arm
#		for amd64 	: ./build.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

export BINARY_NAME="agent"	#fixed~~~~~

export CONTAINER_VERSION=":v1.1"

if [ "$1" = "arm" ]; then
        echo "****************************"
		echo "Target Binary arch is ARM"
		echo "****************************"
        export CGO_ENABLED=1
        export GOARCH=arm GOARM=7
        export CC="arm-linux-gnueabi-gcc"
        export CONTAINER_NAME="dockzen-agent-arm"
        export CGO_LDFLAGS="-L${PWD}/src/lib/install/arm/lib"
else
		echo "****************************"
		echo "Target Binary arch is amd64"
		echo "****************************"
        export GOARCH=amd64
	export CGO_ENABLED=1
        export CC="gcc"
        export CONTAINER_NAME="dockzen-agent"
        export CGO_LDFLAGS="-L${PWD}/src/lib/install/amd64/lib"
fi

echo make clean
make clean

echo make build
make build

