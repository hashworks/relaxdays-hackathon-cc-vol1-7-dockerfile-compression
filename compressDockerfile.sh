#!/bin/bash

file="$1"
zstd="zstd -D dockerfileDictionary --ultra -22"

if [[ ! -f "${file}" ]]; then
	>&2 echo "Compress: $0 /path/to/Dockerfile"
	>&2 echo "Decompress: $0 /path/to/Dockerfile.compressed"
	exit 2
fi

if [[ "${file}" == *.compressed ]]; then
	outputPath="${file%.compressed*}.decompressed"
	echo "Decompressing ${file} to ${outputPath}"
	$zstd -d "${file}" -o "${outputPath}"
else
	outputPath="${file}.compressed"
	echo "Compressing ${file} to ${outputPath}"
	perl -p -e 's/\s*(#|LABEL|MAINTAINER).*(\n|\r|\r\n)//' "${file}" | $zstd -z -o "${file}.compressed"
fi