FROM --platform=linux/amd64 ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade && \
    apt-get clean

ARG version
EXPOSE 9651

ADD avalanchego-$version /avalanchego

CMD ./avalanchego/avalanchego \
    --http-host=0.0.0.0 \
    --http-port=80 \
    --staking-port=9651 \
    --staking-enabled=true