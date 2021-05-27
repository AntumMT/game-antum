#!/bin/bash

DOCS="$(dirname $(readlink -f $0))"
ROOT="$(dirname ${DOCS})"

CONFIG="${DOCS}/config.ld"

cd "${ROOT}"
rm -rf "${DOCS}/reference"
ldoc -B -c "${CONFIG}" -d "${DOCS}/reference" ./
