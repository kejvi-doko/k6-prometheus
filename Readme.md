## Overview

A small local setup to test k6 with Prometheus, used to track performance indicators across multiple runs/builds.

### Prerequisites

- kind: [Install kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- kubectl: [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- Helm: [Install Helm](https://helm.sh/docs/intro/install/)

### Quick start

1. Build the k6 runner image and load it into kind:

```bash
docker build -t k6-runner:demo -f perf/Dockerfile.k6 perf
kind load docker-image k6-runner:demo --name perf
```

2. Provision Prometheus, Grafana, and the k6-operator (run from the `infrastructure` folder):

```bash
cd infrastructure
./prepare.sh
```

3. Run the test (still in the `infrastructure` folder):

```bash
./run.sh
```

4. Port-Forward Grafana

```bash
kubectl -n monitoring port-forward svc/kps-grafana 3000:80
```

5. Get Grafana Password

```bash
kubectl -n monitoring get secret kps-grafana -o jsonpath="{.data.admin-password}" | base64 -d; echo
```

Grafana uses Prometheus as a datasource to visualize k6 metrics across builds.
