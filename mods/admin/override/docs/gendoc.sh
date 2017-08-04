#!/bin/bash

DOCS="$(dirname $(readlink -f $0))"
ROOT="$(dirname ${DOCS})"

CONFIG="${DOCS}/config.ld"
OUT="${DOCS}"

cd "${ROOT}"

# Clean old files
rm -rf "${OUT}/index.html" "${OUT}/modules" "${OUT}/scripts"
# Create new files
ldoc -c "${CONFIG}" -d "${OUT}" "${ROOT}"
