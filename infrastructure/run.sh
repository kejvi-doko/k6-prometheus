#!/usr/bin/env bash
set -e

kubectl -n k6-operator delete testrun timesheets-load --ignore-not-found

# Usage: ./run.sh [BUILD_TAG]
# If BUILD_TAG is not provided, generate a random one.
BUILD_TAG_INPUT="$1"
if [ -z "$BUILD_TAG_INPUT" ]; then
  # random tag: build-YYYYmmdd-HHMMSS-<4hex>
  BUILD_TAG="build-$(date +%Y%m%d-%H%M%S)-$(openssl rand -hex 2 2>/dev/null || echo rnd)"
else
  BUILD_TAG="$BUILD_TAG_INPUT"
fi

echo "Using BUILD_TAG=${BUILD_TAG}"

BUILD_TAG="$BUILD_TAG" envsubst < testrun-timesheets.yaml | kubectl apply -f -