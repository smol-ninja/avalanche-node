#!/bin/bash

export VERSION=v1.9.0

# Download binary
if [ -d "avalanchego-${VERSION}" ]
then
  echo "version ${VERSION} already exists"
else
  echo "downloading new version ${VERSION}"
  wget https://github.com/ava-labs/avalanchego/releases/download/$VERSION/avalanchego-linux-amd64-$VERSION.tar.gz
  tar -xvf avalanchego-linux-amd64-$VERSION.tar.gz
  rm avalanchego-linux-amd64-$VERSION.tar.gz
fi

# build docker image
docker build \
  --build-arg VERSION=$VERSION \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  -t "avalanche-node-${VERSION}" .

# run container
docker stop avalanche-node && docker rm avalanche-node
docker run -d \
  -p 9651:9651 \
  -p 80:80 \
  -v $HOME/avax-data:/root/.avalanchego \
  -v $HOME/offline-pruning:/root/offline-pruning \
  --name="avalanche-node" avalanche-node-$VERSION
