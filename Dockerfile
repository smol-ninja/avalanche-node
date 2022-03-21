FROM --platform=linux/amd64 ubuntu:18.04

RUN apt-get update \
    && apt-get upgrade \
    && apt-get clean

ARG VERSION
ARG UID
ARG GID
ARG UNAME=root

# RUN groupadd -g $GID -o $UNAME
# RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

WORKDIR /$UNAME/
ADD avalanchego-$VERSION avalanchego
ADD configs/node.json node.json
# RUN chown -R $UID:$GID avalanchego

# USER $UNAME

EXPOSE 9651

CMD ./avalanchego/avalanchego \
    --config-file=node.json