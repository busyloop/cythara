#!/bin/bash

set -e

VERSION=$(git describe --tags | cut -c 2-)

cat <<EOF
v${VERSION}
EOF
