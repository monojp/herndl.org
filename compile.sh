#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

readonly DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly BODY=$(markdown "${DIR}/index.md")
readonly DIST_DIR="dist/"

readonly OUTPUT_FILE="${DIR}/dist/index.html"

rm -rf "${DIST_DIR}"
mkdir "${DIST_DIR}"

cat "${DIR}/template_before.html" > "${OUTPUT_FILE}"
echo "${BODY}" >> "${OUTPUT_FILE}"
cat "${DIR}/template_after.html" >> "${OUTPUT_FILE}"
tidy -modify "${OUTPUT_FILE}"

cp assets/images/* "${DIST_DIR}"
find assets -maxdepth 1 -type f -exec cp -t "${DIST_DIR}" {} +

