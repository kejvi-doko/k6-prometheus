#!/usr/bin/env bash
set -e
kubectl apply -f namespaces.yaml

helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install kps prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f helm/prometheus/values.yaml

helm upgrade --install grafana grafana/grafana \
  -n monitoring \
  -f helm/grafana/values.yaml

helm upgrade --install k6-operator grafana/k6-operator \
  -n k6-operator \
  -f helm/k6-operator/values.yaml