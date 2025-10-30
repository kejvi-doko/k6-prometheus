#!/usr/bin/env bash
set -e

kubectl -n k6-operator delete testrun timesheets-load --ignore-not-found

BUILD_TAG=demo-002 envsubst < testrun-timesheets.yaml | kubectl apply -f -