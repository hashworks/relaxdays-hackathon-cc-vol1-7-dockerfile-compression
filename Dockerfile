FROM debian:buster-slim

RUN apt-get update && apt-get install -y zstd && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

COPY dockerfileDictionary ./
COPY compressDockerfile.sh ./

ENTRYPOINT ["/bin/bash", "./compressDockerfile.sh"]