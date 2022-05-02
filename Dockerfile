FROM --platform=linux/amd64 ubuntu:18.04

RUN apt-get update \
    && apt-get upgrade \
    && apt-get clean

ARG VERSION
ARG UNAME=root

WORKDIR /$UNAME/
ADD avalanchego-$VERSION avalanchego
ADD configs/node.json node.json

# for c-chain pruning
RUN mkdir -p chain-configs/C
ADD configs/c-chain.json chain-configs/C/config.json

EXPOSE 9651

CMD ./avalanchego/avalanchego \
    --config-file=node.json \
    --chain-config-dir=chain-configs