#!/bin/bash
export VERSION=v1.7.7

# fetch latest commits
git checkout .
git pull origin master

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
docker build --build-arg version=$VERSION -t "avalanche-node-${VERSION}" .

# run container
docker stop avalanche-node && docker rm avalanche-node
docker run -d \
  -p 9651:9651 \
  -p 80:80 \
  -v $HOME/avax-data:/root/.avalanchego \
  -u ubuntu \
  --name="avalanche-node" avalanche-node-$VERSION