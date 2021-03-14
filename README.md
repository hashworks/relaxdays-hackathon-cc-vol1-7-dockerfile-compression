# relaxdays-hackathon-cc-vol1-7-dockerfile-compress

This project was created in the Relaxdays Code Challenge Vol. 1. See https://sites.google.com/relaxdays.de/hackathon-relaxdays/startseite for more information. My participant ID in the challenge was: CC-VOL1-7

## How to run this project

You can build an image of this project with:

```bash
git clone https://github.com/hashworks/relaxdays-hackathon-cc-vol1-7-dockerfile-compress.git
cd relaxdays-hackathon-cc-vol1-7-dockerfile-compress
docker build -t relaxdays-hackathon-cc-vol1-7-dockerfile-compress .
```

To compress:
```bash
docker run -v "$(pwd)/output:/output" relaxdays-hackathon-cc-vol1-7-dockerfile-compress /output/Dockerfile
```

To decompress:
```bash
docker run -v "$(pwd)/output:/output" relaxdays-hackathon-cc-vol1-7-dockerfile-compress /output/Dockerfile.compressed
```

## About

The basic theory is that we can ignore some parts of Dockerfiles completely (f.e. Comments, `LABEL`, `MAINTAINER`), can tokenize a lot of reoccurring stuff (`FROM`, `COPY`, `RUN`, `RUN apt-get`, etc…) and compress the rest with standard compression algorithms.

Instead of manually choosing tokens one can train a [zstd dictionary](https://github.com/facebook/zstd#the-case-for-small-data-compression) with a large amount of Dockerfiles.

In a [paper from 2020](https://pages.cs.wisc.edu/~jjhenkel/papers/data-showcase-docker.pdf) a large dataset of Dockerfiles from GitHub was created, consisting [of 178506 files](https://zenodo.org/record/3628771/preview/binnacle-icse2020-1.0.0.zip#tree_item11).

Using this data a zstd dictionary was created which is used in the provided image:

```bash
zstd --ultra -22 --maxdict=1293836 --train -r /tmp/3628771/github/deduplicated-sources/ -o dockerfileDictionary
```

![is this big data?](https://i.imgflip.com/51mmq2.jpg)