```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

```bash
helm upgrade --install kps prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f infrastructure/helm/prometheus/values.yaml
```

```bash
helm upgrade --install grafana grafana/grafana -n monitoring -f infrastructure/helm/grafana/values.yaml
```

```bash
helm upgrade --install k6-operator grafana/k6-operator \
  -n k6-operator \
  -f infrastructure/helm/k6-operator/values.yaml
```

```bash
docker build -t k6-runner:demo -f perf/Dockerfile.k6 perf
kind load docker-image k6-runner:demo --name perf
```

```bash
kubectl -n k6-operator delete testrun timesheets-load --ignore-not-found

BUILD_TAG=demo-002 envsubst < testrun-timesheets.yaml | kubectl apply -f -
```

##GetToken##

```bash
kubectl -n monitoring get secret kps-grafana -o jsonpath="{.data.admin-password}" | base64 -d; echo
```
